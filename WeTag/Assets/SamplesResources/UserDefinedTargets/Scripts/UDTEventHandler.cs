/*============================================================================== 
 Copyright (c) 2016 PTC Inc. All Rights Reserved.
 
 Copyright (c) 2015 Qualcomm Connected Experiences, Inc. All Rights Reserved. 
 * ==============================================================================*/
using UnityEngine;
using UnityEngine.UI;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Vuforia;

using UnityEngine.Networking;

public class UDTEventHandler : MonoBehaviour, IUserDefinedTargetEventHandler
{
	#region PUBLIC_MEMBERS
	/// <summary>
	/// Can be set in the Unity inspector to reference a ImageTargetBehaviour that is instanciated for augmentations of new user defined targets.
	/// </summary>
	public ImageTargetBehaviour ImageTargetTemplate;


	private WeTagHandler wetag;

    private Dictionary<string, string> celebrityTags = new Dictionary<string, string>();

    public GameObject tagPlane;

	public int LastTargetIndex
	{
		get { return (mTargetCounter - 1) % MAX_TARGETS; }
	}
	#endregion PUBLIC_MEMBERS


	#region PRIVATE_MEMBERS
	private const int MAX_TARGETS = 5;
	private UserDefinedTargetBuildingBehaviour mTargetBuildingBehaviour;
	private QualityDialog mQualityDialog;
	private ObjectTracker mObjectTracker;

	private bool mFormatRegistered = false;

	// DataSet that newly defined targets are added to
	private DataSet mBuiltDataSet;

	// Currently observed frame quality
	private ImageTargetBuilder.FrameQuality mFrameQuality = ImageTargetBuilder.FrameQuality.FRAME_QUALITY_NONE;

	// Counter used to name newly created targets
	private int mTargetCounter;

	private TrackableSettings mTrackableSettings;
	#endregion //PRIVATE_MEMBERS


	#region MONOBEHAVIOUR_METHODS
	public void Start()
	{

		tagPlane = GameObject.FindWithTag("TagPlane");

		wetag = GetComponent<WeTagHandler>();
		//popUpText = GameObject.FindWithTag("PopupText") as GUIText;
		mTargetBuildingBehaviour = GetComponent<UserDefinedTargetBuildingBehaviour>();
		if (mTargetBuildingBehaviour)
		{
			mTargetBuildingBehaviour.RegisterEventHandler(this);
			Debug.Log("Registering User Defined Target event handler.");
		}

		mTrackableSettings = FindObjectOfType<TrackableSettings>();
		mQualityDialog = FindObjectOfType<QualityDialog>();
		if (mQualityDialog)
		{
			mQualityDialog.gameObject.SetActive(false);
		}

		VuforiaARController.Instance.RegisterVuforiaStartedCallback(OnVuforiaStarted);

	}
	#endregion //MONOBEHAVIOUR_METHODS


	#region IUserDefinedTargetEventHandler implementation
	/// <summary>
	/// Called when UserDefinedTargetBuildingBehaviour has been initialized successfully
	/// </summary>
	public void OnInitialized()
	{
		mObjectTracker = TrackerManager.Instance.GetTracker<ObjectTracker>();
		if (mObjectTracker != null)
		{
			// Create a new dataset
			mBuiltDataSet = mObjectTracker.CreateDataSet();
			mObjectTracker.ActivateDataSet(mBuiltDataSet);
		}

	}



	/// <summary>
	/// Updates the current frame quality
	/// </summary>
	public void OnFrameQualityChanged(ImageTargetBuilder.FrameQuality frameQuality)
	{
		//Debug.Log("Frame quality changed: " + frameQuality.ToString());
		mFrameQuality = frameQuality;
		if (mFrameQuality == ImageTargetBuilder.FrameQuality.FRAME_QUALITY_LOW)
		{

			//Debug.Log("Low camera image quality");
		}
	}

	/// <summary>
	/// Takes a new trackable source and adds it to the dataset
	/// This gets called automatically as soon as you 'BuildNewTarget with UserDefinedTargetBuildingBehaviour
	/// </summary>
	public void OnNewTrackableSource(TrackableSource trackableSource)
	{
		mTargetCounter++;

		// Deactivates the dataset first
		mObjectTracker.DeactivateDataSet(mBuiltDataSet);

		// Destroy the oldest target if the dataset is full or the dataset 
		// already contains five user-defined targets.
		if (mBuiltDataSet.HasReachedTrackableLimit() || mBuiltDataSet.GetTrackables().Count() >= MAX_TARGETS)
		{
			IEnumerable<Trackable> trackables = mBuiltDataSet.GetTrackables();
			Trackable oldest = null;
			foreach (Trackable trackable in trackables)
			{
				if (oldest == null || trackable.ID < oldest.ID)
					oldest = trackable;
			}

			if (oldest != null)
			{
				Debug.Log("Destroying oldest trackable in UDT dataset: " + oldest.Name);
				mBuiltDataSet.Destroy(oldest, true);
			}
		}

		// Get predefined trackable and instantiate it
		ImageTargetBehaviour imageTargetCopy = (ImageTargetBehaviour)Instantiate(ImageTargetTemplate);
		imageTargetCopy.gameObject.name = "UserDefinedTarget-" + mTargetCounter;

		// Add the duplicated trackable to the data set and activate it
		mBuiltDataSet.CreateTrackable(trackableSource, imageTargetCopy.gameObject);

		// Activate the dataset again
		mObjectTracker.ActivateDataSet(mBuiltDataSet);

		// Extended Tracking with user defined targets only works with the most recently defined target.
		// If tracking is enabled on previous target, it will not work on newly defined target.
		// Don't need to call this if you don't care about extended tracking.
		StopExtendedTracking();
		mObjectTracker.Stop();
		mObjectTracker.ResetExtendedTracking();
		mObjectTracker.Start();

		// Make sure TargetBuildingBehaviour keeps scanning...
		mTargetBuildingBehaviour.StartScanning();
	}
	#endregion IUserDefinedTargetEventHandler implementation


	#region PUBLIC_METHODS
	/// <summary>
	/// Instantiates a new user-defined target and is also responsible for dispatching callback to 
	/// IUserDefinedTargetEventHandler::OnNewTrackableSource
	/// </summary>
	public void BuildNewTarget()
	{
		clearTags();


		if (mFrameQuality == ImageTargetBuilder.FrameQuality.FRAME_QUALITY_MEDIUM ||
			mFrameQuality == ImageTargetBuilder.FrameQuality.FRAME_QUALITY_HIGH)
		{
			// create the name of the next target.
			// the TrackableName of the original, linked ImageTargetBehaviour is extended with a continuous number to ensure unique names
			string targetName = string.Format("{0}-{1}", ImageTargetTemplate.TrackableName, mTargetCounter);

			// generate a new target:
			mTargetBuildingBehaviour.BuildNewTarget(targetName, ImageTargetTemplate.GetSize().x);

            if (wetag.isRecognizing)
            {
                return;
            }
            wetag.isRecognizing = true;

			StartCoroutine(wetag.RecognizeObject(OnRecognizeFinish));
		}
		else
		{
			Debug.Log("Cannot build new target, due to poor camera image quality");

            wetag.showNoRecogItemDialog("Cannot build new target, due to poor camera image quality", "Low Quality Image");
            wetag.WeTagCanvas.transform.Find("InfoTitle").gameObject.SetActive(false);
            //if (mQualityDialog)
			//{
			//	mQualityDialog.gameObject.SetActive(true);
			//}
		}
	}

	public void CloseQualityDialog()
	{
		//if (mQualityDialog)
			//mQualityDialog.gameObject.SetActive(false);
	}


	public void clearTags()
	{
		Debug.Log("Clear tags");
		foreach (var kv in celebrityTags)
		{
            Debug.Log("Clearing " + kv.Key);
            Destroy(GameObject.Find(kv.Value));
		}
		celebrityTags.Clear();

		wetag.isDetailShown = false;
	}
	#endregion //PUBLIC_METHODS


	#region PRIVATE_METHODS


	private void OnRecognizeFinish(Result res)
	{
		if (res != null)
		{
            var array = wetag.tagOption == TagOption.Celebrity ? res.celebrities : res.landmarks;
            var recogItemMap = new Dictionary<string, RecogItem>();
            if( array.Length == 0 ){
                wetag.showNoRecogItemDialog("Cannot recognize any " + (wetag.tagOption == TagOption.Celebrity ? "celebrities" : "landmarks"));
                wetag.WeTagCanvas.transform.Find("InfoTitle").gameObject.SetActive(false);
            }else{
	            foreach (RecogItem item in array)
	            {
	                // create a new text on (left, top) of item.faceRect
	                recogItemMap[item.name] = item;
				}
				updateTags(recogItemMap);
            }
			wetag.isRecognizing = false;
		}
	}

    private void onTapTag(string name){
        Debug.Log("OnTap " + name);
        //StartCoroutine(wetag.SearchWiki(name));
    }

	private void OnVuforiaStarted()
	{

        // Vuforia has started, now register camera image format

        var Formats = new Vuforia.Image.PIXEL_FORMAT[2] { Vuforia.Image.PIXEL_FORMAT.RGB888, Vuforia.Image.PIXEL_FORMAT.RGBA8888 };

        foreach (var format in Formats){

			if (CameraDevice.Instance.SetFrameFormat(format, true))
			{
                
				Debug.Log("Successfully registered pixel format " + format.ToString());

				mFormatRegistered = true;
                WeTagHandler.mPixelFormat = format;
                return;
			}
			else
			{
				Debug.LogError(
					"Failed to register pixel format " + format.ToString() +
					"\n the format may be unsupported by your device;" +
					"\n consider using a different pixel format.");

				mFormatRegistered = false;
			}
        }

	}


    private void updateTags(Dictionary<string, RecogItem> recogItemMap)
	{
        Debug.Log("In update Tags");
		foreach (var kv in recogItemMap)
		{
			RecogItem item = kv.Value;
			//if (celebrityTags.ContainsKey(item.name))
			    //Destroy(GameObject.Find(celebrityTags[item.name]));
            
			//Ray ray = Camera.main.ScreenPointToRay(new Vector3(item.faceRectangle.left, Screen.height - item.faceRectangle.top));
			Quaternion quat = Quaternion.Euler(90, 0, 0);
            
			Ray ray = Camera.main.ScreenPointToRay(new Vector3(item.faceRectangle.left + item.faceRectangle.width / 2, Screen.height - (item.faceRectangle.top + item.faceRectangle.height / 2)));
			
			Debug.Log("RecogItem.name = " + kv.Key);
			RaycastHit hit;
			if (Physics.Raycast(ray, out hit, Camera.main.farClipPlane) && hit.collider.tag == tagPlane.tag)
			{  
				Vector3 hitPoint = ray.GetPoint(hit.distance);
				hitPoint.y = 0;
				var newTag = Instantiate(wetag.celebrityTag, hitPoint, quat);
				newTag.name = "Tag_" + celebrityTags.Count() + 1;
				Debug.Log("Instantiating " + newTag.name);
				newTag.transform.parent = gameObject.transform;

				newTag.GetComponentInChildren<TextMesh>().text = item.name;

				newTag.transform.localScale /= 2;

                var background = newTag.gameObject.transform.Find("TagBackground");
                Debug.Log("origin scale = " + background.localScale.x + ", " + item.name.Length);
                background.localScale += new Vector3(0.002f * item.name.Length, 0, 0);
				//background.localScale.Scale(new Vector3(item.name.Length, 1, 1));
				Debug.Log("after scale = " + background.localScale.x);
				//newTag.transform.LookAt(Camera.main.transform);
				celebrityTags[item.name] = newTag.name;

                wetag.DrawConnectingLines(item.faceRectangle);
			}
		}
	}

	/// <summary>
	/// This method only demonstrates how to handle extended tracking feature when you have multiple targets in the scene
	/// So, this method could be removed otherwise
	/// </summary>
	private void StopExtendedTracking()
	{
		// If Extended Tracking is enabled, we first disable it for all the trackables
		// and then enable it only for the newly created target
		bool extTrackingEnabled = mTrackableSettings && mTrackableSettings.IsExtendedTrackingEnabled();
		if (extTrackingEnabled)
		{
			StateManager stateManager = TrackerManager.Instance.GetStateManager();

			// 1. Stop extended tracking on all the trackables
			foreach (var tb in stateManager.GetTrackableBehaviours())
			{
				var itb = tb as ImageTargetBehaviour;
				if (itb != null)
				{
					itb.ImageTarget.StopExtendedTracking();
				}
			}

			// 2. Start Extended Tracking on the most recently added target
			List<TrackableBehaviour> trackableList = stateManager.GetTrackableBehaviours().ToList();
			ImageTargetBehaviour lastItb = trackableList[LastTargetIndex] as ImageTargetBehaviour;
			if (lastItb != null)
			{
				if (lastItb.ImageTarget.StartExtendedTracking())
					Debug.Log("Extended Tracking successfully enabled for " + lastItb.name);
			}
		}
	}



	#endregion //PRIVATE_METHODS
}




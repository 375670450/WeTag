using UnityEngine;
using System.Collections;

public class CameraController : MonoBehaviour {
	
	// Update is called once per frame
	void Update () {
		transform.Rotate(0f,8f*Time.deltaTime,0f);
	}
}

#pragma once

#include "il2cpp-config.h"

#ifndef _MSC_VER
# include <alloca.h>
#else
# include <malloc.h>
#endif

#include <stdint.h>

#include "UnityEngine_UnityEngine_MonoBehaviour1158329972.h"
#include "Vuforia_UnityExtensions_Vuforia_ImageTargetBuilder2061101710.h"

// Vuforia.ImageTargetBehaviour
struct ImageTargetBehaviour_t2654589389;
// WeTagHandler
struct WeTagHandler_t1469443048;
// System.Collections.Generic.Dictionary`2<System.String,System.String>
struct Dictionary_2_t3943999495;
// UnityEngine.GameObject
struct GameObject_t1756533147;
// Vuforia.UserDefinedTargetBuildingBehaviour
struct UserDefinedTargetBuildingBehaviour_t4184040062;
// QualityDialog
struct QualityDialog_t1435260315;
// Vuforia.ObjectTracker
struct ObjectTracker_t1568044035;
// Vuforia.DataSet
struct DataSet_t626511550;
// TrackableSettings
struct TrackableSettings_t4265251850;




#ifdef __clang__
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Winvalid-offsetof"
#pragma clang diagnostic ignored "-Wunused-variable"
#endif

// UDTEventHandler
struct  UDTEventHandler_t3117429239  : public MonoBehaviour_t1158329972
{
public:
	// Vuforia.ImageTargetBehaviour UDTEventHandler::ImageTargetTemplate
	ImageTargetBehaviour_t2654589389 * ___ImageTargetTemplate_2;
	// WeTagHandler UDTEventHandler::wetag
	WeTagHandler_t1469443048 * ___wetag_3;
	// System.Collections.Generic.Dictionary`2<System.String,System.String> UDTEventHandler::celebrityTags
	Dictionary_2_t3943999495 * ___celebrityTags_4;
	// UnityEngine.GameObject UDTEventHandler::tagPlane
	GameObject_t1756533147 * ___tagPlane_5;
	// Vuforia.UserDefinedTargetBuildingBehaviour UDTEventHandler::mTargetBuildingBehaviour
	UserDefinedTargetBuildingBehaviour_t4184040062 * ___mTargetBuildingBehaviour_7;
	// QualityDialog UDTEventHandler::mQualityDialog
	QualityDialog_t1435260315 * ___mQualityDialog_8;
	// Vuforia.ObjectTracker UDTEventHandler::mObjectTracker
	ObjectTracker_t1568044035 * ___mObjectTracker_9;
	// System.Boolean UDTEventHandler::mFormatRegistered
	bool ___mFormatRegistered_10;
	// Vuforia.DataSet UDTEventHandler::mBuiltDataSet
	DataSet_t626511550 * ___mBuiltDataSet_11;
	// Vuforia.ImageTargetBuilder/FrameQuality UDTEventHandler::mFrameQuality
	int32_t ___mFrameQuality_12;
	// System.Int32 UDTEventHandler::mTargetCounter
	int32_t ___mTargetCounter_13;
	// TrackableSettings UDTEventHandler::mTrackableSettings
	TrackableSettings_t4265251850 * ___mTrackableSettings_14;

public:
	inline static int32_t get_offset_of_ImageTargetTemplate_2() { return static_cast<int32_t>(offsetof(UDTEventHandler_t3117429239, ___ImageTargetTemplate_2)); }
	inline ImageTargetBehaviour_t2654589389 * get_ImageTargetTemplate_2() const { return ___ImageTargetTemplate_2; }
	inline ImageTargetBehaviour_t2654589389 ** get_address_of_ImageTargetTemplate_2() { return &___ImageTargetTemplate_2; }
	inline void set_ImageTargetTemplate_2(ImageTargetBehaviour_t2654589389 * value)
	{
		___ImageTargetTemplate_2 = value;
		Il2CppCodeGenWriteBarrier(&___ImageTargetTemplate_2, value);
	}

	inline static int32_t get_offset_of_wetag_3() { return static_cast<int32_t>(offsetof(UDTEventHandler_t3117429239, ___wetag_3)); }
	inline WeTagHandler_t1469443048 * get_wetag_3() const { return ___wetag_3; }
	inline WeTagHandler_t1469443048 ** get_address_of_wetag_3() { return &___wetag_3; }
	inline void set_wetag_3(WeTagHandler_t1469443048 * value)
	{
		___wetag_3 = value;
		Il2CppCodeGenWriteBarrier(&___wetag_3, value);
	}

	inline static int32_t get_offset_of_celebrityTags_4() { return static_cast<int32_t>(offsetof(UDTEventHandler_t3117429239, ___celebrityTags_4)); }
	inline Dictionary_2_t3943999495 * get_celebrityTags_4() const { return ___celebrityTags_4; }
	inline Dictionary_2_t3943999495 ** get_address_of_celebrityTags_4() { return &___celebrityTags_4; }
	inline void set_celebrityTags_4(Dictionary_2_t3943999495 * value)
	{
		___celebrityTags_4 = value;
		Il2CppCodeGenWriteBarrier(&___celebrityTags_4, value);
	}

	inline static int32_t get_offset_of_tagPlane_5() { return static_cast<int32_t>(offsetof(UDTEventHandler_t3117429239, ___tagPlane_5)); }
	inline GameObject_t1756533147 * get_tagPlane_5() const { return ___tagPlane_5; }
	inline GameObject_t1756533147 ** get_address_of_tagPlane_5() { return &___tagPlane_5; }
	inline void set_tagPlane_5(GameObject_t1756533147 * value)
	{
		___tagPlane_5 = value;
		Il2CppCodeGenWriteBarrier(&___tagPlane_5, value);
	}

	inline static int32_t get_offset_of_mTargetBuildingBehaviour_7() { return static_cast<int32_t>(offsetof(UDTEventHandler_t3117429239, ___mTargetBuildingBehaviour_7)); }
	inline UserDefinedTargetBuildingBehaviour_t4184040062 * get_mTargetBuildingBehaviour_7() const { return ___mTargetBuildingBehaviour_7; }
	inline UserDefinedTargetBuildingBehaviour_t4184040062 ** get_address_of_mTargetBuildingBehaviour_7() { return &___mTargetBuildingBehaviour_7; }
	inline void set_mTargetBuildingBehaviour_7(UserDefinedTargetBuildingBehaviour_t4184040062 * value)
	{
		___mTargetBuildingBehaviour_7 = value;
		Il2CppCodeGenWriteBarrier(&___mTargetBuildingBehaviour_7, value);
	}

	inline static int32_t get_offset_of_mQualityDialog_8() { return static_cast<int32_t>(offsetof(UDTEventHandler_t3117429239, ___mQualityDialog_8)); }
	inline QualityDialog_t1435260315 * get_mQualityDialog_8() const { return ___mQualityDialog_8; }
	inline QualityDialog_t1435260315 ** get_address_of_mQualityDialog_8() { return &___mQualityDialog_8; }
	inline void set_mQualityDialog_8(QualityDialog_t1435260315 * value)
	{
		___mQualityDialog_8 = value;
		Il2CppCodeGenWriteBarrier(&___mQualityDialog_8, value);
	}

	inline static int32_t get_offset_of_mObjectTracker_9() { return static_cast<int32_t>(offsetof(UDTEventHandler_t3117429239, ___mObjectTracker_9)); }
	inline ObjectTracker_t1568044035 * get_mObjectTracker_9() const { return ___mObjectTracker_9; }
	inline ObjectTracker_t1568044035 ** get_address_of_mObjectTracker_9() { return &___mObjectTracker_9; }
	inline void set_mObjectTracker_9(ObjectTracker_t1568044035 * value)
	{
		___mObjectTracker_9 = value;
		Il2CppCodeGenWriteBarrier(&___mObjectTracker_9, value);
	}

	inline static int32_t get_offset_of_mFormatRegistered_10() { return static_cast<int32_t>(offsetof(UDTEventHandler_t3117429239, ___mFormatRegistered_10)); }
	inline bool get_mFormatRegistered_10() const { return ___mFormatRegistered_10; }
	inline bool* get_address_of_mFormatRegistered_10() { return &___mFormatRegistered_10; }
	inline void set_mFormatRegistered_10(bool value)
	{
		___mFormatRegistered_10 = value;
	}

	inline static int32_t get_offset_of_mBuiltDataSet_11() { return static_cast<int32_t>(offsetof(UDTEventHandler_t3117429239, ___mBuiltDataSet_11)); }
	inline DataSet_t626511550 * get_mBuiltDataSet_11() const { return ___mBuiltDataSet_11; }
	inline DataSet_t626511550 ** get_address_of_mBuiltDataSet_11() { return &___mBuiltDataSet_11; }
	inline void set_mBuiltDataSet_11(DataSet_t626511550 * value)
	{
		___mBuiltDataSet_11 = value;
		Il2CppCodeGenWriteBarrier(&___mBuiltDataSet_11, value);
	}

	inline static int32_t get_offset_of_mFrameQuality_12() { return static_cast<int32_t>(offsetof(UDTEventHandler_t3117429239, ___mFrameQuality_12)); }
	inline int32_t get_mFrameQuality_12() const { return ___mFrameQuality_12; }
	inline int32_t* get_address_of_mFrameQuality_12() { return &___mFrameQuality_12; }
	inline void set_mFrameQuality_12(int32_t value)
	{
		___mFrameQuality_12 = value;
	}

	inline static int32_t get_offset_of_mTargetCounter_13() { return static_cast<int32_t>(offsetof(UDTEventHandler_t3117429239, ___mTargetCounter_13)); }
	inline int32_t get_mTargetCounter_13() const { return ___mTargetCounter_13; }
	inline int32_t* get_address_of_mTargetCounter_13() { return &___mTargetCounter_13; }
	inline void set_mTargetCounter_13(int32_t value)
	{
		___mTargetCounter_13 = value;
	}

	inline static int32_t get_offset_of_mTrackableSettings_14() { return static_cast<int32_t>(offsetof(UDTEventHandler_t3117429239, ___mTrackableSettings_14)); }
	inline TrackableSettings_t4265251850 * get_mTrackableSettings_14() const { return ___mTrackableSettings_14; }
	inline TrackableSettings_t4265251850 ** get_address_of_mTrackableSettings_14() { return &___mTrackableSettings_14; }
	inline void set_mTrackableSettings_14(TrackableSettings_t4265251850 * value)
	{
		___mTrackableSettings_14 = value;
		Il2CppCodeGenWriteBarrier(&___mTrackableSettings_14, value);
	}
};

#ifdef __clang__
#pragma clang diagnostic pop
#endif

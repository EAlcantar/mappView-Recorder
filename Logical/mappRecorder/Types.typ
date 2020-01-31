(*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*)
(*Global enumerations*)

TYPE
	datSTATE : 
		( (*Recorder managment state machine*)
		DAT_WAIT,
		DAT_REG_VAR,
		DAT_READ_DIR,
		DAT_READ_DIR_1,
		DAT_READ_DIR_2,
		DAT_READ_DIR_3,
		DAT_RECORD,
		DAT_DELETE,
		DAT_VIEW,
		DAT_DOWNLOAD,
		DAT_DOWNLOAD_1,
		DAT_DOWNLOAD_2,
		DAT_DOWNLOAD_3,
		DAT_DOWNLOAD_4,
		DAT_ERROR
		);
END_TYPE

(*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*)
(*Global structure*)

TYPE
	datERR : 	STRUCT  (*Recorder managment error structure*)
		Text : WSTRING[200]; (* Error text *)
		No : DINT; (* Error number *)
		State : datSTATE; (* Error step *)
	END_STRUCT;
	datCMD : 	STRUCT  (*Recorder managment command structure*)
		Init : BOOL := TRUE; (*Initialize recorder structure*)
		Record : BOOL; (*Enable recording*)
		Trigger : BOOL; (*Trigger recording*)
		Delete : BOOL; (*Delete selected file *)
		View : BOOL; (*View selected file*)
		Download : BOOL; (*Download selected file*)
		ErrorReset : BOOL; (*Reset pending errors*)
	END_STRUCT;
	datPAR : 	STRUCT  (*Recorder managment parameter structure*)
		RecordVariable : STRING[200]; (*Name of the variable where the data is stored*)
		RecordName : STRING[200]; (*Record name for command delete and view*)
		RecordMode : MpDataRecordModeEnum; (*Recording mode*)
		RecordInterval : TIME := T#2000ms;
		IsRecording : BOOL; (*Indicates that recording is active*)
		SamplesNum : UDINT; (*Number of recorded samples*)
		DeviceName : STRING[100]; (*Device name where the records are stored*)
		MpLink : MpComIdentType; (*MpLink from mappRecorder*)
		Initialized : BOOL; (*Indicates that recorder managment was initialized*)
		VisuSlotID : USINT; (*ID for connected web connection*)
	END_STRUCT;
	datDAT : 	STRUCT  (*Recorder managment data structure*)
		RecordNames : ARRAY[0..DAT_MAX_NUM]OF STRING[DAT_NAME_LENGTH]; (*Recorder unicode name*)
		RecordNum : UINT; (*Number of recorded files*)
		Status : WSTRING[100]; (*Shows the result of the last command*)
	END_STRUCT;
	datVIS : 	STRUCT  (*Recorder managment visualization structure*)
		RecordNames : ARRAY[0..DAT_MAX_NUM]OF STRING[DAT_VIS_LENGTH]; (*Recorder file size*)
		RecordNum : UINT; (*Number of records*)
		RecordFilter : STRING[DAT_NAME_LENGTH]; (*Filter for record names*)
		RecordSelected : STRING[DAT_VIS_LENGTH]; (*Selected record for command delete or view*)
		RecordDoubleClick : USINT; (*TrackDoubleClick event*)
		EnableButtons : BOOL;
		ViewFilePath : STRING[DAT_VIS_LENGTH]; (*Full path for viewing file*)
		ViewFile : BOOL; (*Show message box on error*)
		DownloadFileUrl : STRING[200]; (*File upload and download url*)
		ShowMessageBoxError : BOOL; (*Show message box on error*)
	END_STRUCT;
	datMAIN : 	STRUCT  (*Recorder managment main structure*)
		CMD : datCMD; (* Command structure *)
		PAR : datPAR; (* Parameter structure *)
		DAT : datDAT; (*Data structure*)
		VIS : ARRAY[0..DAT_MAX_CLIENTS_ID]OF datVIS; (*Visualization structure*)
		ERR : datERR; (* Error structure *)
	END_STRUCT;
END_TYPE

(*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*)
(*Structure that contains the recorder variables*)

TYPE
	datVariable : 	STRUCT 
		Temperature1 : INT := 11;
		Temperature2 : INT := 22;
		MotorSpeed : DINT := 33;
		Position : REAL := 44.55;
	END_STRUCT;
END_TYPE

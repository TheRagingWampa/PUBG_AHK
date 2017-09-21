; Autofire for PUBG made by Wampa v2.7
;---------------------------------------
; Script Settings
;---------------------------------------
	
	#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
	#SingleInstance force ; Forces the script to only run one at a time.
	SetTitleMatchMode, 2 ; Sets mode for ifwinactive window.
	#ifwinactive, PLAYERUNKNOWN'S BATTLEGROUNDS ; Ensures Autofire only works in PUBG.
	
;---------------------------------------
; Variables
;---------------------------------------

	V_AutoFire = 0 ; Value for Autofire being on and off.
	isMouseShown() ; Value for suspending when mouse is visible.
	comp = 0 ; Value for compensation, currently disabled due to unreliability.
   
;---------------------------------------   
; Suspend if mouse is visible
;---------------------------------------   

	isMouseShown()			; Suspends the script when mouse is visible ie: inventory, menu, map.
	{
		StructSize := A_PtrSize + 16
		VarSetCapacity(InfoStruct, StructSize)
		NumPut(StructSize, InfoStruct)
		DllCall("GetCursorInfo", UInt, &InfoStruct)
		Result := NumGet(InfoStruct, 8)

	if Result > 1
      Return 1
	else
      Return 0
	}
	Loop
	{
		if isMouseShown() == 1
			Suspend On
		else
			Suspend Off
		Sleep 1
	}

;---------------------------------------
; Disable Mouse Wheel
;---------------------------------------

	WheelUp::Return 			; Disables Mouse Wheel Up.
	~$*WheelUp::Return 			; Disables Mouse Wheel Up.
	WheelDown::Return 			; Disables Mouse Wheel Up.
	~$*WheelDown::Return 		; Disables Mouse Wheel Down.
	
;---------------------------------------   
; Crouch Jumping
;---------------------------------------
   
   ~space::c					; Crouches when you press the spacebar making jumps higher than normal.
   
;---------------------------------------
; Autofire Setup
;---------------------------------------

	~$*b::					; Swaps the state of Autofire with the press of "B".
		if V_AutoFire = 0
		{
			V_AutoFire = 1 
			tooltip, Autofire on, 1250, 850 
			SetTimer, RemoveToolTip, 2000
		}
		else
		{
			V_AutoFire = 0 
			tooltip, Autofire off, 1250, 850 
			SetTimer, RemoveToolTip, 2000
		}
	Return

	~$*Numpad0::			; Disables Autofire.
	~$*NumpadIns::
		V_AutoFire = 0
		tooltip, Autofire off, 1250, 850
		SetTimer, RemoveToolTip, 2000
	Return

	~$*Numpad1::			; Enables Autofire.
	~$*NumpadEnd::
		V_AutoFire = 1
		tooltip, Autofire on, 1250, 850
		SetTimer, RemoveToolTip, 2000
	Return
	
	/*
	~$*Numpad5::			; Displays compensation value, currently disabled.
	   tooltip, %comp%, 1250, 850
	   SetTimer, RemoveToolTip, 2000
	Return
	
	~$*NumpadAdd::			; Adds compensation value, currently disabled.
		comp := comp + 5
		tooltip, %comp%, 1250, 850
		SetTimer, RemoveToolTip, 2000
	Return
   
	~$*NumpadSub::			; Subtracts compensation value, currently disabled.
		comp := comp - 5
		tooltip, %comp%, 1250, 850
		SetTimer, RemoveToolTip, 2000
	Return

	~$*NumpadEnter::		; Resets compensation value to 0, currently disabled.
		comp := 0
		tooltip, %comp%, 1250, 850
		SetTimer, RemoveToolTip, 2000
	Return
	*/
   
;---------------------------------------
; Auto Firing
;---------------------------------------

	~$*LButton::			; Fires Automaticly when Autofire is on.
		if V_AutoFire = 1
	{
		Loop
	{
		GetKeyState, LButton, LButton, P
		if LButton = U
			Break
		MouseClick, Left,,, 1
		Gosub, RandomSleep
		Mousemove, 0, %comp%,, R 	; Compensation, currently disabled.
	}
	}
	Return 

;---------------------------------------
; Tooltips and Timers
;---------------------------------------
	
	RandomSleep:			; Random timing between Autofire shots
		Random, random, 14, 25
		Sleep %random%-5
	Return
	
	RemoveToolTip:			; Used to remove tooltips.
	   SetTimer, RemoveToolTip, Off
	   tooltip
	Return
   
	~$*RButton::			; Displays Autofire on tooltip when zooming in.
		if V_AutoFire = 1
		{	
			tooltip, Autofire on, 1250, 850 
			SetTimer, RemoveToolTip, 2000
		}
		else
			tooltip
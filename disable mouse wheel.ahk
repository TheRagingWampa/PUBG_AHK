;---------------------------------------
; Script Settings
;---------------------------------------
	
	#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
	#SingleInstance force ; Forces the script to only run one at a time.
	SetTitleMatchMode, 2 ; Sets mode for ifwinactive window.
	#ifwinactive, PLAYERUNKNOWN'S BATTLEGROUNDS ; Ensures Autofire only works in PUBG.
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

~$*WheelUp::Return ; Disables Mouse Wheel Up.
~$*WheelDown::Return ; Disables Mouse Wheel Down.
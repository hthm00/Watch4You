#include <GUIConstantsEx.au3>
#include "GUIHyperLink.au3"

$hGUI = GUICreate("GUICtrlHyperLink UDF Demo!", 300, 200)

$nAutoItScript_Com_HyperLink = _GUICtrlHyperLink_Create("AutoIt Official Website", 100, 50, 110, 15, 0x0000FF, 0x551A8B, _
	-1, 'http://google.com', 'Visit: www.google.com', $hGUI) ;Intentionally set as google.com, will change later

$nAutoItScript_Ru_HyperLink = _GUICtrlHyperLink_Create("AutoIt Russian Community", 90, 80, 130, 15, 0x0000FF, 0x551A8B, _
	-1, 'http://autoit-script.ru', 'Visit: www.autoit-script.ru', $hGUI)

$nCreatoRLab_HyperLink = _GUICtrlHyperLink_Create("CreatoR's Lab", 120, 110, 70, 15, 0x0000FF, 0x551A8B, _
	1, '_CreatoRLab_ShowInfo(@THIS@, ' & $hGUI & ')', 'Show website information...', $hGUI)

_GUICtrlHyperLink_SetData($nAutoItScript_Com_HyperLink, 2, 'www.autoitscript.com')
GUICtrlSetTip($nAutoItScript_Com_HyperLink, 'Visit: www.autoitscript.com')

GUISetState(@SW_SHOW, $hGUI)

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd

Func _CreatoRLab_ShowInfo($nCtrlID, $h_GUI)
	MsgBox(64, 'Info', 'HyperLink Clicked:' & @CRLF & GUICtrlRead($nCtrlID), 0, $h_GUI)
EndFunc

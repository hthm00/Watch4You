#RequireAdmin
#include <IE.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <Process.au3>


Global $time,$option=''

HotKeySet('{F4}','_exit')
Func _exit()
	Exit
EndFunc
If @CPUArch = "X64" Then
	$iever=RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432node\Microsoft\Internet Explorer","svcVersion")
Else
	$iever=RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer","svcVersion")
EndIf
If Not @error Then
	$iever=StringSplit($iever,'.')
	If Not @error Then
		$iever=$iever[1]
		Switch $iever
			Case 11
				RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_BROWSER_EMULATION", _ProcessGetName(@AutoItPID), "REG_DWORD", '11001')
			Case 10
				RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_BROWSER_EMULATION", _ProcessGetName(@AutoItPID), "REG_DWORD", '10001')
			Case Else
				MsgBox(0,'Error','Hãy nâng cấp trình duyệt Internet Explorer lên 10 hoặc 11')
				Exit
		EndSwitch
	Else
		MsgBox(0,'Error','Có lỗi trong quá trình xử lý, hãy liên hệ admin')
		Exit
	EndIf
Else
	MsgBox(0,'Error','Chưa cài Internet Explorer'&@CRLF&'Mã lỗi: ' &@error)
	Exit
EndIf

#Region ### START Koda GUI section ### Form=
$ie=_IECreateEmbedded()
$Form3 = GUICreate("Auto Snuckls", 1153, 644, 88, 28)
$ieembedded=GUICtrlCreateObj($ie,224, 48, 905, 581)
$Tab1 = GUICtrlCreateTab(12, 12, 1129, 625)
$TabSheet1 = GUICtrlCreateTabItem("Auto")
$Label1 = GUICtrlCreateLabel("Tốc độ", 20, 44, 44, 17)
$Radio1 = GUICtrlCreateRadio("Nhanh", 72, 44, 50, 17)
GUICtrlSetState($Radio1,$GUI_CHECKED)
$Radio2 = GUICtrlCreateRadio("Chậm", 140, 44, 65, 17)
$Label2 = GUICtrlCreateLabel("Ngẫu nhiên", 20, 76, 40, 35)
$Checkbox1 = GUICtrlCreateCheckbox("Rock", 72, 76, 97, 17)
$Checkbox2 = GUICtrlCreateCheckbox("Pop", 72, 100, 97, 17)
$Checkbox3 = GUICtrlCreateCheckbox("Hip hop", 72, 124, 97, 17)
$Checkbox4 = GUICtrlCreateCheckbox("Other", 72, 148, 97, 17)
GUICtrlSetState($Checkbox4,$GUI_CHECKED)
$Checkbox5 = GUICtrlCreateCheckbox("Tự chọn", 72, 172, 97, 17)
$Button1 = GUICtrlCreateButton("Rock", 72, 200, 55, 21)
$Button2 = GUICtrlCreateButton("Pop", 132, 200, 59, 21)
$Button3 = GUICtrlCreateButton("Hip hop", 72, 224, 55, 21)
$Button4 = GUICtrlCreateButton("Other", 132, 224, 59, 21)
GUICtrlSetState($Button1,32)
GUICtrlSetState($Button2,32)
GUICtrlSetState($Button3,32)
GUICtrlSetState($Button4,32)
$Button5 = GUICtrlCreateButton("Bắt đầu", 20, 328, 75, 25)
GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW)
_IENavigate($ie,'google.com')
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button5
			If GUICtrlRead($Radio1)=1 Then
				$time=0
			Else
				$time=3000
			EndIf
			If GUICtrlRead($Checkbox1)=1 Then
				$option&=1
			EndIf
			If GUICtrlRead($Checkbox2)=1 Then
				$option&=2
			EndIf
			If GUICtrlRead($Checkbox3)=1 Then
				$option&=3
			EndIf
			If GUICtrlRead($Checkbox4)=1 Then
				$option&=4
			EndIf
			batdau()

	EndSwitch
WEnd

Func batdau()
	$stt=3
	$i=0
	$title='Snuckls - Internet Explorer'
	If WinExists($title) Then
		MsgBox(0,'Thông báo','Bạn đang mở nhiều Snuckls, hãy tắt bớt rồi mở lại auto')
		Exit
	EndIf
	_IENavigate($ie,'http://www.snuckls.com')
	While 1
	;~ 	$ie=_IECreate('http://www.snuckls.com/video/videofeed')
		_IENavigate($ie,'http://www.snuckls.com/video/videofeed')
;~ 		_IEPropertySet($ie,'width',880)
;~ 		_IEPropertySet($ie,'height',603)
;~ 		_IEPropertySet($ie,'left',0)
;~ 		_IEPropertySet($ie,'top',0)
		_IEPropertyGet($ie,'title')
		;~ $title=_IEPropertyGet($ie,'title'))
	;~ 	While 1
	;~ 		Sleep(2000)
	;~ 		$txt=_IEBodyReadText($ie)
	;~ 		If StringInStr($txt,'videos to get ticket') Then
				$objs=_IETagNameGetCollection($ie,'span')
				For $obj In $objs
					If $obj.classname='play-btn' Then
						$obj.click()
						_IELoadWait($ie)
						ExitLoop
					EndIf
				Next
	;~ 		EndIf
		;~ $txt=_IEBodyReadHTML($ie)
		;~ ClipPut($txt)
		;~ $objs=_IETagNameGetCollection($ie,'a')
		;~ For $obj In $objs
		;~ 	MsgBox(0,'',$obj.classname)
		;~ 	If $obj.classname='border-btn emojiclick' Then
		;~ 		$i+=1
		;~ 	EndIf
		;~ 	If $i=$stt Then
		;~ 		$obj.click()
		;~ 	EndIf;
		;~ Next
			Sleep(2000+$time)
			$txt=_IEBodyReadText($ie)
			If StringInStr($txt,'CREATE YOUR TICKET!') Then
				For $ii=1 To 5
					_IESelectWCard($ie, Random(0,9,1), "button", "click")
				Next
				Sleep(500+$time)
				_IESelectWCard($ie, 'Submit', "a", "click")
				Sleep(1000+$time)
;~ 				_IEQuit($ie)
	;~ 			$ie=_IECreate('http://www.snuckls.com')
				_IENavigate($ie,'http://www.snuckls.com')
;~ 				_IEQuit($ie)

	;~ 			ExitLoop
			Else
				$objs=_IETagNameGetCollection($ie,'iframe')
				For $obj In $objs
					If $obj.id='video_player' Then
						$videox=_IEPropertyGet($obj,'browserx')
						$videoy=_IEPropertyGet($obj,'browsery')
;~ 						$pos=WinGetPos('AutoSnuckls')
;~ 						ControlClick($title,'','','left',1,$videox+30,$videox+30)
;~ 						ControlClick('Auto Snuckls','','[CLASS:Internet Explorer_Server; INSTANCE:1]','left',1,668, 357)
						ControlClick('Auto Snuckls','','[CLASS:Internet Explorer_Server; INSTANCE:1]','left',1,$videox+30,$videox+30)
						Sleep(5000+$time)
						_IELoadWait($ie)
						ExitLoop
					EndIf
				Next
				If GUICtrlRead($Checkbox5)=1 Then
					GUICtrlSetState($Button1,16)
					GUICtrlSetState($Button2,16)
					GUICtrlSetState($Button3,16)
					GUICtrlSetState($Button4,16)
					While 1
						$nMsg = GUIGetMsg()
						Switch $nMsg
							Case $Button1
								$name='Rock'
								ExitLoop
							Case $Button2
								$name='Pop'
								ExitLoop
							Case $Button3
								$name='Hip Hop'
								ExitLoop
							Case $Button4
								$name='Other'
								ExitLoop

						EndSwitch
					WEnd
					GUICtrlSetState($Button1,32)
					GUICtrlSetState($Button2,32)
					GUICtrlSetState($Button3,32)
					GUICtrlSetState($Button4,32)
				Else
					Do
						$ran=Random(1,4,1)
					Until StringInStr($option,$ran)
					Switch $ran
						Case 1
							$name='Rock'
						Case 2
							$name='Pop'
						Case 3
							$name='Hip Hop'
						Case 4
							$name='Other'
					EndSwitch
				EndIf
					_IESelectWCard($ie, $name, "a", "click")
					Sleep(1000+$time)
;~ 					_IEQuit($ie)
	;~ 			_IESelectWCard($ie, "Next Video", "a", "click")
			EndIf
	;~ 	WEnd
	WEnd
EndFunc



Func _IESelectWCard($object, $objWildProperty, $objTagname, $objAction = "", $objText = "")
    Local $oElements = _IETagNameAllGetCollection($object)
    For $oElement In $oElements
        Local $tagname = $oElement.tagname
        Local $str = $oElement.outerhtml
        If StringInStr($str, $objWildProperty) And $tagname = $objTagname Then
            If $objText <> "" Then
                Return _IEFormElementSetValue($oElement, $objText)
            Else
                If $objAction = "" Then
                    Return $oElement
                Else
                    Return _IEAction($oElement, $objAction)
                EndIf
            EndIf
            ExitLoop
        EndIf
    Next
    Return 0
EndFunc   ;==>_IESelectWCard
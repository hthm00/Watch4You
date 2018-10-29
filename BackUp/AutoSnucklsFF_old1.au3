#Region
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Res_Fileversion=2.1.0.0
#AutoIt3Wrapper_Res_ProductVersion=2.1.0.0
#AutoIt3Wrapper_Res_Description=AutoSnuckls-MH
#AutoIt3Wrapper_Res_LegalCopyright=Copyright © 2017 Minh Huynh
#AutoIt3Wrapper_Res_Field=Made By|Minh Huynh
#AutoIt3Wrapper_Res_Field=Productname|AutoSnuckls-MH
#EndRegion

#RequireAdmin
#include <IE.au3>
#include <FF.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <Process.au3>
#include <WinAPI.au3>
#include <Array.au3>
#include <String.au3>
#include <WinHTTP.au3>
#include <File.au3>
#include 'Login.au3'
#include '_SelfUpdate.au3'


Global $time,$option=''
Global $dem=0, $ie, $ff
Global $iever
Global $lottery[13]
Global $nMsg
Global $Form3
Global $ver='2.1.0.0'
Global $ran,$landau=False,$batdau2=False,$tuchon=False
Global $ran[10]
Global $cho=False
Global $doc
DirCreate(@ScriptDir&'\data\temp\')
DirCreate(@ScriptDir&'\data\rar\')
DirCreate(@ScriptDir&'\data\mute\')
FileInstall('E:\Minh\AutoIT\PTC\All1Tool\SignupTool\data\rar\license.txt',@ScriptDir&'\data\rar\license.txt',1)
FileInstall('E:\Minh\AutoIT\PTC\All1Tool\SignupTool\data\rar\UnRAR.exe',@ScriptDir&'\data\rar\UnRAR.exe',1)
FileInstall('E:\Minh\AutoIT\AutoSnuckls\huongdan.txt',@ScriptDir&'\huongdan.txt',1)
FileInstall('E:\Minh\AutoIT\AutoSnuckls\mutetab.txt',@ScriptDir&'\mutetab.txt',1)
FileInstall('E:\Minh\AutoIT\AutoSnuckls\data\mute\nircmd.exe',@ScriptDir&'\data\mute\nircmd.exe',1)
FileInstall('E:\Minh\AutoIT\AutoSnuckls\changelog.txt',@ScriptDir&'\changelog.txt',1)
check2()

If FileExists(@ScriptDir&'\data\temp\AutoSnucklsFF.rar') Then
	FileDelete(@ScriptDir&'\data\temp\AutoSnucklsFF.rar')
EndIf



HotKeySet('{F4}','_exit')
Func _exit()
	If $danglogin=True Then
		Logout()
	EndIf
	Exit
EndFunc
auto()

Func auto()

Do
	$dem+=1
Until Not WinExists("Auto SnucklsFF"&$dem&' v'&$ver)

If ProcessExists('firefox.exe') Then
	$yesno=MsgBox($MB_YESNO,'Thông báo','Bạn đang mở Firefox!!'&@CRLF&'Bấm "YES" để tắt tất cả Firefox đang chạy'&@CRLF&'Bấm "No" để mặc xác nó và tiếp tục')
	If $yesno=$IDYES Then
		ProcessClose('firefox.exe')
	Else
		MsgBox(0,'Thông báo','Nếu auto chạy không được thì mở lại auto và chọn "YES" nhé!',3)
	EndIf
EndIf

;~ _FFConnect()
;~ $ff=_FFStart('google.com','default',8)

#Region ### START Koda GUI section ### Form=
;~ $ie = ObjCreate("Mozilla.Browser.1")
Global $Form3 = GUICreate("Auto SnucklsFF"&$dem&' v'&$ver, 1153, 644, 88, 28)
GUISetOnEvent($GUI_EVENT_CLOSE, '_exit')
Global $Tab1 = GUICtrlCreateTab(12, 12, 1129, 625)
Global $TabSheet1 = GUICtrlCreateTabItem("Auto")
Global $Label1 = GUICtrlCreateLabel("Tốc độ", 20, 44, 44, 17)
Global $Radio1 = GUICtrlCreateRadio("Nhanh", 72, 44, 50, 17)
GUICtrlSetState($Radio1,$GUI_CHECKED)
Global $Radio2 = GUICtrlCreateRadio("Chậm", 140, 44, 65, 17)
Global $Label2 = GUICtrlCreateLabel("Ngẫu nhiên", 20, 76, 40, 35)
Global $Checkbox1 = GUICtrlCreateCheckbox("Rock", 72, 76, 57, 17)
Global $Checkbox2 = GUICtrlCreateCheckbox("Pop", 140, 76, 57, 17)
Global $Checkbox3 = GUICtrlCreateCheckbox("Hip hop", 72, 100, 57, 17)
Global $Checkbox4 = GUICtrlCreateCheckbox("Other", 140, 100, 57, 17)
Global $Checkbox8 = GUICtrlCreateCheckbox("Chế độ thông minh", 72, 124, 105, 17)
Global $Label5 = GUICtrlCreateLabel("", 72, 148, 68, 17)
GUICtrlSetState($Checkbox8,$GUI_CHECKED)
Global $Checkbox5 = GUICtrlCreateCheckbox("Chọn bằng tay", 72, 172, 97, 17)
GUICtrlSetState(-1,32)
Global $Button1 = GUICtrlCreateButton("Rock", 72, 200, 55, 21)
Global $Button2 = GUICtrlCreateButton("Pop", 132, 200, 59, 21)
Global $Button3 = GUICtrlCreateButton("Hip hop", 72, 224, 55, 21)
Global $Button4 = GUICtrlCreateButton("Other", 132, 224, 59, 21)
GUICtrlSetState($Button1,32)
GUICtrlSetState($Button2,32)
GUICtrlSetState($Button3,32)
GUICtrlSetState($Button4,32)
Global $Button5 = GUICtrlCreateButton("Bắt đầu", 20, 604, 75, 25)
Global $Checkbox6 = GUICtrlCreateCheckbox("Nhiều acc:", 20, 256, 157, 17)
Global $Label3 = GUICtrlCreateLabel("Profile:", 20, 284, 36, 17)
Global $Input1 = GUICtrlCreateInput("Profile"&$dem, 72, 280, 121, 21)
Global $Label4 = GUICtrlCreateLabel("Port:", 20, 316, 36, 17)
Global $Input2 = GUICtrlCreateInput("424"&$dem+2, 72, 312, 121, 21)
GUICtrlSetState($Label3,32)
GUICtrlSetState($Label4,32)
GUICtrlSetState($Input1,32)
GUICtrlSetState($Input2,32)

Global $Checkbox7 = GUICtrlCreateCheckbox("Tùy chỉnh ngẫu nhiên số:", 20, 348, 169, 17)
$lottery[1] = GUICtrlCreateInput("1xxxx", 24, 372, 57, 21)
$lottery[2] = GUICtrlCreateInput("2xxxx", 84, 372, 57, 21)
$lottery[3] = GUICtrlCreateInput("3xxxx", 144, 372, 57, 21)
$lottery[4] = GUICtrlCreateInput("4xxxx", 24, 396, 57, 21)
$lottery[5] = GUICtrlCreateInput("5xxxx", 84, 396, 57, 21)
$lottery[6] = GUICtrlCreateInput("6xxxx", 144, 396, 57, 21)
$lottery[7] = GUICtrlCreateInput("7xxxx", 24, 420, 57, 21)
$lottery[8] = GUICtrlCreateInput("8xxxx", 84, 420, 57, 21)
$lottery[9] = GUICtrlCreateInput("9xxxx", 144, 420, 57, 21)
$lottery[10] = GUICtrlCreateInput("0xxxx", 24, 444, 57, 21)
For $k=1 To 10
	GUICtrlSetState($lottery[$k],32)
Next
$Button8 = GUICtrlCreateButton("Hướng dẫn", 16, 476, 203, 125)
GUICtrlSetFont(-1, 27, 400, 0, 'Arial')
$Button10 = GUICtrlCreateButton("Vào nhóm", 100, 604, 75, 25)
GUICtrlSetColor(-1,'0xDD4F43')
Global $Checkbox9 = GUICtrlCreateCheckbox("Tắt âm Firefox", 20, 232, 177, 17)
GUICtrlSetState($Checkbox9,$GUI_CHECKED)

Global $TabSheet2 = GUICtrlCreateTabItem("Firefox")
GUICtrlSetState(-1,$GUI_HIDE)
Global $Input13 = GUICtrlCreateInput("Profile1", 48, 56, 121, 21)
Global $Button6 = GUICtrlCreateButton("Tạo mới", 176, 52, 63, 25)
Global $Button7 = GUICtrlCreateButton("Mở", 244, 52, 63, 25)
$Button9 = GUICtrlCreateButton("Quản lý Profile", 312, 52, 119, 25)
GUICtrlCreateTabItem("")
#EndRegion ### END Koda GUI section ###
child()
While 1
	kiemtra2()
	If $danglogin= True Then
;~ 		GUIDelete($MainForm)
		If Not FileExists(@ScriptDir&'\data\temp\config.txt') Then
			_FileCreate(@ScriptDir&'\data\temp\config.txt')
			FileWrite(@ScriptDir&'\data\temp\config.txt','0')
		EndIf
		If FileExists(@ScriptDir&'\data\temp\config.txt') Then
			$line1=FileReadLine(@ScriptDir&'\data\temp\config.txt',1)
			If $line1=0 Then
				Run('notepad.exe "'&@ScriptDir&'\changelog.txt"')
				_FileWriteToLine(@ScriptDir&'\data\temp\config.txt',1,'1',True)
			EndIf
		EndIf
		GUISetState(@SW_HIDE,$MainForm)
		GUISetState(@SW_SHOW,$Form3)
;~ 		GUICtrlSetOnEvent($Checkbox9, 'checkbox9')
		GUICtrlSetOnEvent($Checkbox8, 'checkbox8')
		GUICtrlSetOnEvent($Checkbox7, 'checkbox7')
		GUICtrlSetOnEvent($Checkbox6, 'checkbox6')
		GUICtrlSetOnEvent($Button5, 'button5')
		GUICtrlSetOnEvent($Button6, 'button6')
		GUICtrlSetOnEvent($Button7, 'button7')
		GUICtrlSetOnEvent($Button9, 'button9')
		GUICtrlSetOnEvent($Button8, 'huongdan')
		GUICtrlSetOnEvent($Button10, 'button10')
		GUICtrlSetOnEvent($Button1, 'ran1')
		GUICtrlSetOnEvent($Button2, 'ran2')
		GUICtrlSetOnEvent($Button3, 'ran3')
		GUICtrlSetOnEvent($Button4, 'ran4')
	EndIf
	If $landau=True Then
		Local $stt=3
		Local $i=0
		Local $maso=0
		Local $title='firefox.exe'
		$landau=False
		$batdau2=True
	EndIf
	While 1
	If $batdau2=True Then
;~ 		kiemtra2()


		_FFTabSetSelected(0)
		_FFOpenURL('http://www.snuckls.com/video/videofeed')
		_FFLoadWait()


;~ 		Sleep(2000+$time)
;~ 		_FFLoadWait()
;~ 			$thoigian=_StringBetween($txt,'progress-value">','</span>')
		Local $txt=_FFReadHTML()
		If StringInStr($txt,'CREATE YOUR TICKET!') Then;watch-vdo-msg Oops! You got it wrong!
			$maso+=1
			If $maso=11 Then
				MsgBox(0,'Xong','Đã chạy xong')
				Exit
			EndIf
			If GUICtrlRead($Checkbox7)=1 Then
				Local $so=GUICtrlRead($lottery[$maso])
				If StringLen($so)>=5 Then
					For $k=1 To 5
						Local $chuso=StringRight(StringLeft($so,$k),1)
						If IsInt(Execute($chuso)) Then
							If $chuso='0' Then
								_FFClick('key-buttons','class',9)
							Else
								_FFClick('key-buttons','class',$chuso-1)
							EndIf
						Else
							_FFClick('key-buttons','class',Random(1,10,1)-1)
						EndIf
					Next
				EndIf
			Else
				For $ii=1 To 5
					_FFClick('key-buttons','class',Random(1,10,1)-1)
				Next
			EndIf
			Sleep(500+$time)
			_FFClick('submit-button','id')
			Sleep(1000+$time)
			_FFOpenURL('http://www.snuckls.com')
		Else
			$cho=True
;~ 			$txt=_FFReadHTML()
;~ 			$sovideo=_StringBetween($txt,'Watch ',' videos to get ticket')
;~ 			If @error Then
;~ 				MsgBox(0,'Error','Không tìm thấy video',3)
;~ 				ExitLoop
;~ 			Else
;~ 				$sovideo=$sovideo[0]
;~ 			EndIf
			For $temp=2 To 6
				_FFTabAdd('http://www.snuckls.com/video/videofeed')
			Next
			For $temp=1 To 6
				_FFTabSetSelected($temp-1)
				Local $objs=_FFObjGet('play-btn','class',$temp-1)
				_FFClick($objs)
			Next
			$thoigianmax=60
			For $temp=1 To 6
			_FFTabSetSelected($temp-1)
;~ 			$txt=_FFReadHTML()
;~ 			$thoigian=_StringBetween($txt,'progress-value">','</span>')
;~ 			If Not @error Then
;~ 				$thoigian=StringSplit($thoigian[0],'/')
;~ 				$thoigian=$thoigian[2]
;~ 				If $thoigian>$thoigianmax Then
;~ 					$thoigianmax=$thoigian
;~ 				EndIf
;~ 			EndIf
			$str=_FFCmd('.getElementsByTagName("iframe")[0].getAttributeNode("src").value')
			If StringInStr($str,'enablejsapi=1&autoplay=false&controls=0&rel=0&showinfo=0&egm=0&showsearch=0&modestbranding=1&iv_load_policy=3&disablekb=1&loop=0&start=0') Then
				$res=StringReplace($str,'autoplay=false&controls=0&rel=0&showinfo=0&egm=0&showsearch=0&modestbranding=1&iv_load_policy=3&disablekb=1&loop=0&start=0','autoplay=1&rel=0&showinfo=0&egm=0&showsearch=0&modestbranding=1&iv_load_policy=3&loop=0&start=60')
				_FFCmd('.getElementsByTagName("iframe")[0].getAttributeNode("src").value="'&$res&'"')
			EndIf

;~ 			$objs=_FFObjGet('video_player','id')

;~ 			Local $pos=_FFGetPosition($objs)
;~ 			If IsArray($pos) Then
;~ 				ControlClick($ie,'','','left',1,$pos[0]+30,$pos[1]+357)

;~ 				ControlClick($ie,'','','left',1,80,357)

;~ 			EndIf
;~ 			If GUICtrlRead($Checkbox8)<>1 Then
;~ 				Sleep(5000+$time)
;~ 			EndIf
			_FFLoadWait()
			If GUICtrlRead($Checkbox8)=1 Then
				$txt=_FFReadHTML()
				$cate=yt($txt)
				GUICtrlSetData($Label5,$cate)
				Switch $cate
					Case 'Hip hop'
						$ran[$temp]=3
					Case 'Others'
						$ran[$temp]=4
				EndSwitch
;~ 				Sleep(4000+$time)
;~ 			ElseIf GUICtrlRead($Checkbox5)=1 Then
;~ 				$tuchon=True
;~ 				ExitLoop

			Else
				Do
					$ran[$temp]=Random(1,4,1)
				Until StringInStr($option,$ran[$temp])
			EndIf
;~ 			$objs=_FFObjGet('border-btn emojiclick','class',$ran[$sovideo]-1)
;~ 			_FFClick($objs)
;~ 			Sleep(1000+$time)
			Next
		EndIf
		If $cho=True Then
;~ 			$bodem=TimerInit()
;~ 			Do
;~ 				kiemtra2()
;~ 				Sleep(1000)
;~ 				GUICtrlSetData($Label5,Int(TimerDiff($bodem)/1000)&'/'&$thoigianmax)
;~ 			Until TimerDiff($bodem)>=$thoigianmax*1000+$time
			For $temp=1 To 6
				_FFTabSetSelected($temp-1)
				$objs=_FFObjGet('border-btn emojiclick','class',$ran[$temp]-1)
				_FFClick($objs)
				Sleep($time)
			Next
			For $temp=6 To 2 Step -1
				_FFTabSetSelected($temp-1)
				_FFTabClose($temp-1)
			Next
			$cho=False
		EndIf
	EndIf
	ExitLoop
	WEnd
;~ 	If $tuchon=True Then
;~ 		$batdau2=False
;~ 		$tuchon=False
;~ 		GUICtrlSetState($Button1,16)
;~ 		GUICtrlSetState($Button2,16)
;~ 		GUICtrlSetState($Button3,16)
;~ 		GUICtrlSetState($Button4,16)
;~ 	EndIf

WEnd
EndFunc

Func checkbox9()
	If GUICtrlRead($Checkbox9)=1 Then
		Run(@ScriptDir&'\data\mute\nircmd.exe muteappvolume firefox.exe 1')
	Else
		Run(@ScriptDir&'\data\mute\nircmd.exe muteappvolume firefox.exe 0')
	EndIf
EndFunc
Func ran1()
	$ran=1
	GUICtrlSetState($Button1,32)
	GUICtrlSetState($Button2,32)
	GUICtrlSetState($Button3,32)
	GUICtrlSetState($Button4,32)
	$objs=_FFObjGet('border-btn emojiclick','class',$ran-1)
	_FFClick($objs)
	Sleep(1000+$time)
	$batdau2=True
EndFunc
Func ran2()
	$ran=2
	GUICtrlSetState($Button1,32)
	GUICtrlSetState($Button2,32)
	GUICtrlSetState($Button3,32)
	GUICtrlSetState($Button4,32)
	$objs=_FFObjGet('border-btn emojiclick','class',$ran-1)
	_FFClick($objs)
	Sleep(1000+$time)
	$batdau2=True
EndFunc
Func ran3()
	$ran=3
	GUICtrlSetState($Button1,32)
	GUICtrlSetState($Button2,32)
	GUICtrlSetState($Button3,32)
	GUICtrlSetState($Button4,32)
	$objs=_FFObjGet('border-btn emojiclick','class',$ran-1)
	_FFClick($objs)
	Sleep(1000+$time)
	$batdau2=True
EndFunc
Func ran4()
	$ran=4
	GUICtrlSetState($Button1,32)
	GUICtrlSetState($Button2,32)
	GUICtrlSetState($Button3,32)
	GUICtrlSetState($Button4,32)
	$objs=_FFObjGet('border-btn emojiclick','class',$ran-1)
	_FFClick($objs)
	Sleep(1000+$time)
	$batdau2=True
EndFunc
Func huongdan()
	Run('notepad.exe "'&@ScriptDir&'\huongdan.txt"')
EndFunc
Func button10()
	ShellExecute('https://www.facebook.com/groups/1829937350594308')
EndFunc
Func button9()
	Local $sHKLM = 'HKEY_LOCAL_MACHINE\SOFTWARE\'
	If @OSArch <> 'X86' Then $sHKLM &= 'Wow6432Node\'
	$sHKLM &= 'Mozilla\Mozilla Firefox'
	Local $sFFExe = RegRead($sHKLM & "\" & RegRead($sHKLM, "CurrentVersion") & "\Main", "PathToExe")
	If @error Then
		MsgBox(0,'Error','Không tìm thấy Firefox')
		Return 0
	EndIf
	Run('"'&$sFFExe&'"'&' -ProfileManager')
EndFunc
Func button7()
	Local $sHKLM = 'HKEY_LOCAL_MACHINE\SOFTWARE\'
	If @OSArch <> 'X86' Then $sHKLM &= 'Wow6432Node\'
	$sHKLM &= 'Mozilla\Mozilla Firefox'
	Local $sFFExe = RegRead($sHKLM & "\" & RegRead($sHKLM, "CurrentVersion") & "\Main", "PathToExe")
	If @error Then
		MsgBox(0,'Error','Không tìm thấy Firefox')
		Return 0
	EndIf
	Run('"'&$sFFExe&'"'&' -no-remote -p "'&GUICtrlRead($Input13)&'"')
EndFunc
Func button6()
	Local $sHKLM = 'HKEY_LOCAL_MACHINE\SOFTWARE\'
	If @OSArch <> 'X86' Then $sHKLM &= 'Wow6432Node\'
	$sHKLM &= 'Mozilla\Mozilla Firefox'
	Local $sFFExe = RegRead($sHKLM & "\" & RegRead($sHKLM, "CurrentVersion") & "\Main", "PathToExe")
	If @error Then
		MsgBox(0,'Error','Không tìm thấy Firefox')
		Return 0
	EndIf
	Run('"'&$sFFExe&'"'&' -no-remote -CreateProfile '&GUICtrlRead($Input13))
	MsgBox(0,'Xong','Đã tạo '&GUICtrlRead($Input13))
EndFunc
Func checkbox8()
	GUICtrlSetState($Checkbox1,$GUI_UNCHECKED)
	GUICtrlSetState($Checkbox2,$GUI_UNCHECKED)
	GUICtrlSetState($Checkbox3,$GUI_UNCHECKED)
	GUICtrlSetState($Checkbox4,$GUI_UNCHECKED)
	GUICtrlSetState($Checkbox5,$GUI_UNCHECKED)
EndFunc
Func checkbox7()
	If GUICtrlRead($Checkbox7)=1 Then
		For $k=1 To 10
			GUICtrlSetState($lottery[$k],16)
		Next
	Else
		For $k=1 To 10
			GUICtrlSetState($lottery[$k],32)
		Next
	EndIf
EndFunc
Func checkbox6()
	GUICtrlSetState($Checkbox1,$GUI_UNCHECKED)
	GUICtrlSetState($Checkbox2,$GUI_UNCHECKED)
	GUICtrlSetState($Checkbox3,$GUI_UNCHECKED)
	GUICtrlSetState($Checkbox4,$GUI_UNCHECKED)
	If GUICtrlRead($Checkbox6)=1 Then
		GUICtrlSetState($Label3,16)
		GUICtrlSetState($Label4,16)
		GUICtrlSetState($Input1,16)
		GUICtrlSetState($Input2,16)
	Else
		GUICtrlSetState($Label3,32)
		GUICtrlSetState($Label4,32)
		GUICtrlSetState($Input1,32)
		GUICtrlSetState($Input2,32)
	EndIf
EndFunc
Func button5()
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
	If GUICtrlRead($Checkbox6)=1 Then
		$ff=__FFStartProcess('http://www.snuckls.com',False,GUICtrlRead($Input1),True,False,Execute(GUICtrlRead($Input2)))
		$doc=@extended
;~ 				_FFConnect(Default,GUICtrlRead($Input2))
		$ie=_FFWindowGetHandle(10000)
		GUISetStyle(BitOR($WS_CHILD,$WS_POPUPWINDOW), 0, $ie)
	Else
		$ff=__FFStartProcess('http://www.snuckls.com',False,'default',True,False,4242)
		$doc=@extended
;~ 				_FFConnect(Default,'default')
		$ie=_FFWindowGetHandle(10000)
		GUISetStyle(BitOR($WS_CHILD,$WS_POPUPWINDOW), 0, $ie)
	EndIf
	If GUICtrlRead($Checkbox9)=1 Then
		Run('"'&@ScriptDir&'\data\mute\nircmd.exe" muteappvolume firefox.exe 1')
	Else
		Run('"'&@ScriptDir&'\data\mute\nircmd.exe" muteappvolume firefox.exe 0')
	EndIf
	_WinAPI_SetParent($ie, $Form3)
	WinMove($ie, "", 224, 48, 905 ,581)
	_WinAPI_RedrawWindow($ie)
	_WinAPI_RedrawWindow($Form3)

	batdau()
EndFunc

Func batdau()
	$landau=True
EndFunc

Func yt($txt);Oops! Seems you already have 10 tickets. Max 10 tickets per draw.
	Local $link=_StringBetween($txt,'author-detail">','id="videoTitle">')
	If Not @error Then
		$link=_StringBetween($link[0],'youtube.com','"')
		If Not @error Then
			$link=$link[0]
			$open=_WinHttpOpen()
			$connect=_WinHttpConnect($open,'youtube.com')
			$request=_WinHttpOpenRequest($connect,'GET',$link)
			_WinHttpSendRequest($request)
			_WinHttpReceiveResponse($request)
			$txt=_WinHttpSimpleReadData($request)
			_WinHttpCloseHandle($Request)
			_WinHttpCloseHandle($Connect)
			_WinHttpCloseHandle($Open)
			$cate=_StringBetween($txt,'content watch-info-tag-list','</ul>')
			If Not @error Then
				$cate=$cate[0]
				If StringInStr($cate,'Music') Or StringInStr($cate,'nhạc') Then
					Return 'Hip hop'
				Else
					Return 'Others'
				EndIf
			EndIf
		Else

		EndIf
	Else
	EndIf
EndFunc


Func check2();http://ptctemp.blogspot.com/2017/02/version.html
	$open=_WinHttpOpen()
	$connect=_WinHttpConnect($open,'ptctemp.blogspot.com')
	$request=_WinHttpOpenRequest($connect,'GET','2017/03/snucklsver.html')

	_WinHttpSendRequest($request)
	_WinHttpReceiveResponse($request)
	$txt=_WinHttpSimpleReadData($request)
	$ok=_StringBetween($txt,"verrrr","endverrrr")
	If Not @error Then
		If $ok[0]<>$ver Then
			$updatelink=_StringBetween($txt,'downnn','enddownnn')
			If Not @error Then
				InetGet($updatelink[0],@ScriptDir&'\data\Temp\AutoSnucklsFF.rar')
				RunWait('"'&@ScriptDir&'\data\rar\Unrar.exe"'&' e "'&@ScriptDir&'\data\temp\AutoSnucklsFF.rar" "'&@ScriptDir&'\data\temp\" '&'-y','',@SW_HIDE)
				FileDelete(@ScriptDir&'\data\temp\AutoSnucklsFF.rar')
				If Not FileExists(@ScriptDir&'\data\temp\config.txt') Then
					_FileCreate(@ScriptDir&'\data\temp\config.txt')
					FileWrite(@ScriptDir&'\data\temp\config.txt','0')
				EndIf
				If FileExists(@ScriptDir&'\data\temp\config.txt') Then
					_FileWriteToLine(@ScriptDir&'\data\temp\config.txt',1,'0',True)
				EndIf
				_selfupdate(@ScriptDir&'\data\temp\AutoSnucklsFF.exe',True,5,Default,False)
				Exit
			Else
				MsgBox(0,'Error','Không thể cập nhật')
				Exit
			EndIf
		EndIf
	Else
		InputBox('Error','Auto không tự cập nhật đc, bạn hãy tải ở link sau:','https://drive.google.com/open?id=0B4DSs5oUzA_BLTNsTTRaWk5ZVlk')
		Exit
	EndIf

	_WinHttpCloseHandle($Request)
	_WinHttpCloseHandle($Connect)
	_WinHttpCloseHandle($Open)

EndFunc
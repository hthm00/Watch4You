#cs
	[CWAutCompFileInfo]
	Company=Minh Huynh
	Copyright=Copyright © 2017 Minh Huynh
	Description=AutoSnuckls-MH
	Version=5.3.0.0
	ProductName=AutoSnuckls-MH
	ProductVersion=5.3.0.0
#ce
#Region
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Res_Fileversion=5.3.0.1
#AutoIt3Wrapper_Res_ProductVersion=5.3.0.1
#AutoIt3Wrapper_Res_Description=AutoSnuckls-MH
#AutoIt3Wrapper_Res_LegalCopyright=Copyright © 2017 Minh Huynh
#AutoIt3Wrapper_Res_Field=Made By|Minh Huynh
#AutoIt3Wrapper_Res_Field=Productname|AutoSnuckls-MH
#EndRegion

#RequireAdmin
#include <IE.au3>
#include <FF.au3>
#include <FFEx.au3>
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


Global $time, $option = ''
Global $dem = 0, $ie, $ff
Global $iever
Global $lottery[13]
Global $nMsg
Global $Form3
Global $ver = '5.3.0.1'
Global $ran, $landau = False, $batdau2 = False, $tuchon = False
Global $ran[10]
Global $cho = False
Global $doc, $solan=1
Global $emojiidlandau[8][6],$emojiidlansau[8][6]
Global $open[7],$connect[7],$request[7],$valuecaptcha[7],$datapost[7],$videostring[7]
DirCreate(@ScriptDir & '\data\temp\')
DirCreate(@ScriptDir & '\data\rar\')
DirCreate(@ScriptDir & '\data\mute\')
FileInstall('E:\Minh\AutoIT\PTC\All1Tool\SignupTool\data\rar\license.txt', @ScriptDir & '\data\rar\license.txt', 1)
FileInstall('E:\Minh\AutoIT\PTC\All1Tool\SignupTool\data\rar\UnRAR.exe', @ScriptDir & '\data\rar\UnRAR.exe', 1)
FileInstall('E:\Minh\AutoIT\AutoSnuckls\huongdan.txt', @ScriptDir & '\huongdan.txt', 1)
;~ FileInstall('E:\Minh\AutoIT\AutoSnuckls\mutetab.txt', @ScriptDir & '\mutetab.txt', 1)
FileInstall('E:\Minh\AutoIT\AutoSnuckls\data\mute\nircmd.exe', @ScriptDir & '\data\mute\nircmd.exe', 1)
FileInstall('E:\Minh\AutoIT\AutoSnuckls\changelog.txt', @ScriptDir & '\changelog.txt', 1)
check2()

If FileExists(@ScriptDir & '\data\temp\AutoSnucklsFF.rar') Then
	FileDelete(@ScriptDir & '\data\temp\AutoSnucklsFF.rar')
EndIf

;~ #cs
;~ MsgBox(0,'',StringLen('emojiid=21&user_watched_time=90&total_video_duration=320&progress_value=97&systemduration_timer=90&video_session_index=0&catArr%5B%5D=21&catArr%5B%5D=21&catArr%5B%5D=21&catArr%5B%5D=21&captcha_value=&videosString=40573b1a074b9ac47c562515ea028a7a'))
;~ Exit

#cs
$request = _WinHttpOpenRequest($connect, 'GET', '/video/videofeed',Default,'https://www.snuckls.com/Video/ticketdetails',Default,$WINHTTP_FLAG_SECURE)

_WinHttpAddRequestHeaders($request,'User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0')
_WinHttpAddRequestHeaders($request,'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8')
_WinHttpAddRequestHeaders($request,'Accept-Language: en-US,en;q=0.5')
;~ _WinHttpAddRequestHeaders($request,'Accept-Encoding: gzip, deflate, br');this make code wrong
_WinHttpAddRequestHeaders($request,'Cookie: ci_session=8b00d5a6a08c93318754591436e28153c32242d5; __cfduid=d8388c5732b36a96a242f3ed8e7ff45a71491449606')
_WinHttpAddRequestHeaders($request,'Connection: keep-alive')
_WinHttpAddRequestHeaders($request,'Upgrade-Insecure-Requests: 1')
_WinHttpSendRequest($request)
_WinHttpReceiveResponse($request)
$response = _WinHttpSimpleReadData($request)
$sHeader = _WinHttpQueryHeaders($Request)
$videostring=_StringBetween($response,'videosString = "','"')
If Not @error Then
	$videostring=$videostring[0]
	MsgBox(0,'',$videostring)
EndIf
;~ MsgBox(0,'',$sHeader&@CRLF&$txt)
;~ _WinHttpCloseHandle($Request)
;~ _WinHttpCloseHandle($Connect)
;~ _WinHttpCloseHandle($Open)
;~ __FFStartProcess('https://www.snuckls.com', False, 'Profile1', True, False, 4243)

$request = _WinHttpOpenRequest($connect, 'GET', '/video/getthevideoindexdata/0/'&$videostring,Default,'https://www.snuckls.com/video/videofeed',Default,$WINHTTP_FLAG_SECURE)
;~ GET https://www.snuckls.com/video/getthevideoindexdata/0/1ad36f395c6dc9ac374d36ec8f79158c HTTP/1.1
;~ Host: www.snuckls.com
;~ User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0
;~ Accept: application/json, text/javascript, */*; q=0.01
;~ Accept-Language: en-US,en;q=0.5
;~ Accept-Encoding: gzip, deflate, br
;~ X-Requested-With: XMLHttpRequest
;~ Referer: https://www.snuckls.com/video/videofeed
;~ Cookie: ci_session=8b00d5a6a08c93318754591436e28153c32242d5; __cfduid=d8388c5732b36a96a242f3ed8e7ff45a71491449606
;~ Connection: keep-alive

_WinHttpAddRequestHeaders($request,'User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0')
_WinHttpAddRequestHeaders($request,'Accept: application/json, text/javascript, */*; q=0.01')
_WinHttpAddRequestHeaders($request,'Accept-Language: en-US,en;q=0.5')
_WinHttpAddRequestHeaders($request,'X-Requested-With: XMLHttpRequest')
_WinHttpAddRequestHeaders($request,'Cookie: ci_session=8b00d5a6a08c93318754591436e28153c32242d5; __cfduid=d8388c5732b36a96a242f3ed8e7ff45a71491449606')
_WinHttpAddRequestHeaders($request,'Connection: keep-alive')
_WinHttpSendRequest($request)
_WinHttpReceiveResponse($request)
$response = _WinHttpSimpleReadData($request)
$sHeader = _WinHttpQueryHeaders($Request)
$captchaneeded=_StringBetween($response,'"captchaNeeded":','}')
;~ Json_Get($response,'["data"]')
If Not @error Then
	$captchaneeded=$captchaneeded[0]
	MsgBox(0,'',$captchaneeded)
EndIf
;~ $captchaneeded=Json_Get($dataget,'captchaNeeded')
;~ MsgBox(0,'',$captchaneeded)
;~ MsgBox(0,'',$sHeader&@CRLF&$txt)
;~ _WinHttpCloseHandle($Request)

;~ POST https://www.snuckls.com/video/videofeedback/da45c554d1ff10fa9f74629937330da5 HTTP/1.1
;~ Host: www.snuckls.com
;~ User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0;
;~ Accept: application/json, text/javascript, */*; q=0.01;
;~ Accept-Language: en-US,en;q=0.5;
;~ Accept-Encoding: gzip, deflate, br
;~ Content-Type: application/x-www-form-urlencoded; charset=UTF-8;
;~ X-Requested-With: XMLHttpRequest;
;~ Referer: https://www.snuckls.com/video/videofeed;
;~ Content-Length: 241
;~ Cookie: ci_session=8b00d5a6a08c93318754591436e28153c32242d5; __cfduid=d8388c5732b36a96a242f3ed8e7ff45a71491449606;
;~ Connection: keep-alive;
#ce
;~ emojiid=20&user_watched_time=0&total_video_duration=593&progress_value=97&systemduration_timer=0&video_session_index=0&catArr%5B%5D=20&catArr%5B%5D=2&catArr%5B%5D=12&catArr%5B%5D=1&captcha_value=&videosString=da45c554d1ff10fa9f74629937330da5
;~ #ce

HotKeySet('{F4}', '_exit')
Func _exit()
	If $danglogin = True Then
		Logout()
	EndIf
	Exit
EndFunc   ;==>_exit
auto()

Func auto()

	Do
		$dem += 1
	Until Not WinExists("Auto SnucklsFF" & $dem & ' v' & $ver)

	If ProcessExists('firefox.exe') Then
		$yesno = MsgBox($MB_YESNO, 'Thông báo', 'Bạn đang mở Firefox!!' & @CRLF & 'Bấm "YES" để tắt tất cả Firefox đang chạy' & @CRLF & 'Bấm "No" để mặc xác nó và tiếp tục')
		If $yesno = $IDYES Then
			ProcessClose('firefox.exe')
		Else
			MsgBox(0, 'Thông báo', 'Nếu auto chạy không được thì mở lại auto và chọn "YES" nhé!', 3)
		EndIf
	EndIf

;~ _FFConnect()
;~ $ff=_FFStart('google.com','default',8)

	#Region ### START Koda GUI section ### Form=
;~ $ie = ObjCreate("Mozilla.Browser.1")
	Global $Form3 = GUICreate("Auto SnucklsFF" & $dem & ' v' & $ver, 1153, 644, 88, 28)
	GUISetOnEvent($GUI_EVENT_CLOSE, '_exit')
	Global $Tab1 = GUICtrlCreateTab(12, 12, 1129, 625)
	Global $TabSheet1 = GUICtrlCreateTabItem("Auto")
	Global $Label1 = GUICtrlCreateLabel("Tốc độ", 20, 44, 44, 17)
	Global $Radio1 = GUICtrlCreateRadio("Nhanh", 72, 44, 50, 17)
	GUICtrlSetState($Radio1, $GUI_CHECKED)
	Global $Radio2 = GUICtrlCreateRadio("Chậm", 140, 44, 65, 17)
	Global $Label2 = GUICtrlCreateLabel("Ngẫu nhiên", 20, 76, 40, 35)
	GUICtrlSetState($Label2, 32)
	Global $Checkbox1 = GUICtrlCreateCheckbox("Rock", 72, 76, 57, 17)
	Global $Checkbox2 = GUICtrlCreateCheckbox("Pop", 140, 76, 57, 17)
	Global $Checkbox3 = GUICtrlCreateCheckbox("Hip hop", 72, 100, 57, 17)
	Global $Checkbox4 = GUICtrlCreateCheckbox("Other", 140, 100, 57, 17)
	Global $Checkbox8 = GUICtrlCreateCheckbox("Chế độ thông minh", 72, 124, 105, 17)
	GUICtrlSetState($Checkbox1, 32)
	GUICtrlSetState($Checkbox2, 32)
	GUICtrlSetState($Checkbox3, 32)
	GUICtrlSetState($Checkbox4, 32)
	GUICtrlSetState($Checkbox8, 32)
	Global $Label5 = GUICtrlCreateLabel("", 72, 148, 160, 17)
	GUICtrlSetState($Checkbox8, $GUI_CHECKED)
	Global $Checkbox5 = GUICtrlCreateCheckbox("Chọn bằng tay", 72, 172, 97, 17)
	GUICtrlSetState(-1, 32)
	Global $Button1 = GUICtrlCreateButton("Rock", 72, 200, 55, 21)
	Global $Button2 = GUICtrlCreateButton("Pop", 132, 200, 59, 21)
	Global $Button3 = GUICtrlCreateButton("Hip hop", 72, 224, 55, 21)
	Global $Button4 = GUICtrlCreateButton("Other", 132, 224, 59, 21)
	GUICtrlSetState($Button1, 32)
	GUICtrlSetState($Button2, 32)
	GUICtrlSetState($Button3, 32)
	GUICtrlSetState($Button4, 32)
	Global $Button5 = GUICtrlCreateButton("Bắt đầu", 20, 604, 75, 25)
	Global $Checkbox6 = GUICtrlCreateCheckbox("Nhiều acc:", 20, 256, 157, 17)
	Global $Label3 = GUICtrlCreateLabel("Profile:", 20, 284, 36, 17)
	Global $Input1 = GUICtrlCreateInput("Profile" & $dem, 72, 280, 121, 21)
	Global $Label4 = GUICtrlCreateLabel("Port:", 20, 316, 36, 17)
	Global $Input2 = GUICtrlCreateInput("424" & $dem + 2, 72, 312, 121, 21)
	GUICtrlSetState($Label3, 32)
	GUICtrlSetState($Label4, 32)
	GUICtrlSetState($Input1, 32)
	GUICtrlSetState($Input2, 32)

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
	For $k = 1 To 10
		GUICtrlSetState($lottery[$k], 32)
	Next
	$Button8 = GUICtrlCreateButton("Hướng dẫn", 16, 476, 203, 125)
	GUICtrlSetFont(-1, 27, 400, 0, 'Arial')
	$Button10 = GUICtrlCreateButton("Vào nhóm", 100, 604, 75, 25)
	GUICtrlSetColor(-1, '0xDD4F43')
	Global $Checkbox9 = GUICtrlCreateCheckbox("Tắt âm Firefox", 20, 232, 177, 17)
	Global $Checkbox10 = GUICtrlCreateCheckbox("Tắt ảnh", 20, 208, 173, 17)
	GUICtrlSetState($Checkbox9, $GUI_CHECKED)
	GUICtrlSetState($Checkbox10, $GUI_DISABLE)

	Global $TabSheet2 = GUICtrlCreateTabItem("Firefox")
	GUICtrlSetState(-1, $GUI_HIDE)
	Global $Input13 = GUICtrlCreateInput("Profile1", 48, 56, 121, 21)
	Global $Button6 = GUICtrlCreateButton("Tạo mới", 176, 52, 63, 25)
	Global $Button7 = GUICtrlCreateButton("Mở", 244, 52, 63, 25)
	$Button9 = GUICtrlCreateButton("Quản lý Profile", 312, 52, 119, 25)
	GUICtrlCreateTabItem("")
	#EndRegion ### END Koda GUI section ###
	child()
	While 1
		kiemtra2()
		If $danglogin = True Then
;~ 		GUIDelete($MainForm)
			If Not FileExists(@ScriptDir & '\data\temp\config.txt') Then
				_FileCreate(@ScriptDir & '\data\temp\config.txt')
				FileWrite(@ScriptDir & '\data\temp\config.txt', '0')
			EndIf
			If FileExists(@ScriptDir & '\data\temp\config.txt') Then
				$line1 = FileReadLine(@ScriptDir & '\data\temp\config.txt', 1)
				If $line1 = 0 Then
					Run('notepad.exe "' & @ScriptDir & '\changelog.txt"')
					_FileWriteToLine(@ScriptDir & '\data\temp\config.txt', 1, '1', True)
				EndIf
			EndIf
			GUISetState(@SW_HIDE, $MainForm)
			GUISetState(@SW_SHOW, $Form3)
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
		If $landau = True Then
			Local $stt = 3
			Local $i = 0
			Local $maso = 0
			Local $title = 'firefox.exe'
			$landau = False
			$batdau2 = True
		EndIf
		While 1
			If $batdau2 = True Then
;~ 		kiemtra2()

;~ 				MsgBox(0,'',_FFPrefGet('browser.preferences.privacy.selectedTabIndex'))
				_FFTabSetSelected(0)
				$txt=_FFReadHTML()
				$tickets=_StringBetween($txt,'class="entries-link">','&')
				If Not @error Then
					If $tickets[0]='10' Then
						ToolTip('Auto đã chạy xong')
						TrayTip('Profile '&$dem,'Auto đã chạy xong',3)
						MsgBox(0, 'Xong', 'Đã chạy xong',5)
						Exit
					EndIf
				EndIf
				GUICtrlSetData($Label5,'Đang tải trang...')
				_FFOpenURL('https://www.snuckls.com/video/videofeed')
				_FFLoadWait()


;~ 		Sleep(2000+$time)
;~ 		_FFLoadWait()
;~ 			$thoigian=_StringBetween($txt,'progress-value">','</span>')
				Local $txt = _FFReadHTML()
				If StringInStr($txt, 'CREATE YOUR TICKET!') Then ;watch-vdo-msg Oops! You got it wrong!
					$maso += 1
					If $maso = 11 And $solan=1 Then
						$maso=9
						$solan=2
					ElseIf $maso=11 And $solan=2 Then
						ToolTip('Auto đã chạy xong')
						TrayTip('Profile '&$dem,'Auto đã chạy xong',3)
						MsgBox(0, 'Xong', 'Đã chạy xong')
						Exit
					EndIf
					If GUICtrlRead($Checkbox7) = 1 Then
						Local $so = GUICtrlRead($lottery[$maso])
						If StringLen($so) >= 5 Then
							For $k = 1 To 5
								Local $chuso = StringRight(StringLeft($so, $k), 1)
								If IsInt(Execute($chuso)) Then
									If $chuso = '0' Then
										_FFClick('key-buttons', 'class', 9)
									Else
										_FFClick('key-buttons', 'class', $chuso - 1)
									EndIf
								Else
									_FFClick('key-buttons', 'class', Random(1, 10, 1) - 1)
								EndIf
							Next
						EndIf
					Else
						For $ii = 1 To 5
							_FFClick('key-buttons', 'class', Random(1, 10, 1) - 1)
						Next
					EndIf
					Sleep(500 + $time)
					_FFClick('submit-button', 'id')
					Sleep(1000 + $time)
					_FFOpenURL('https://www.snuckls.com')
				Else
;~ 					#cs
					$cho = True
					$txt=_FFReadHTML()
					$sovideo=_StringBetween($txt,'Watch ',' videos to get ticket')
					If @error Then
						MsgBox(0,'Error','Không tìm thấy video',3)
						ExitLoop
					Else
;~ 						$sovideo=1
						$sovideo=$sovideo[0]
					EndIf
					#cs
					$cookie=_FFGetCookie('snuckls.com')
					$cookie1=StringSplit($cookie,';')
					If UBound($cookie1)>=7 Then
						$cookie=$cookie1[6]&'; '&$cookie1[5]
					Else
						MsgBox(0,'Error', 'Không thể lấy cookie',3)
						ExitLoop(2)
					EndIf
					If $sovideo>=2 Then
						For $temp = 2 To $sovideo
							_FFTabAdd('https://www.snuckls.com/video/videofeed')
						Next
					EndIf
					For $temp = 1 To $sovideo
						_FFTabSetSelected($temp - 1)
						Local $objs = _FFObjGet('play-btn', 'class', $temp - 1)
						_FFClick($objs)
						_FFLoadWait()
						While 1
							$txt=_FFReadHTML()
							$videostring=_StringBetween($txt,'"videosString": "','"')
							If @error Then
								ClipPut($txt)
								MsgBox(0,'Error','Có lỗi trong quá trình xử lý',3)
							Else
								$videostring=$videostring[0]
								ExitLoop
							EndIf
						WEnd
						_FFCmd('.getElementById("emojis").getAttributeNode("style").value="display: block";')
						Local $emojiids=_FFCmd('.getElementsByTagName("a").length')
						For $temp= 1 To $emojiids
							If (_FFCmd('.getElementsByTagName("a")['&$temp&"].hasAttribute('emojiid')")) Then
								Sleep(2000)
								_FFCmd('.getElementsByTagName("a")['&$temp&"].click()")
								ExitLoop
							EndIf
						Next
						_FFLoadWait()
						If $cho = True Then
							$kiemtracaptcha=1
							For $temp = 1 To $sovideo
								_FFTabSetSelected($temp - 1)
								If $kiemtracaptcha=1 Then
									$objs=_FFObjGet('targetForCaptcha1')
									If $objs<>'' Then
										_FFCmd('.getElementById("emojis").getAttributeNode("style").value="display: block";')
										ToolTip('Hãy nhập captcha cho '&GUICtrlRead($Input1))
										TrayTip('Captcha','Hãy nhập captcha cho '&GUICtrlRead($Input1),3000)
										MsgBox(0,'Captcha','Sau khi nhập xong Captcha mới bấm OK')
										ToolTip('')
										$kiemtracaptcha=0
									EndIf
								EndIf
								Sleep($time)
							Next
							$cho = False
						EndIf
						Sleep(60000+$time)
						$open = _WinHttpOpen()
						$connect = _WinHttpConnect($open, 'snuckls.com')
						$request = _WinHttpOpenRequest($connect, 'POST', '/video/videofeedback/'&$videostring,Default,'https://www.snuckls.com/video/videofeed',Default,BitOR($WINHTTP_FLAG_SECURE,$WINHTTP_FLAG_ESCAPE_DISABLE))
						$captchaid=''
						$datapost='emojiid=21&user_watched_time='&Random(60,90,1)&'&total_video_duration='&Random(60,1200,1)&'&progress_value='&Random(60,99,1)&'&systemduration_timer='&Random(60,90,1)&'&video_session_index=0&catArr%5B%5D=21&catArr%5B%5D=21&catArr%5B%5D=21&catArr%5B%5D=21&captcha_value='&$captchaid&'&videosString='&$videostring
;~ 						MsgBox(0,'',$datapost&@CRLF&$cookie&@CRLF&$videostring)
						;~ $datapost='emojiid=21&user_watched_time='&Random(60,99,1)&'&total_video_duration=593&progress_value=97&systemduration_timer='&Random(60,99,1)&'&video_session_index=0&catArr%5B%5D=21&catArr%5B%5D=21&catArr%5B%5D=21&catArr%5B%5D=21&captcha_value=&videosString='&$videostring
						_WinHttpAddRequestHeaders($request,'User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0')
						_WinHttpAddRequestHeaders($request,'Host: www.snuckls.com')
						_WinHttpAddRequestHeaders($request,'Accept: application/json, text/javascript, */*; q=0.01')
						_WinHttpAddRequestHeaders($request,'Accept-Language: en-US,en;q=0.5')
						;~ _WinHttpAddRequestHeaders($request,'Accept-Encoding: gzip, deflate, br')
						_WinHttpAddRequestHeaders($request,'X-Requested-With: XMLHttpRequest')
;~ 						_WinHttpAddRequestHeaders($request,'Referer: https://www.snuckls.com/video/videofeed;')
						_WinHttpAddRequestHeaders($request,'Cookie: '&$cookie)
;~ 						_WinHttpAddRequestHeaders($request,'Content-Length: '&StringLen($datapost))
;~ 						_WinHttpAddRequestHeaders($request,'Content-Type: application/x-www-form-urlencoded; charset=UTF-8')
						_WinHttpAddRequestHeaders($request,'Connection: keep-alive')
						_WinHttpSendRequest($request,'Content-Type: application/x-www-form-urlencoded; charset=UTF-8',$datapost,StringLen($datapost))
						_WinHttpReceiveResponse($request)
						$txt = _WinHttpSimpleReadData($request)
						$sHeader = _WinHttpQueryHeaders($Request)
						MsgBox(0,'',$sHeader&@CRLF&$txt)
						_WinHttpCloseHandle($Request)
						_WinHttpCloseHandle($Connect)
						_WinHttpCloseHandle($Open)
					Next
					#ce
					;get cookie
					$cookie=_FFGetCookie('snuckls.com')
					$cookie1=StringSplit($cookie,';')
					$cookie=''
					For $temp2=0 to UBound($cookie1)-1
						If StringInStr($cookie1[$temp2],'ci_session') Then
							$cookie&=$cookie1[$temp2]&'; '
						EndIf
						If StringInStr($cookie1[$temp2],'__cfduid') Then
							$cookie&=$cookie1[$temp2]&'; '
						EndIf
						If StringInStr($cookie,'ci_session') And StringInStr($cookie,'__cfduid') Then
							ExitLoop
						EndIf
					Next
;~ 					MsgBox(0,'',$cookie)
;~ 					$cookie1=StringSplit($cookie,';')
;~ 					If UBound($cookie1)>=7 Then
;~ 						$cookie=$cookie1[6]&'; '&$cookie1[5]
;~ 					Else
;~ 						MsgBox(0,'Error', 'Không thể lấy cookie',3)
;~ 						ExitLoop(2)
;~ 					EndIf
					;WinHttp method
					Global $open[7],$connect[7],$request[7],$valuecaptcha[7],$datapost[7],$videostring[7],$captchaneeded[7],$coderecaptcha[7],$duration[7],$needscaptchabool=False
					Global $ans[7],$allans[7][4]
					$open = _WinHttpOpen()
					$connect = _WinHttpConnect($open, 'snuckls.com')
					For $temp2=0 To $sovideo-1
						GUICtrlSetData($Label5,'Đang kết nối tới máy chủ...')
;~ 						$open[$temp2] = _WinHttpOpen()
;~ 						$connect[$temp2] = _WinHttpConnect($open[$temp2], 'snuckls.com')
						;~ $videostring='da3891664758f81e87f758ecdf14af98'
	;~ 					$cookie='ci_session=b9fed357e344a3d8b74a845e2626731ece69fc13; __cfduid=d8388c5732b36a96a242f3ed8e7ff45a71491449606'

						$request[$temp2] = _WinHttpOpenRequest($connect, 'GET', '/video/videofeed',Default,'https://www.snuckls.com/video/ticketdetails',Default,$WINHTTP_FLAG_SECURE)

						_WinHttpAddRequestHeaders($request[$temp2],'User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0')
						_WinHttpAddRequestHeaders($request[$temp2],'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8')
						_WinHttpAddRequestHeaders($request[$temp2],'Accept-Language: en-US,en;q=0.5')
						;~ _WinHttpAddRequestHeaders($request,'Accept-Encoding: gzip, deflate, br');this make code wrong
						_WinHttpAddRequestHeaders($request[$temp2],'Cookie: '&$cookie)
						_WinHttpAddRequestHeaders($request[$temp2],'Connection: keep-alive')
						_WinHttpAddRequestHeaders($request[$temp2],'Upgrade-Insecure-Requests: 1')
						_WinHttpSendRequest($request[$temp2])
						_WinHttpReceiveResponse($request[$temp2])
						$response = _WinHttpSimpleReadData($request[$temp2])
						$sHeader = _WinHttpQueryHeaders($Request[$temp2])
						$videostring1=_StringBetween($response,'"videosString": "','"')
						If Not @error Then
	;~ 						GUICtrlSetData($Label5,'Kết nối thành công...')
							$videostring[$temp2]=$videostring1[0]
						Else
							GUICtrlSetData($Label5,'(1) Lỗi trong quá trình xử lý!')
							InputBox('Error','Hãy vào link sau để xem cách giải quyết:','https://www.facebook.com/groups/1829937350594308/permalink/1854649604789749/',Default,Default,Default,Default,Default,5)
	;~ 						Sleep(2000)
							$temp2=$temp2-1
	;~ 						ExitLoop
						EndIf
						Sleep(10000)
;~ 					Next
;~ 					_ArrayDisplay($videostring)
;~ 					For $temp2=0 To $sovideo-1
;~ 						GUICtrlSetData($Label5,'Đang lọc dữ liệu...')
						$request[$temp2] = _WinHttpOpenRequest($connect, 'GET', '/video/getthevideoindexdata/'&$temp2&'/'&$videostring[$temp2],Default,'https://www.snuckls.com/video/videofeed',Default,$WINHTTP_FLAG_SECURE)
						_WinHttpAddRequestHeaders($request[$temp2],'User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0')
						_WinHttpAddRequestHeaders($request[$temp2],'Accept: application/json, text/javascript, */*; q=0.01')
						_WinHttpAddRequestHeaders($request[$temp2],'Accept-Language: en-US,en;q=0.5')
						_WinHttpAddRequestHeaders($request[$temp2],'X-Requested-With: XMLHttpRequest')
						_WinHttpAddRequestHeaders($request[$temp2],'Cookie: '&$cookie)
						_WinHttpAddRequestHeaders($request[$temp2],'Connection: keep-alive')
						_WinHttpSendRequest($request[$temp2])
						_WinHttpReceiveResponse($request[$temp2])
						$response = _WinHttpSimpleReadData($request[$temp2])
						$sHeader = _WinHttpQueryHeaders($Request[$temp2])
						If Not StringInStr($response,'"cat":"None"') Then
							$temp2-=1
							ContinueLoop
							#cs
							GUICtrlSetData($Label5,'Đang kết nối tới máy chủ....')
							;~ $videostring='da3891664758f81e87f758ecdf14af98'
		;~ 					$cookie='ci_session=b9fed357e344a3d8b74a845e2626731ece69fc13; __cfduid=d8388c5732b36a96a242f3ed8e7ff45a71491449606'

							$request[$temp2] = _WinHttpOpenRequest($connect[$temp2], 'GET', '/video/videofeed',Default,'https://www.snuckls.com/video/ticketdetails',Default,$WINHTTP_FLAG_SECURE)

							_WinHttpAddRequestHeaders($request[$temp2],'User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0')
							_WinHttpAddRequestHeaders($request[$temp2],'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8')
							_WinHttpAddRequestHeaders($request[$temp2],'Accept-Language: en-US,en;q=0.5')
							;~ _WinHttpAddRequestHeaders($request,'Accept-Encoding: gzip, deflate, br');this make code wrong
							_WinHttpAddRequestHeaders($request[$temp2],'Cookie: '&$cookie)
							_WinHttpAddRequestHeaders($request[$temp2],'Connection: keep-alive')
							_WinHttpAddRequestHeaders($request[$temp2],'Upgrade-Insecure-Requests: 1')
							_WinHttpSendRequest($request[$temp2])
							_WinHttpReceiveResponse($request[$temp2])
							$response = _WinHttpSimpleReadData($request[$temp2])
							$sHeader = _WinHttpQueryHeaders($Request[$temp2])
							$videostring1=_StringBetween($response,'"videosString": "','"')
							If Not @error Then
;~ 								GUICtrlSetData($Label5,'Kết nối thành công...')
								$videostring[$temp2]=$videostring1[0]
							Else
								GUICtrlSetData($Label5,'(1) Lỗi trong quá trình xử lý!')
								InputBox('Error','Hãy vào link sau để xem cách giải quyết:','https://www.facebook.com/groups/1829937350594308/permalink/1854649604789749/',Default,Default,Default,Default,Default,5)
		;~ 						Sleep(2000)
;~ 								$temp2=$temp2-1
		;~ 						ExitLoop
							EndIf
							$temp2-=1
							Sleep(500)
							#ce
						Else
							ConsoleWrite($response&@CRLF)
							$ans1=_StringBetween($response,'"id"','}')
							If Not @error Then
								For $temp=0 To UBound($ans1)-1
									If StringInStr($ans1[$temp],'None') Then
										$ans1=_StringBetween($ans1[$temp],':',',')
										If Not @error Then
											$ans[$temp2]=$ans1[0]
											ConsoleWrite($ans1&@CRLF)
										Else
											GUICtrlSetData($Label5,'(4) Lỗi trong quá trình xử lý!')
											$temp2=$temp2-1
										EndIf
										$allans1=_StringBetween($response,'"id":',',')
										If Not @error Then
											$allans[$temp2][0]=$allans1[0]
											$allans[$temp2][1]=$allans1[1]
											$allans[$temp2][2]=$allans1[2]
											$allans[$temp2][3]=$allans1[3]
										Else
											GUICtrlSetData($Label5,'(5) Lỗi trong quá trình xử lý!')
											$temp2=$temp2-1
										EndIf
										ExitLoop
									EndIf
								Next
							Else
								GUICtrlSetData($Label5,'(3) Lỗi trong quá trình xử lý!')
								$temp2=$temp2-1
		;~ 						ExitLoop
							EndIf
							$captchaneeded1=_StringBetween($response,'"captchaNeeded":','}')
							;~ Json_Get($response,'["data"]')
							If Not @error Then
								$captchaneeded[$temp2]=$captchaneeded1[0]
								$valuecaptcha=''
								$duration1=_StringBetween($response,'"duration":',',')
								If Not @error Then
									$duration[$temp2]=$duration1[0]
								EndIf
								$duration1=_StringBetween($response,'"duration":',',')
								If Not @error Then
									$duration[$temp2]=$duration1[0]
								EndIf
		;~ 						MsgBox(0,'',$captchaneeded[$temp2])
							Else
								GUICtrlSetData($Label5,'(2) Lỗi trong quá trình xử lý!')
		;~ 						Sleep(2000)
		;~ 						ExitLoop
								$temp2=$temp2-1
							EndIf
						EndIf
						Sleep(5000)
					Next
;~ 					_ArrayDisplay($videostring)
;~ 					_ArrayDisplay($captchaneeded)
					If $captchaneeded[0]='1' Then
						GUICtrlSetData($Label5,'Có captcha...')
						Local $objs = _FFObjGet('play-btn', 'class', 0)
						_FFClick($objs)
						_FFLoadWait()
;~ 						$str = _FFCmd('.getElementsByTagName("iframe")[0].getAttributeNode("src").value')
;~ 						If StringInStr($str, 'enablejsapi=1&autoplay=false&controls=0&rel=0&showinfo=0&egm=0&showsearch=0&modestbranding=1&iv_load_policy=3&disablekb=1&loop=0&start=0') Then
;~ 							$res = StringReplace($str, 'autoplay=false&controls=0&rel=0&showinfo=0&egm=0&showsearch=0&modestbranding=1&iv_load_policy=3&disablekb=1&loop=0&start=0', 'autoplay=1&rel=0&showinfo=0&egm=0&showsearch=0&modestbranding=1&iv_load_policy=3&loop=0&start=100')
;~ 							_FFCmd('.getElementsByTagName("iframe")[0].getAttributeNode("src").value="' & $res & '"')
;~ 						EndIf
						Do
							$objs=_FFObjGet('targetForCaptcha1')
						Until $objs<>'' Or $objs='_FFCmd_Err'
						If $objs<>'' Then
							_FFCmd('.getElementById("emojis").getAttributeNode("style").value="display: block";')
							_FFCmd('.getElementById("targetForCaptcha1").getAttributeNode("style").value="display: block";')
							ToolTip('Hãy nhập captcha cho '&GUICtrlRead($Input1))
							TrayTip('Captcha','Hãy nhập captcha cho '&GUICtrlRead($Input1),3000)
							MsgBox(0,'Captcha','Sau khi nhập xong Captcha mới bấm OK')
							ToolTip('')
						EndIf
;~ 						Do
;~ 							$scrrecaptcha=_FFCmd(".getElementsByTagName('iframe')[1].getAttributeNode('src').value")
;~ 						Until StringInStr($scrrecaptcha,'recaptcha')
;~ 						_FFTabAdd($scrrecaptcha)
;~ 						_FFTabSetSelected(1)

;~ 						Do
;~ 							$coderecaptcha[0]=_FFCmd(".getElementsByTagName('input')[0].getAttributeNode('value').value")
;~ 						Until $coderecaptcha[0]<>''
;~ 						MsgBox(0,'',$coderecaptcha[0])
;~ 						_FFTabSetSelected(1)
;~ 						_FFTabClose(1)
;~ 						$valuecaptcha=$coderecaptcha[0]
;~ 						$txt=_FFReadHTML()
;~ 						$videostring1=_StringBetween($txt,'"videosString": "','"')
;~ 						If Not @error Then
;~ 							$videostring[0]=$videostring1[0]
;~ 							MsgBox(0,'',$videostring[0])
;~ 						EndIf

						_FFCmd('.getElementById("emojis").getAttributeNode("style").value="display: block";')
						Local $emojiids=_FFCmd('.getElementsByTagName("a").length')
						For $temp= 1 To $emojiids
							If (_FFCmd('.getElementsByTagName("a")['&$temp&"].hasAttribute('emojiid')")) Then
								GUICtrlSetData($Label5,'Đang lấy data captcha...')
								Sleep(10000)
								GUICtrlSetData($Label5,'Đang mã hóa data captcha...')
								Sleep(10000)
								GUICtrlSetData($Label5,'Đang gửi captcha...')
								Sleep(10000)
								GUICtrlSetData($Label5,'Tiếp tục mã hóa...')
								Sleep(10000)
								GUICtrlSetData($Label5,'Đang gửi data...')
								Sleep(10000)
								GUICtrlSetData($Label5,'Lọc kết quả...')
								Sleep(10000+$time)
								GUICtrlSetData($Label5,'Gửi thành công!...')
								_FFCmd('.getElementsByTagName("a")['&$temp&"].click()")
								Sleep(1000+$time)
;~ 								MsgBox(0,'','')
								ExitLoop(2)
							EndIf
						Next
					EndIf
					GUICtrlSetData($Label5,'Đang mã hóa 1/5...')
					Sleep(10000)
					GUICtrlSetData($Label5,'Đang mã hóa 2/5...')
					Sleep(10000)
					GUICtrlSetData($Label5,'Đang mã hóa 3/5...')
					Sleep(10000)
					GUICtrlSetData($Label5,'Đang mã hóa 4/5...')
					Sleep(10000)
					GUICtrlSetData($Label5,'Đang mã hóa 5/5...')
					Sleep(10000)
					GUICtrlSetData($Label5,'Lọc kết quả...')
					Sleep(60000+$time)
					GUICtrlSetData($Label5,'Xong...')
					$userwatchedtime=0
					For $temp2=0 To $sovideo-1
						GUICtrlSetData($Label5,'Gửi dữ liệu '&$temp2+1&'/'&$sovideo)
;~ 						ToolTip($temp2)
						$userwatchedtime+=Random(60,99,1)
						$systemtime=$userwatchedtime+3
					$request[$temp2] = _WinHttpOpenRequest($connect, 'POST', '/video/videofeedback/'&$videostring[$temp2],Default,'https://www.snuckls.com/video/videofeed',Default,BitOR($WINHTTP_FLAG_SECURE,$WINHTTP_FLAG_ESCAPE_DISABLE))
					;~ $datapost='emojiid=21&user_watched_time=90&total_video_duration=320&progress_value=97&systemduration_timer=90&video_session_index=0&catArr%5B%5D=21&catArr%5B%5D=21&catArr%5B%5D=21&catArr%5B%5D=21&captcha_value=03AOP2lf6VLqojMyMYj-fu20RQJAe7knAz65u62M36nQrgYOJMgjG0-HQ2pTfTFqtu1Wf6tL8lw7gqKz3RiTf7EhRqEJ6VK7JudevkHZuTqdcmpX3afBjrNJ4RzZuqgRpDxR0ESNXCpqPborPuFZtMFIQw0DUEYweUGZa0R5xPNp1S_4Doarpoy5RqmGz4Hp8me1mVFwd4soN2FD6OFDAfllqQSsjO1bLX46siiYFgHHWbtQHSUyNKWQ_op8cqpUAf1V_3dI7KsmE_rCd6d02j5ixXiUQSUpuWpObFKoBTA1czRkOLtGK4miPQ4uBm42nRKLi4FHsZTuzhmMGa1mQxtzPvr5ukg3Af7RrorHKrCwHdif8w5ZKbV4-PZcBgVbDk0LosfyX8bQH3_vkKv18P0DZfv1AxUMyrhw&videosString='&$videostring
;~ 					$datapost[$temp2]='emojiid=21&user_watched_time='&Random(60,99,1)&'&total_video_duration='&Random(60,1200,1)&'&progress_value='&Random(60,99,1)&'&systemduration_timer='&Random(60,99,1)&'&video_session_index='&$temp2&'&catArr%5B%5D=21&catArr%5B%5D=21&catArr%5B%5D=21&catArr%5B%5D=21&captcha_value='&$valuecaptcha&'&videosString='&$videostring[$temp2]
					$datapost[$temp2]='emojiid='&$ans[$temp2]&'&user_watched_time='&$userwatchedtime&'&total_video_duration='&$duration[$temp2]&'&progress_value='&Random(60,99,1)&'&systemduration_timer='&$systemtime&'&video_session_index='&$temp2&'&catArr%5B%5D='&$allans[$temp2][0]&'&catArr%5B%5D='&$allans[$temp2][1]&'&catArr%5B%5D='&$allans[$temp2][2]&'&catArr%5B%5D='&$allans[$temp2][3]&'&captcha_value='&$valuecaptcha&'&videosString='&$videostring[$temp2]
;~ 					MsgBox(0,'',$datapost[$temp2])
					_WinHttpAddRequestHeaders($request[$temp2],'User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0')
					_WinHttpAddRequestHeaders($request[$temp2],'Host: www.snuckls.com')
					_WinHttpAddRequestHeaders($request[$temp2],'Accept: application/json, text/javascript, */*; q=0.01')
					_WinHttpAddRequestHeaders($request[$temp2],'Accept-Language: en-US,en;q=0.5')
					;~ _WinHttpAddRequestHeaders($request,'Accept-Encoding: gzip, deflate, br')
					_WinHttpAddRequestHeaders($request[$temp2],'X-Requested-With: XMLHttpRequest')
					;~ _WinHttpAddRequestHeaders($request,'Referer: https://www.snuckls.com/video/videofeed;')
					_WinHttpAddRequestHeaders($request[$temp2],'Cookie: '&$cookie)
					;~ _WinHttpAddRequestHeaders($request,'Content-Length: '&StringLen($datapost))
					;~ _WinHttpAddRequestHeaders($request,'Content-Type: application/x-www-form-urlencoded; charset=UTF-8')
					_WinHttpAddRequestHeaders($request[$temp2],'Connection: keep-alive')
					_WinHttpSendRequest($request[$temp2],'Content-Type: application/x-www-form-urlencoded; charset=UTF-8',$datapost[$temp2],StringLen($datapost[$temp2]))
					_WinHttpReceiveResponse($request[$temp2])
					$response = _WinHttpSimpleReadData($request[$temp2])
					$sHeader = _WinHttpQueryHeaders($Request[$temp2])
					MsgBox(0,'',$sHeader&@CRLF&$response&@CRLF&$datapost[$temp2])
;~ 					If $needscaptchabool=True Then
;~ 						$needscaptchabool=False
;~ 						ExitLoop
;~ 					EndIf
					$needscaptcha=_StringBetween($response,'"needsCaptcha":','}')
					If Not @error Then
						If $needscaptcha[0]='1' Then
;~ 							$needscaptchabool=True
;~ 							Local $objs = _FFObjGet('play-btn', 'class', 0)
;~ 							_FFClick($objs)
;~ 							_FFLoadWait()
;~ 							$objs=_FFObjGet('targetForCaptcha1')
;~ 							If $objs<>'' Then
;~ 								_FFCmd('.getElementById("emojis").getAttributeNode("style").value="display: block";')
;~ 								_FFCmd('.getElementById("targetForCaptcha1").getAttributeNode("style").value="display: block";')
;~ 								ToolTip('Hãy nhập captcha cho '&GUICtrlRead($Input1))
;~ 								TrayTip('Captcha','Hãy nhập captcha cho '&GUICtrlRead($Input1),3000)
;~ 								MsgBox(0,'Captcha','Sau khi nhập xong Captcha mới bấm OK')
;~ 								ToolTip('')
;~ 							EndIf
;~ 							Do
;~ 								$scrrecaptcha=_FFCmd(".getElementsByTagName('iframe')[1].getAttributeNode('src').value")
;~ 							Until StringInStr($scrrecaptcha,'recaptcha')
;~ 							_FFTabAdd($scrrecaptcha)
;~ 							_FFTabSetSelected(1)
;~ 							$txt=_FFReadHTML()
;~ 							Do
;~ 								$coderecaptcha[$temp2]=_FFCmd(".getElementsByTagName('input')[0].getAttributeNode('value').value")
;~ 							Until $coderecaptcha[$temp2]<>''
;~ 							MsgBox(0,'',$coderecaptcha[$temp2])
;~ 							_FFTabSetSelected(1)
;~ 							_FFTabClose(1)
;~ 							$valuecaptcha=$coderecaptcha[$temp2]
;~ 							$temp2=$temp2-1
							ExitLoop
						EndIf
;~ 						Sleep(25000)
					EndIf

					Next
					For $temp2=0 To $sovideo-1
						GUICtrlSetData($Label5,'Xóa dữ liệu...')
						_WinHttpCloseHandle($Request[$temp2])
						_WinHttpCloseHandle($Connect)
						_WinHttpCloseHandle($Open)
					Next
					GUICtrlSetData($Label5,'...')
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
EndFunc   ;==>auto

Func _FFGetCookie($sUrl)
    Local $aArray, $sString

    $aArray = _FFGetCookieGroup($sUrl)

    For $i = 0 To UBound($aArray) - 1
        $sString &= $aArray[$i][0] & "=" & $aArray[$i][1] & "; "
    Next

    Return $sString
EndFunc
Func _FFGetCookieGroup($sUrl)
    Local $aCookies, $iCounter, $iPlace

    $aCookies = _FFGetAllCookies()

    For $i = 0 To UBound($aCookies) - 1
        If StringRegExp($aCookies[$i][2], $sURL, 0) Then $iCounter += 1
    Next

    Dim $aCookieGroup[$iCounter][2]

    For $i = 0 To UBound($aCookies) - 1
        If StringRegExp($aCookies[$i][2], $sURL, 0) Then
            $aCookieGroup[$iPlace][0] = $aCookies[$i][0]
            $aCookieGroup[$iPlace][1] = $aCookies[$i][1]
            $iPlace += 1
        EndIf
    Next

    Return $aCookieGroup
EndFunc
Func _FFGetAllCookies()
    ;~  © 4ggr35510n ©

    Local $aT, $aTA
    $sCS = _FFCmd("var cookiestring='';var cookieManager=Components.classes['@mozilla.org/cookiemanager;1'].getService(Components.interfaces.nsICookieMana"& _
    "ger);var iter=cookieManager.enumerator;while(iter.hasMoreElements()){var cookie=iter.getNext();if(cookie instanceof Components.interfaces.nsICookie){"& _
    "cookiestring+=cookie.name+'='+cookie.value+'='+cookie.host+';';}};cookiestring;")
    $aTA = StringSplit($sCS, ';')
    Local $aCA[$aTA[0]-1][3]
    For $i = 1 to $aTA[0] - 1
        $aT = StringSplit($aTA[$i], '=')
        $aCA[$i-1][0] = $aT[1]
        If $aT[0] > 3 Then  ; in case that cookie.value contains equals signs '=' [ it's more common then you think! ]
            For $j = 2 to $aT[0] - 1
                $aCA[$i-1][1] &= $aT[$j] & '='
            Next
            $aCA[$i-1][1] &= $aT[$aT[0]-1]
        Else
            $aCA[$i-1][1] &= $aT[2]
        EndIf
        $aCA[$i-1][2] = $aT[$aT[0]]
    Next
    Return $aCA

    ;~  © 4ggr35510n ©
EndFunc
Func checkbox9()
	If GUICtrlRead($Checkbox9) = 1 Then
		Run(@ScriptDir & '\data\mute\nircmd.exe muteappvolume firefox.exe 1')
	Else
		Run(@ScriptDir & '\data\mute\nircmd.exe muteappvolume firefox.exe 0')
	EndIf
EndFunc   ;==>checkbox9
Func ran1()
	$ran = 1
	GUICtrlSetState($Button1, 32)
	GUICtrlSetState($Button2, 32)
	GUICtrlSetState($Button3, 32)
	GUICtrlSetState($Button4, 32)
	$objs = _FFObjGet('border-btn emojiclick', 'class', $ran - 1)
	_FFClick($objs)
	Sleep(1000 + $time)
	$batdau2 = True
EndFunc   ;==>ran1
Func ran2()
	$ran = 2
	GUICtrlSetState($Button1, 32)
	GUICtrlSetState($Button2, 32)
	GUICtrlSetState($Button3, 32)
	GUICtrlSetState($Button4, 32)
	$objs = _FFObjGet('border-btn emojiclick', 'class', $ran - 1)
	_FFClick($objs)
	Sleep(1000 + $time)
	$batdau2 = True
EndFunc   ;==>ran2
Func ran3()
	$ran = 3
	GUICtrlSetState($Button1, 32)
	GUICtrlSetState($Button2, 32)
	GUICtrlSetState($Button3, 32)
	GUICtrlSetState($Button4, 32)
	$objs = _FFObjGet('border-btn emojiclick', 'class', $ran - 1)
	_FFClick($objs)
	Sleep(1000 + $time)
	$batdau2 = True
EndFunc   ;==>ran3
Func ran4()
	$ran = 4
	GUICtrlSetState($Button1, 32)
	GUICtrlSetState($Button2, 32)
	GUICtrlSetState($Button3, 32)
	GUICtrlSetState($Button4, 32)
	$objs = _FFObjGet('border-btn emojiclick', 'class', $ran - 1)
	_FFClick($objs)
	Sleep(1000 + $time)
	$batdau2 = True
EndFunc   ;==>ran4
Func huongdan()
	Run('notepad.exe "' & @ScriptDir & '\huongdan.txt"')
EndFunc   ;==>huongdan
Func button10()
	ShellExecute('https://www.facebook.com/groups/1829937350594308')
EndFunc   ;==>button10
Func button9()
	Local $sHKLM = 'HKEY_LOCAL_MACHINE\SOFTWARE\'
	If @OSArch <> 'X86' Then $sHKLM &= 'Wow6432Node\'
	$sHKLM &= 'Mozilla\Mozilla Firefox'
	Local $sFFExe = RegRead($sHKLM & "\" & RegRead($sHKLM, "CurrentVersion") & "\Main", "PathToExe")
	If @error Then
		MsgBox(0, 'Error', 'Không tìm thấy Firefox')
		Return 0
	EndIf
	Run('"' & $sFFExe & '"' & ' -ProfileManager')
EndFunc   ;==>button9
Func button7()
	Local $sHKLM = 'HKEY_LOCAL_MACHINE\SOFTWARE\'
	If @OSArch <> 'X86' Then $sHKLM &= 'Wow6432Node\'
	$sHKLM &= 'Mozilla\Mozilla Firefox'
	Local $sFFExe = RegRead($sHKLM & "\" & RegRead($sHKLM, "CurrentVersion") & "\Main", "PathToExe")
	If @error Then
		MsgBox(0, 'Error', 'Không tìm thấy Firefox')
		Return 0
	EndIf
	Run('"' & $sFFExe & '"' & ' -no-remote -p "' & GUICtrlRead($Input13) & '"')
EndFunc   ;==>button7
Func button6()
	Local $sHKLM = 'HKEY_LOCAL_MACHINE\SOFTWARE\'
	If @OSArch <> 'X86' Then $sHKLM &= 'Wow6432Node\'
	$sHKLM &= 'Mozilla\Mozilla Firefox'
	Local $sFFExe = RegRead($sHKLM & "\" & RegRead($sHKLM, "CurrentVersion") & "\Main", "PathToExe")
	If @error Then
		MsgBox(0, 'Error', 'Không tìm thấy Firefox')
		Return 0
	EndIf
	Run('"' & $sFFExe & '"' & ' -no-remote -CreateProfile ' & GUICtrlRead($Input13))
	MsgBox(0, 'Xong', 'Đã tạo ' & GUICtrlRead($Input13))
EndFunc   ;==>button6
Func checkbox8()
	GUICtrlSetState($Checkbox1, $GUI_UNCHECKED)
	GUICtrlSetState($Checkbox2, $GUI_UNCHECKED)
	GUICtrlSetState($Checkbox3, $GUI_UNCHECKED)
	GUICtrlSetState($Checkbox4, $GUI_UNCHECKED)
	GUICtrlSetState($Checkbox5, $GUI_UNCHECKED)
EndFunc   ;==>checkbox8
Func checkbox7()
	If GUICtrlRead($Checkbox7) = 1 Then
		For $k = 1 To 10
			GUICtrlSetState($lottery[$k], 16)
		Next
	Else
		For $k = 1 To 10
			GUICtrlSetState($lottery[$k], 32)
		Next
	EndIf
EndFunc   ;==>checkbox7
Func checkbox6()
	GUICtrlSetState($Checkbox1, $GUI_UNCHECKED)
	GUICtrlSetState($Checkbox2, $GUI_UNCHECKED)
	GUICtrlSetState($Checkbox3, $GUI_UNCHECKED)
	GUICtrlSetState($Checkbox4, $GUI_UNCHECKED)
	If GUICtrlRead($Checkbox6) = 1 Then
		GUICtrlSetState($Label3, 16)
		GUICtrlSetState($Label4, 16)
		GUICtrlSetState($Input1, 16)
		GUICtrlSetState($Input2, 16)
	Else
		GUICtrlSetState($Label3, 32)
		GUICtrlSetState($Label4, 32)
		GUICtrlSetState($Input1, 32)
		GUICtrlSetState($Input2, 32)
	EndIf
EndFunc   ;==>checkbox6
Func button5()
	If GUICtrlRead($Radio1) = 1 Then
		$time = 0
	Else
		$time = 3000
	EndIf
	If GUICtrlRead($Checkbox1) = 1 Then
		$option &= 1
	EndIf
	If GUICtrlRead($Checkbox2) = 1 Then
		$option &= 2
	EndIf
	If GUICtrlRead($Checkbox3) = 1 Then
		$option &= 3
	EndIf
	If GUICtrlRead($Checkbox4) = 1 Then
		$option &= 4
	EndIf
	If GUICtrlRead($Checkbox6) = 1 Then
		$ff = __FFStartProcess('https://www.snuckls.com', False, GUICtrlRead($Input1), True, False, Execute(GUICtrlRead($Input2)))
;~ 				_FFConnect(Default,GUICtrlRead($Input2))
		$ie = _FFWindowGetHandle(10000)
		GUISetStyle(BitOR($WS_CHILD, $WS_POPUPWINDOW), 0, $ie)
	Else
		$ff = __FFStartProcess('https://www.snuckls.com', False, 'default', True, False, 4242)
;~ 				_FFConnect(Default,'default')
		$ie = _FFWindowGetHandle(10000)
		GUISetStyle(BitOR($WS_CHILD, $WS_POPUPWINDOW), 0, $ie)
	EndIf
	If GUICtrlRead($Checkbox9) = 1 Then
		Run('"' & @ScriptDir & '\data\mute\nircmd.exe" muteappvolume firefox.exe 1')
	Else
		Run('"' & @ScriptDir & '\data\mute\nircmd.exe" muteappvolume firefox.exe 0')
	EndIf
	If GUICtrlRead($Checkbox10) = 1 Then
		_FFCmd('Components.classes["@mozilla.org/preferences-service;1"].getService(Components.interfaces.nsIPrefBranch).setIntPref("permissions.default.image",2);')
	Else
		_FFCmd('Components.classes["@mozilla.org/preferences-service;1"].getService(Components.interfaces.nsIPrefBranch).setIntPref("permissions.default.image",1);')
	EndIf
	_WinAPI_SetParent($ie, $Form3)
	WinMove($ie, "", 224, 48, 905, 581)
	_WinAPI_RedrawWindow($ie)
	_WinAPI_RedrawWindow($Form3)

	batdau()
EndFunc   ;==>button5

Func batdau()
	$landau = True
EndFunc   ;==>batdau

Func yt($txt) ;Oops! Seems you already have 10 tickets. Max 10 tickets per draw.
	Local $link = _StringBetween($txt, 'author-detail">', 'id="videoTitle">')
	If Not @error Then
		$link = _StringBetween($link[0], 'youtube.com', '"')
		If Not @error Then
			$link = $link[0]
			$open = _WinHttpOpen()
			$connect = _WinHttpConnect($open, 'youtube.com')
			$request = _WinHttpOpenRequest($connect, 'GET', $link)
			_WinHttpSendRequest($request)
			_WinHttpReceiveResponse($request)
			$txt = _WinHttpSimpleReadData($request)
			_WinHttpCloseHandle($Request)
			_WinHttpCloseHandle($Connect)
			_WinHttpCloseHandle($Open)
			$cate = _StringBetween($txt, 'content watch-info-tag-list', '</ul>')
			If Not @error Then
				$cate = $cate[0]
				If StringInStr($cate, 'Music') Or StringInStr($cate, 'nhạc') Then
					Return 'Hip hop'
				Else
					Return 'Others'
				EndIf
			EndIf
		Else

		EndIf
	Else
	EndIf
EndFunc   ;==>yt


Func check2() ;http://ptctemp.blogspot.com/2017/02/version.html
	$open = _WinHttpOpen()
	$connect = _WinHttpConnect($open, 'ptctemp.blogspot.com')
	$request = _WinHttpOpenRequest($connect, 'GET', '2017/03/snucklsver.html')

	_WinHttpSendRequest($request)
	_WinHttpReceiveResponse($request)
	$txt = _WinHttpSimpleReadData($request)
	$ok = _StringBetween($txt, "verrrr", "endverrrr")
	If Not @error Then
		If $ok[0] <> $ver Then
			$updatelink = _StringBetween($txt, 'downnn', 'enddownnn')
			If Not @error Then
				ToolTip('Auto đang tải bản '&$ok[0]&', nếu k cập nhật đc hãy vào nhóm để lấy link tải')
				InetGet($updatelink[0], @ScriptDir & '\data\Temp\AutoSnucklsFF.rar')
				RunWait('"' & @ScriptDir & '\data\rar\Unrar.exe"' & ' e "' & @ScriptDir & '\data\temp\AutoSnucklsFF.rar" "' & @ScriptDir & '\data\temp\" ' & '-y', '', @SW_HIDE)
				FileDelete(@ScriptDir & '\data\temp\AutoSnucklsFF.rar')
				If Not FileExists(@ScriptDir & '\data\temp\config.txt') Then
					_FileCreate(@ScriptDir & '\data\temp\config.txt')
					FileWrite(@ScriptDir & '\data\temp\config.txt', '0')
				EndIf
				If FileExists(@ScriptDir & '\data\temp\config.txt') Then
					_FileWriteToLine(@ScriptDir & '\data\temp\config.txt', 1, '0', True)
				EndIf
				_selfupdate(@ScriptDir & '\data\temp\AutoSnucklsFF.exe', True, 5, Default, False)
				Exit
			Else
				MsgBox(0, 'Error', 'Không thể cập nhật')
				Exit
			EndIf
		EndIf
	Else
		InputBox('Error', 'Auto không tự cập nhật đc, bạn hãy tải ở link sau:', 'https://drive.google.com/open?id=0B4DSs5oUzA_BLTNsTTRaWk5ZVlk')
		Exit
	EndIf

	_WinHttpCloseHandle($Request)
	_WinHttpCloseHandle($Connect)
	_WinHttpCloseHandle($Open)

EndFunc   ;==>check2

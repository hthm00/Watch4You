;~ #NoTrayIcon

#Region AutoIt3Wrapper directives section
;~ #Autoit3Wrapper_Testing=Y;=> Change to N when compile
#AutoIt3Wrapper_Icon=E:\wamp\www\favicon.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=Y
;~ #AutoIt3Wrapper_Compile_both=Y;=> Compile both X86 and X64 in one run
#AutoIt3Wrapper_Res_Comment=Developed by Juno_okyo
#AutoIt3Wrapper_Res_Description=Developed by Juno_okyo
#AutoIt3Wrapper_Res_Fileversion=1.0.0.10
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=Y
#AutoIt3Wrapper_Res_ProductVersion=1.0.0.0;=>Edit
#AutoIt3Wrapper_Res_LegalCopyright=(C) 2015 Juno_okyo. All rights reserved.
#EndRegion AutoIt3Wrapper directives section

#Region Auto Created by Minh Huynh

#Region Includes
#include <INet.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <GuiStatusBar.au3>
#include <GuiListView.au3>
#include <GuiTab.au3>
#include <Array.au3>
#include <Misc.au3>
#include 'includes/BinaryCall.au3'
#include 'includes/JSON.au3'
#include 'includes/http.au3'
;~ #include 'AutoSnucklsFF.au3'
#EndRegion Includes

;~ _Singleton(@ScriptName)

#Region Options
;~ Opt('MustDeclareVars', 1)
Opt('WinTitleMatchMode', 2)
Opt('GUICloseOnESC', 0)
Opt('GUIOnEventMode', 1)
Opt('TrayOnEventMode', 1)
#EndRegion Options


; Script Start - Add your code below here
Global Const $DEBUG_MODE = True ; Please change value to False when compile

;~ Global Const $SERVER = 'http://localhost/index.php?act='
Global Const $SERVER = 'http://excelauto.000webhostapp.com/index.php?act='
Global Const $ENDPOINT_LOGIN = $SERVER & 'login'
Global Const $ENDPOINT_LOGOUT = $SERVER & 'logout'
Global Const $ENDPOINT_CREATE = $SERVER & 'create'
Global Const $ENDPOINT_UPDATE = $SERVER & 'update'
Global Const $ENDPOINT_READ = $SERVER & 'read'
Global Const $ENDPOINT_DELETE = $SERVER & 'delete'
Global $danglogin=False, $username
Global $Form3,$dem

Func child()
#Region ### START Koda GUI section ### Form=E:\Program Files\AutoIt3\Code\_TUTORIAL\MainForm.kxf
Global $MainForm = GUICreate('Đăng nhập', 410, 150,Default,Default,Default,Default)
GUISetFont(10, 400, 0, 'Arial')
GUISetOnEvent($GUI_EVENT_CLOSE, 'MainFormClose')
Global $GroupLogin = GUICtrlCreateGroup('Đăng nhập', 10, 8, 390, 115)
Global $LabelUsername = GUICtrlCreateLabel('Username:', 20, 40, 80, 22)
Global $InputUsername = GUICtrlCreateInput('', 105, 38, 162, 26, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
Global $LabelPassword = GUICtrlCreateLabel('Password:', 20, 80, 78, 22)
Global $InputPassword = GUICtrlCreateInput('', 105, 78, 162, 26, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_PASSWORD))
Global $ButtonLogin = GUICtrlCreateButton('Đăng nhập', 278, 38, 110, 67)
GUICtrlSetFont(-1, 15, 400, 0, 'Arial')
GUICtrlSetCursor(-1, 0)
GUICtrlSetOnEvent(-1, 'ButtonLoginClick')
GUICtrlSetState(-1, $GUI_DEFBUTTON)
GUICtrlCreateGroup('', -99, -99, 1, 1)

GUICtrlCreateStatusBar($MainForm, 260)


GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


;~ While 1
;~ 	kiemtra2()
;~ 	If $danglogin= True Then
;~ 		GUIDelete($MainForm)
;~ 		GUISetState(@SW_SHOW,$Form3)
;~ 		auto()
;~ 	EndIf

;~ 	Sleep(100)
;~ WEnd

EndFunc

Func kiemtra2()
;~ 	If $danglogin= True Then
;~ 		Local $ipaddressonsrv=kiemtra($username)
;~ 		Local $netip=BinaryToString(InetRead('http://www.myexternalip.com/raw'))
;~ 		If $netip='' Then $netip=$ipaddressonsrv
;~ 		If $ipaddressonsrv<>$netip Then
;~ 			logout()
;~ 			MsgBox(16 + 262144, 'Error', 'Bạn đang đăng nhập ở thiết bị khác!', 3, $MainForm)
;~ 			Exit
;~ 		EndIf
;~ 	EndIf
	If $danglogin= True Then
		$data = 'username=' & urlEncode($username)
		$request = _httpRequest($ENDPOINT_READ, 'POST', $data)
		If UBound($request)>=3 Then ConsoleWrite($request[2]&@CRLF)
		If $request<>0 Then
			$json = Json_Decode($request[2])
			If StringInStr($request[2],'Warning') Or StringInStr($request[2],'Forbidden') Or Not StringInStr($request[2],'username') Or Not StringInStr($request[2],'success') Then
			Else
				$tkdaonline = Json_Get($json, '["data"]["is_online"]')
				$ipaddressonsrv = Json_Get($json, '["data"]["ip_address"]')
				ConsoleWrite($tkdaonline&' '&$ipaddressonsrv&@CRLF)
				If $tkdaonline=0 Then
					ConsoleWrite($tkdaonline)
					MsgBox(16 + 262144, 'Error', 'Bạn đang đăng nhập ở thiết bị khác!', 3, $MainForm)
;~ 					MsgBox(0,'',$request&@CRLF&$json&@CRLF&$request[2]&@CRLF&$tkdaonline)
					Exit
				EndIf
				If IsInt($ipaddressonsrv) Then
					If $ipaddressonsrv<>$dem Then
						MsgBox(16 + 262144, 'Error', 'Bạn đang đăng nhập ở thiết bị khác!', 3, $MainForm)
						Exit
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
EndFunc

Func kiemtra($username)
	Local $data = 'username=' & urlEncode($username)
	Local $request = _httpRequest($ENDPOINT_READ, 'POST', $data)
	Local $json = Json_Decode($request[2])
	Local $ipaddressonsrv = Json_Get($json, '["data"]["ip_address"]')
	Return $ipaddressonsrv
EndFunc

Func macaddress()
	Local $Pid = Run(@ComSpec & " /c ipconfig /all", "", 0x0, 0x2)
	Local $line = ""
	While 1
		Do
			$line = StdoutRead($Pid)
			Sleep(10)
		Until StringInStr($line,'Physical Address')
		StdioClose($Pid)
		ExitLoop
	WEnd
	Local $macs = StringRegExp($line, "[0-9A-F]{2}\-[0-9A-F]{2}\-[0-9A-F]{2}\-[0-9A-F]{2}\-[0-9A-F]{2}", 1)
	If @error Then
		Return @error
	Else
	   Return $macs[0]
	EndIf
EndFunc


Func ButtonLoginClick()
	Global $username, $password

	$username = GUICtrlRead($InputUsername)
	If Not $username Then
		_showError('Hãy nhập username!', $InputUsername)
		Return False
	EndIf

	$password = GUICtrlRead($InputPassword)
	If Not $password Then
		_showError('Hãy nhập mật khẩu!', $InputPassword)
		Return False
	EndIf

	logout()

	; Disable controls
	GUICtrlSetState($InputUsername, $GUI_DISABLE)
	GUICtrlSetState($InputPassword, $GUI_DISABLE)
	GUICtrlSetState($ButtonLogin, $GUI_DISABLE)

	; Make login request to server
	Local $data, $request
	$data = 'username=' & urlEncode($username)
	$data &= '&password=' & urlEncode($password)
	$data &= '&ipaddress=' & urlEncode($dem)

	$request = _httpRequest($ENDPOINT_LOGIN, 'POST', $data)

	If $DEBUG_MODE Then _ArrayDisplay($request)
	If $request=0 Then
		GUICtrlSetState($InputUsername, $GUI_ENABLE)
		GUICtrlSetState($InputPassword, $GUI_ENABLE)
		GUICtrlSetState($ButtonLogin, $GUI_ENABLE)
		Return False
	EndIf
	Local $json = Json_Decode($request[2])
	Local $success = Json_Get($json, '["success"]')
	Local $ipaddress = Json_Get($json, '["data"]')

	; Enable controls
	GUICtrlSetState($InputUsername, $GUI_ENABLE)
	GUICtrlSetState($InputPassword, $GUI_ENABLE)
	GUICtrlSetState($ButtonLogin, $GUI_ENABLE)

	If $success Then
		; Login success
		GUICtrlSetState($InputUsername, $GUI_DISABLE)
		GUICtrlSetState($InputPassword, $GUI_DISABLE)

		; Switch to logout button
		GUICtrlSetData($ButtonLogin, 'Thoát ra')
		GUICtrlSetOnEvent($ButtonLogin, 'Logout')
		$danglogin=True

		Return True
	Else
		Local $errorCode = Json_Get($json, '["data"]')
		If $errorCode = -1 Then
			_showError('Sai tài khoản hoặc mật khẩu!', $InputUsername)
			Return False
;~ 		Else
;~ 			Local $ipaddressonsrv=kiemtra($username)
;~ 			If $ipaddressonsrv<>_GetIP() Then
;~ 				_showError('Bạn đang đăng nhập ở chỗ khác!')
;~ 				Return False
;~ 			Else
;~ 				; Login success
;~ 				GUICtrlSetState($InputUsername, $GUI_DISABLE)
;~ 				GUICtrlSetState($InputPassword, $GUI_DISABLE)

;~ 				; Switch to logout button
;~ 				GUICtrlSetData($ButtonLogin, 'Thoát ra')
;~ 				GUICtrlSetOnEvent($ButtonLogin, 'Logout')
;~ 				$danglogin=True
;~ 				Return True
;~ 			EndIf
;~ 		EndIf
		Else
			_showError('Bạn đang đăng nhập ở chỗ khác!')
			Return False
		EndIf
	EndIf
EndFunc   ;==>ButtonLoginClick



Func _showError($errorMsg, $ctrId = Default)
	MsgBox(16 + 262144, 'Error', $errorMsg, 0, $MainForm)

	If $ctrId <> Default Then GUICtrlSetState($ctrId, $GUI_FOCUS)
EndFunc   ;==>_showError


Func Logout()
;~ 	If Not $DEBUG_MODE Then
;~ 		; Confirmation
;~ 		If MsgBox(32 + 4 + 256 + 262144, 'Confirm', 'Are you sure to logout?', 0, $MainForm) = 7 Then Return False
;~ 	EndIf
	Local $username, $data, $request
	$username = GUICtrlRead($InputUsername)
	$data = 'username=' & urlEncode($username)
	$request = _httpRequest($ENDPOINT_LOGOUT, 'POST', $data)
	If $request=0 Then
		Return False
	EndIf
	Local $json = Json_Decode($request[2])
	Local $success = Json_Get($json, '["success"]')

	If $DEBUG_MODE Then _ArrayDisplay($request)

	If $success Then
		GUICtrlSetState($InputUsername, $GUI_ENABLE)
		GUICtrlSetState($InputPassword, $GUI_ENABLE)

		; Switch to login button
		GUICtrlSetData($ButtonLogin, 'Đăng nhập')
		GUICtrlSetOnEvent($ButtonLogin, 'ButtonLoginClick')

		; Focus to username input
		GUICtrlSetState($InputUsername, $GUI_FOCUS)
		$danglogin=False
		Return True
	Else
		_showError('Không thoát ra được, hãy thử lại!')
		Return False
	EndIf
EndFunc   ;==>Logout



Func GUICtrlCreateStatusBar($gui, $space = 280, $text = 'Auto Snuckls', $copyright = 'Minh Huỳnh')
	Local $statusBar = _GUICtrlStatusBar_Create($gui)
	Local $statusBar_PartsWidth[2] = [$space, -1]
	_GUICtrlStatusBar_SetParts($statusBar, $statusBar_PartsWidth)
	_GUICtrlStatusBar_SetText($statusBar, $text, 0)
	_GUICtrlStatusBar_SetText($statusBar, $copyright, 1)
	_GUICtrlStatusBar_SetMinHeight($statusBar, 3)
	Return $statusBar
EndFunc   ;==>GUICtrlCreateStatusBar

Func MainFormClose()
	; Make sure user is logged out
	If GUICtrlRead($ButtonLogin) = 'Thoát ra' Then
		logout()
	EndIf

	Exit
EndFunc   ;==>MainFormClose


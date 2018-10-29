#include-once
$oMyError = ObjEvent("AutoIt.Error", "MyErrFunc")
Func MyErrFunc()
    $HexNumber = Hex($oMyError.number, 8)
    ConsoleWrite("We intercepted a COM Error !" & @LF & _
            "Number is: " & $HexNumber & @LF & _
            "Windescription is: " & $oMyError.windescription & @LF)
    Return SetError(1, $HexNumber) ; something to check for when this function returns
EndFunc   ;==>MyErrFunc
Func _httpRequest($url, $method = 'GET', $postData = '')
	$method = StringLower($method)
	Local $oHTTP = ObjCreate('WinHttp.WinHttpRequest.5.1')
	$oHTTP.Open($method, $url, False)
;~ 	$oHTTP.SetRequestHeader('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0')
;~ 	$oHTTP.SetRequestHeader('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Firefox/52.0')
;~ 	$oHTTP.SetRequestHeader('Referer', 'https:/junookyo.blogspot.com/')
;~ 	$oHTTP.SetRequestHeader('Referer', 'https:/ptctemp.blogspot.com/')
;~ 	$oHTTP.SetRequestHeader('X-Requested-With', 'XMLHttpRequest')
	If $method = 'get' Then
		$oHTTP.Send()
	Else
		$oHTTP.SetRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
		$oHTTP.SetRequestHeader('Content-Length', StringLen($postData))
		$oHTTP.Send($postData)
	EndIf
	If Not @error Then
		$oHTTP.WaitForResponse
		Local $HeaderResponses = $oHTTP.GetAllResponseHeaders()
		Local $ret[4]
		If StringInStr($HeaderResponses, 'Location:') <> 0 Then
			$ret["0"] = $oHTTP.GetResponseHeader('Location')
			$ret["1"] = 1
		Else
			$ret["0"] = ''
			$ret["1"] = 0
		EndIf
		$ret["2"] = $oHTTP.Responsetext
		$ret["3"] = $oHTTP.GetAllResponseHeaders()
		Return $ret
	Else
		Return 0
	EndIf
EndFunc

Func urlEncode($vData)
    If IsBool($vData) Then Return $vData
	Local $aData = StringToASCIIArray($vData, Default, Default, 2)
	Local $sOut = '', $total = UBound($aData) - 1
	For $i = 0 To $total
		Switch $aData[$i]
			Case 45, 46, 48 To 57, 65 To 90, 95, 97 To 122, 126
				$sOut &= Chr($aData[$i])
			Case 32
				$sOut &= '+'
			Case Else
				$sOut &= '%' & Hex($aData[$i], 2)
		EndSwitch
	Next
	Return $sOut
EndFunc

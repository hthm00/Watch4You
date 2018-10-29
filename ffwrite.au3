#include <FF.au3>
;~ _FFStart('about:blank','Profile1',1,False,'127.0.0.1',4243)
;~ _FFWriteHTML("<head><title>Hello World!</title></head><body><div>Hello World!</div></body>", "html")
;~ For $i=32 To 136
;~ _FFWriteHTML("<head><title>Hello World!</title></head><body><div>Hello\"&Chr($i)&"World!</div></body>", "html")
;~ Next
;~ Exit

$txt=ClipGet()
For $i=32 To 136
	If StringInStr(

;~ #include <FF.au3>
;~ _FFStart('about:blank','Profile1',1,False,'127.0.0.1',4243)
;~ _FFXPath("/html", "innerHTML='<head><title>Hello World!</title></head><body><div>Hello World!</div></body>'")
;~ _FFXPath("//div[1]")
;~ For $i=32 To 136
;~ _FFObj("xpath", "textContent", "Hello\"&Chr($i)&"World!")
;~ Next
;~ Exit
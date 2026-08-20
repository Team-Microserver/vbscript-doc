Option Explicit

' ============================================
' 변수 선언
' ============================================

Dim message
Dim num
Dim longNum
' ============================================
' 처리
' ============================================

message = "Hello VBScript"
num = 1222
longNum = 11111111111111


' ============================================
' 결과 출력
' ============================================
WScript.Echo VarType(message)
WScript.Echo TypeName(message)

WScript.Echo VarType(num)
WScript.Echo TypeName(num)

WScript.Echo VarType(longNum)
WScript.Echo TypeName(longNum)

WScript.Echo message

Dim a, b ,result
a = "10"
b = 20

result = a + b

WScript.Echo result


Dim codes
codes = Split("A,B,C", ",")

WScript.Echo codes(0)  ' A
result = Join(codes, "|")

WScript.Echo result   ' A|B|C
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

Dim formatted
formatted = FormatNumber(1234567.89, 2)
WScript.Echo formatted   ' 1,234,567.89

formatted = FormatNumber(1234567.89, 3)
WScript.Echo formatted   ' 1,234,567.890

formatted = FormatNumber(1234567.89, 1)
WScript.Echo formatted   ' 1,234,567.9






Call TestTradeDate()

Sub TestTradeDate()

    Dim tradeDateText
    Dim tradeDate

    ' 테스트할 값을 직접 입력
    tradeDateText = "2026-08-20"

    tradeDateText = Trim(tradeDateText)

    If tradeDateText = "" Then

        WScript.Echo "거래일자를 입력하세요."
        Exit Sub

    ElseIf Not IsDate(tradeDateText) Then

        WScript.Echo "거래일자를 확인하세요."
        Exit Sub

    Else

        tradeDate = CDate(tradeDateText)

    End If

    WScript.Echo "입력값 : " & tradeDateText
    WScript.Echo "변환된 날짜 : " & tradeDate

End Sub
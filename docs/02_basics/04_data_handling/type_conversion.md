# 형 변환

VBScript는 자동 형 변환을 많이 수행하지만, 금융 업무 코드에서는 명시적인 변환이 더 안전한 경우가 많습니다. 특히 화면 컨트롤의 문자열 값을 숫자로 계산하거나 날짜를 비교할 때 중요합니다.

## 자주 사용하는 변환 함수

```text
CStr   → 문자열
CInt   → Integer
CLng   → Long
CDbl   → Double
CDate  → Date
CBool  → Boolean
```

## 숫자 변환 전 검증

```vb
Function ToAmount(ByVal text)
    Dim normalized
    normalized = Replace(Trim(text), ",", "")

    If normalized = "" Then
        ToAmount = 0
        Exit Function
    End If

    If Not IsNumeric(normalized) Then
        Err.Raise 1001, "ToAmount", "숫자로 변환할 수 없습니다."
    End If

    ToAmount = CDbl(normalized)
End Function
```

!!! tip "표시값과 계산값 분리"
    화면에 `1,000,000`을 보여주더라도 계산할 때는 콤마가 제거된 숫자 값으로 다루는 것이 좋습니다.

## CStr 사용 시 Null 주의

`CStr(Null)`은 오류가 될 수 있으므로 Null 가능성이 있다면 먼저 검사합니다.

```vb
If IsNull(value) Then
    text = ""
Else
    text = CStr(value)
End If
```

## 날짜 변환 전 IsDate

```vb
If Not IsDate(txtTradeDate.Text) Then
    MsgBox "날짜 형식이 올바르지 않습니다."
    Exit Sub
End If

tradeDate = CDate(txtTradeDate.Text)
```

## Boolean 변환

외부 데이터가 `"Y"`, `"N"`, `"1"`, `"0"` 형태라면 `CBool`에 바로 넘기기보다 업무 코드에 맞게 명시적으로 변환하는 편이 낫습니다.

```vb
Function IsYes(ByVal value)
    IsYes = (UCase(Trim(CStr(value))) = "Y")
End Function
```

자동 형 변환은 코드가 짧아 보이게 하지만, 값이 예상 범위를 벗어났을 때 어느 줄에서 왜 실패했는지 찾기 어렵게 만들 수 있습니다.

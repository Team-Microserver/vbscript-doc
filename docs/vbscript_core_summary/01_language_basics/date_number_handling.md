# 날짜와 숫자 처리

금융 화면에서는 날짜와 금액을 자주 다룹니다. 두 영역 모두 문자열 상태로 비교하거나 계산하면 오류가 생기기 쉬우므로 변환과 검증 과정을 명확히 해야 합니다.

## 숫자 검증과 변환

```vb
Dim amountText, amount
amountText = Trim(txtAmount.Text)

If amountText = "" Then
    amount = 0
ElseIf Not IsNumeric(amountText) Then
    MsgBox "금액은 숫자로 입력하세요."
    Exit Sub
Else
    amount = CDbl(amountText)
End If
```

`CInt`는 범위가 작기 때문에 업무 금액 처리에는 `CLng` 또는 `CDbl`이 더 적합한 경우가 많습니다. 정확한 타입 선택은 실제 값의 범위와 소수점 사용 여부를 확인해야 합니다.

## FormatNumber

표시용 숫자를 포맷할 수 있습니다.

```vb
formatted = FormatNumber(1234567.89, 2)
```

표시용 포맷과 실제 계산용 값은 분리하는 것이 좋습니다.

!!! warning "콤마가 포함된 금액"
    컨트롤 값이 `1,000,000`처럼 표시되어 있다면 숫자 변환 전에 콤마 제거가 필요할 수 있습니다.

    ```vb
    amountText = Replace(txtAmount.Text, ",", "")
    ```

## 날짜 검증

```vb
If Not IsDate(txtTradeDate.Text) Then
    MsgBox "거래일자를 확인하세요."
    Exit Sub
End If

tradeDate = CDate(txtTradeDate.Text)
```

## DateDiff

두 날짜의 차이를 계산합니다.

```vb
If DateDiff("d", startDate, endDate) < 0 Then
    MsgBox "종료일은 시작일보다 빠를 수 없습니다."
End If
```

## DateAdd

기준 날짜에 기간을 더하거나 뺍니다.

```vb
yesterday = DateAdd("d", -1, Date)
nextMonth = DateAdd("m", 1, Date)
```

## Year, Month, Day

날짜 구성요소를 추출합니다.

```vb
y = Year(tradeDate)
m = Month(tradeDate)
d = Day(tradeDate)
```

!!! tip "날짜 문자열 직접 비교 금지"
    `"2026-9-1"`과 `"2026-10-1"` 같은 문자열은 포맷에 따라 문자열 비교 결과가 의도와 다를 수 있습니다. 가능하면 `CDate`로 날짜 값으로 변환한 후 비교하세요.

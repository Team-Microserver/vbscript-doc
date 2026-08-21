# 데이터 형식과 Variant

VBScript의 일반 변수는 모두 `Variant`입니다. 즉 변수 선언 시 `String`, `Integer`, `Date` 같은 타입을 지정하지 않습니다. 대신 변수에 들어 있는 값에 따라 내부적으로 문자열, 숫자, 날짜 등의 하위 형식이 결정됩니다.

```vb
Dim value

value = "ABC"      ' 문자열
value = 100        ' 숫자
value = True       ' Boolean
value = Date       ' 날짜
```

같은 변수에 서로 다른 종류의 값을 넣을 수 있다는 뜻입니다. 편리하지만, 동시에 예상치 못한 자동 형 변환 문제가 생길 수 있습니다.

## VarType과 TypeName

값의 실제 하위 형식을 확인할 때 `VarType` 또는 `TypeName`을 사용할 수 있습니다.

```vb
Dim amount
amount = 1000

MsgBox TypeName(amount)   ' Integer 또는 Long 등 값에 따라 표시
```

## 자동 형 변환의 위험

아래 코드를 봅시다.

```vb
Dim a, b
a = "10"
b = 20

result = a + b
```

VBScript는 상황에 따라 문자열을 숫자로 변환하여 계산하려고 합니다. 그러나 값이 `"10A"`처럼 숫자로 바꿀 수 없는 문자열이면 타입 불일치 오류가 발생할 수 있습니다.

!!! tip "업무 데이터는 명시적으로 변환"
    서버나 화면 컨트롤에서 읽은 값은 문자열 형태일 가능성을 염두에 두고, 계산 전에 `CLng`, `CDbl`, `CInt` 등을 이용해 의도를 명확하게 만드는 것이 좋습니다.

## 주요 값 종류

실무에서 자주 접하는 값은 다음과 같습니다.

- 문자열(String)
- 정수(Integer/Long)
- 실수(Double)
- Boolean
- Date
- Empty
- Null
- 객체(Object)

여기서 특히 `Empty`, `Null`, 객체의 `Nothing`은 서로 완전히 다른 의미이므로 반드시 구분해야 합니다.

!!! example "값 상태 확인"
    ```vb
    Dim value

    If IsEmpty(value) Then
        MsgBox "아직 값이 할당되지 않았습니다."
    End If
    ```

## IsNumeric, IsDate

외부 입력값을 변환하기 전에 검사하면 안전합니다.

```vb
If IsNumeric(txtAmount.Text) Then
    amount = CDbl(txtAmount.Text)
Else
    MsgBox "금액은 숫자로 입력하세요."
End If
```

```vb
If IsDate(txtStartDate.Text) Then
    startDate = CDate(txtStartDate.Text)
End If
```

금융 시스템에서는 금액과 날짜 오류가 업무 처리 오류로 이어질 수 있으므로 자동 형 변환에 지나치게 의존하지 않는 습관이 중요합니다.

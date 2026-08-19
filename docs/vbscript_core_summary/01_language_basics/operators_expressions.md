# 연산자와 표현식

VBScript의 연산자는 산술, 비교, 논리, 문자열 연결에 사용됩니다. 문법 자체는 익숙하지만 다른 언어와 기호가 다른 부분이 있으므로 주의해야 합니다.

## 산술 연산자

```vb
sum = a + b
diff = a - b
product = a * b
quotient = a / b
remainder = a Mod b
```

정수 나눗셈에는 `\`를 사용할 수 있습니다.

```vb
result = 7 \ 2   ' 3
```

## 비교 연산자

```vb
If amount = 0 Then
End If

If amount <> 0 Then
End If

If amount >= 10000 Then
End If
```

Java에서 `!=`를 사용하던 개발자는 VBScript의 같지 않음 연산자가 `<>`라는 점을 기억해야 합니다.

## 논리 연산자

```vb
If age >= 20 And status = "A" Then
    ' 두 조건 모두 참
End If

If grade = "A" Or grade = "B" Then
    ' 하나 이상 참
End If

If Not isValid Then
    ' isValid가 False
End If
```

!!! warning "단축 평가를 기대하지 않기"
    VBScript의 논리식은 Java의 `&&`, `||`와 같은 단축 평가를 기대하고 작성하면 위험할 수 있습니다. 오른쪽 표현식도 평가될 수 있다고 생각하고, 오류 가능성이 있는 검사는 단계적으로 분리하는 편이 안전합니다.

예를 들어 다음과 같은 코드는 피하는 것이 좋습니다.

```vb
If Not IsNull(value) And Len(value) > 0 Then
    ' ...
End If
```

대신 다음처럼 나누면 의도가 분명합니다.

```vb
If Not IsNull(value) Then
    If Len(CStr(value)) > 0 Then
        ' ...
    End If
End If
```

## 문자열 연결

문자열은 `&`로 연결하는 것을 권장합니다.

```vb
message = "계좌번호: " & accountNo & ", 고객명: " & customerName
```

!!! example "로그 메시지 만들기"
    ```vb
    logMessage = "[조회] accountNo=" & accountNo & _
                 ", startDate=" & startDate & _
                 ", endDate=" & endDate
    ```

줄이 길 때는 공백 뒤에 `_`를 사용해 다음 줄로 이어 쓸 수 있습니다.

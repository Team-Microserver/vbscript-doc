# 기초 문법 실습

## 실습 1. 고객명 정리

입력 문자열의 앞뒤 공백을 제거한 뒤 빈 값이면 `"미입력"`을 반환하는 함수를 작성해보세요.

!!! example "예시 답안"
    ```vb
    Function NormalizeCustomerName(ByVal name)
        Dim value

        If IsNull(name) Or IsEmpty(name) Then
            NormalizeCustomerName = "미입력"
            Exit Function
        End If

        value = Trim(CStr(name))

        If value = "" Then
            NormalizeCustomerName = "미입력"
        Else
            NormalizeCustomerName = value
        End If
    End Function
    ```

## 실습 2. 금액 등급

금액이 100만 미만이면 `S`, 100만 이상 1천만 미만이면 `M`, 그 이상이면 `L`을 반환해보세요.

!!! example "예시 답안"
    ```vb
    Function GetAmountGrade(ByVal amount)
        If amount < 1000000 Then
            GetAmountGrade = "S"
        ElseIf amount < 10000000 Then
            GetAmountGrade = "M"
        Else
            GetAmountGrade = "L"
        End If
    End Function
    ```

## 실습 3. 배열에서 코드 찾기

배열 안에 목표 코드가 존재하면 `True`를 반환합니다.

```vb
Function ContainsCode(ByVal codes, ByVal target)
    Dim i
    ContainsCode = False

    For i = LBound(codes) To UBound(codes)
        If codes(i) = target Then
            ContainsCode = True
            Exit Function
        End If
    Next
End Function
```

!!! tip "직접 변형하기"
    대소문자를 무시하도록 `UCase`를 적용하거나, Null 값이 배열에 포함될 때 오류가 나지 않도록 코드를 개선해보세요.

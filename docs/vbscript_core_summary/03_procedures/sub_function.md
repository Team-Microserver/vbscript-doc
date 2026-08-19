# Sub와 Function

VBScript에서 로직을 구조화하는 핵심 단위는 `Sub`와 `Function`입니다. 두 문법은 비슷해 보이지만 역할이 다릅니다. 화면 이벤트, 저장 처리, 화면 초기화처럼 **동작 자체가 목적**이면 `Sub`가 자연스럽고, 검증 결과나 계산 결과처럼 **값을 돌려줘야 하면** `Function`이 적합합니다.

## Sub 프로시저

```vb
Sub ClearScreen()
    txtCustomerName.Text = ""
    txtAmount.Text = ""
End Sub
```

호출할 때는 다음처럼 작성할 수 있습니다.

```vb
Call ClearScreen()
```

매개변수가 있는 경우 프로젝트 코딩 스타일에 따라 `Call` 사용 여부가 다를 수 있습니다. 기존 코드의 스타일을 따르는 것이 가장 안전합니다.

## Function

VBScript 함수는 함수 이름 자체에 결과를 할당하여 반환합니다.

```vb
Function IsPositive(amount)
    If amount > 0 Then
        IsPositive = True
    Else
        IsPositive = False
    End If
End Function
```

호출은 다음과 같습니다.

```vb
If IsPositive(amount) Then
    MsgBox "정상 금액입니다."
End If
```

!!! tip "Function 반환 문법"
    Java의 `return true;`처럼 `return` 키워드를 사용하는 것이 아닙니다. `함수명 = 반환값` 형태를 사용한다는 점이 처음에는 가장 낯설 수 있습니다.

## 검증 함수를 만드는 패턴

```vb
Function ValidateSearchCondition()
    ValidateSearchCondition = False

    If Trim(txtAccountNo.Text) = "" Then
        MsgBox "계좌번호를 입력하세요."
        Exit Function
    End If

    ValidateSearchCondition = True
End Function
```

처음에 실패값을 기본으로 지정하고 모든 검증을 통과한 마지막에 `True`를 지정하면 흐름이 명확합니다.

!!! example "이벤트에서 검증 함수 사용"
    ```vb
    Sub btnSearch_Click()
        If ValidateSearchCondition() = False Then
            Exit Sub
        End If

        Call DoSearch()
    End Sub
    ```

## 너무 큰 프로시저를 나누는 기준

한 이벤트 안에 검증, 요청 데이터 설정, 서버 호출, 응답 반영이 모두 섞이면 유지보수가 어려워집니다. 다음처럼 역할별로 분리하면 좋습니다.

```text
btnSearch_Click
 ├─ ValidateSearchCondition
 ├─ SetSearchParameter
 ├─ RequestSearch
 └─ BindSearchResult
```

전용 개발도구가 제공하는 트랜잭션 API는 그대로 사용하더라도, 그 API를 호출하는 앞뒤 업무 로직은 작은 함수로 나누면 읽기 쉬워집니다.

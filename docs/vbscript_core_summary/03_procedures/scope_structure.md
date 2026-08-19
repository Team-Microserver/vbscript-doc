# 스코프와 코드 구조화

변수가 어디까지 보이고 언제까지 유지되는지를 이해하지 못하면 화면 간 상태나 공통 변수 때문에 오류를 찾기 어려워질 수 있습니다.

## 지역 변수

프로시저 내부에서 선언한 변수는 해당 프로시저 안에서 사용하는 것을 기본으로 생각하면 됩니다.

```vb
Sub Search()
    Dim accountNo
    accountNo = Trim(txtAccountNo.Text)
End Sub
```

지역 변수는 영향 범위가 좁기 때문에 가장 안전합니다.

## 스크립트 수준 변수

프로시저 밖에 선언한 변수는 여러 프로시저에서 공유할 수 있습니다.

```vb
Dim currentCustomerNo

Sub SetCustomer()
    currentCustomerNo = "10001"
End Sub

Sub ShowCustomer()
    MsgBox currentCustomerNo
End Sub
```

화면 상태를 유지하기 위해 필요할 수 있지만, 여러 이벤트가 같은 값을 변경하면 추적이 어려워집니다.

!!! warning "전역 상태 최소화"
    '편하니까'라는 이유로 화면 수준 변수를 늘리면 버튼 실행 순서에 따라 값이 달라지는 버그가 생길 수 있습니다. 이벤트 사이에 반드시 공유해야 하는 상태인지 먼저 판단하세요.

## 코드 구조화 권장 순서

화면 스크립트를 정리할 수 있다면 다음 순서가 읽기 편합니다.

```text
1. 상수
2. 화면 상태 변수
3. 초기화 이벤트
4. 버튼/컨트롤 이벤트
5. 업무 처리 함수
6. 검증 함수
7. 작은 유틸리티 함수
```

## 이벤트와 업무 로직 분리

이벤트 함수는 가능한 한 '무엇을 할지'만 보여주고 세부 로직은 다른 함수로 분리합니다.

!!! example "읽기 쉬운 이벤트"
    ```vb
    Sub btnSave_Click()
        If Not ValidateSaveData() Then
            Exit Sub
        End If

        Call ConfirmAndSave()
    End Sub
    ```

위 코드만 읽어도 저장 버튼의 전체 흐름이 보입니다. 세부 검증 규칙은 필요할 때 `ValidateSaveData`로 들어가 보면 됩니다.

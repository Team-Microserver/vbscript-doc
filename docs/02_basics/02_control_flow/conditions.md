# 조건문

조건문은 화면 입력값 검증, 버튼 활성화 여부, 업무 상태별 처리 분기 등에 사용됩니다. 실무 화면에서는 거의 모든 이벤트에 등장한다고 봐도 됩니다.

## If ... Then

```vb
If amount > 0 Then
    MsgBox "금액이 입력되었습니다."
End If
```

## If ... Then ... Else

```vb
If balance >= withdrawalAmount Then
    result = "가능"
Else
    result = "잔액부족"
End If
```

## ElseIf

```vb
If grade = "A" Then
    rate = 0.01
ElseIf grade = "B" Then
    rate = 0.02
Else
    rate = 0.03
End If
```

## 한 줄 If와 블록 If

간단한 명령은 한 줄로 작성할 수 있습니다.

```vb
If amount < 0 Then amount = 0
```

하지만 실무 유지보수에서는 블록 형태가 더 읽기 쉽습니다.

## Select Case

하나의 값에 따라 여러 분기를 처리할 때 유용합니다.

```vb
Select Case tradeType
    Case "01"
        tradeName = "매수"
    Case "02"
        tradeName = "매도"
    Case Else
        tradeName = "기타"
End Select
```

!!! tip "Select Case를 쓰기 좋은 경우"
    동일한 변수에 대해 `If ... ElseIf`가 세 번 이상 반복된다면 `Select Case`가 업무 코드를 읽기 더 쉬울 수 있습니다.

## 조기 종료 패턴

화면 이벤트에서는 잘못된 입력을 발견하면 즉시 빠져나오는 패턴이 자주 사용됩니다.

!!! example "Guard Clause 형태"
    ```vb
    Sub btnSave_Click()
        If Trim(txtCustomerName.Text) = "" Then
            MsgBox "고객명을 입력하세요."
            Exit Sub
        End If

        If Not IsNumeric(txtAmount.Text) Then
            MsgBox "금액을 확인하세요."
            Exit Sub
        End If

        Call SaveData()
    End Sub
    ```

조건문을 과도하게 중첩하기보다 검증 실패 시 빠르게 종료하면 정상 처리 흐름이 아래쪽에 자연스럽게 남습니다.

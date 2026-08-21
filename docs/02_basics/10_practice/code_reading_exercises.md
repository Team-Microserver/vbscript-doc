# 코드 리딩 실습

## 문제 1

아래 코드를 읽고 실행 흐름을 설명해보세요.

```vb
Sub btnSearch_Click()
    Dim accountNo

    accountNo = Replace(Trim(txtAccountNo.Text), "-", "")

    If accountNo = "" Then
        MsgBox "계좌번호를 입력하세요."
        Exit Sub
    End If

    If Len(accountNo) <> 10 Then
        MsgBox "계좌번호를 확인하세요."
        Exit Sub
    End If

    Call SearchAccount(accountNo)
End Sub
```

!!! example "읽는 방법"
    1. 조회 버튼 클릭 이벤트가 시작점입니다.
    2. 계좌번호에서 공백과 하이픈을 제거합니다.
    3. 빈 값이면 메시지를 보여주고 이벤트를 종료합니다.
    4. 길이가 10이 아니면 종료합니다.
    5. 모든 검증을 통과하면 조회 함수를 호출합니다.

## 문제 2

```vb
Function GetDisplayName(ByVal name)
    If IsNull(name) Or IsEmpty(name) Then
        GetDisplayName = "-"
        Exit Function
    End If

    name = Trim(CStr(name))

    If name = "" Then
        GetDisplayName = "-"
    Else
        GetDisplayName = name
    End If
End Function
```

이 함수가 `ByVal`을 사용한 이유와 `CStr` 전에 Null 검사를 수행하는 이유를 설명해보세요.

## 문제 3

기존 프로젝트에서 다음과 같은 흐름이 발견되었다고 가정합니다.

```text
btnSearch_Click
→ fnValidate
→ fnSetInput
→ gfnTransaction
→ fnCallback
→ fnBindResult
```

각 함수의 내부 구현을 아직 몰라도 전체 화면의 처리 단계를 추정해보고, 실제 코드에서 무엇을 확인해야 하는지 메모해보세요.

# 조건문

조건문은 **값이나 상태에 따라 처리 흐름을 분기**할 때 사용합니다.  
VBScript 화면 프로그램에서는 입력값 검증, 조회/저장 가능 여부 판단, 업무 상태별 분기, 버튼 이벤트 처리 등에 매우 자주 등장합니다.

Java나 JavaScript의 `if`, `else if`, `switch`와 개념은 거의 동일하므로, 문법 차이만 익히면 어렵지 않게 읽을 수 있습니다.

---

## 1. If ... Then

가장 기본적인 조건문입니다.

```vbscript
Dim amount
amount = 10000

If amount > 0 Then
    MsgBox "금액이 입력되었습니다."
End If
```

조건식의 결과가 `True`이면 `Then` 아래의 문장을 실행합니다.

### 기본 구조

```vbscript
If 조건식 Then
    실행문
End If
```

예를 들어 고객번호가 입력되었는지 확인할 수 있습니다.

```vbscript
If customerNo <> "" Then
    MsgBox "고객번호가 입력되었습니다."
End If
```

!!! tip "VBScript의 비교 연산자"
    VBScript에서는 JavaScript의 `===`, `!==` 대신 주로 다음 연산자를 사용합니다.

    | 의미 | VBScript |
    |---|---|
    | 같다 | `=` |
    | 같지 않다 | `<>` |
    | 크다 | `>` |
    | 작다 | `<` |
    | 크거나 같다 | `>=` |
    | 작거나 같다 | `<=` |

---

## 2. If ... Then ... Else

조건이 참일 때와 거짓일 때의 처리를 모두 작성할 수 있습니다.

```vbscript
Dim balance
Dim withdrawalAmount
Dim result

balance = 100000
withdrawalAmount = 50000

If balance >= withdrawalAmount Then
    result = "출금 가능"
Else
    result = "잔액 부족"
End If
```

### 기본 구조

```vbscript
If 조건식 Then
    참일 때 실행문
Else
    거짓일 때 실행문
End If
```

화면 프로그램에서는 입력 여부에 따라 버튼 활성화 여부를 결정하는 식으로도 사용할 수 있습니다.

```vbscript
If customerNo <> "" Then
    btnSearch.Enabled = True
Else
    btnSearch.Enabled = False
End If
```

---

## 3. ElseIf

여러 조건을 순서대로 검사해야 할 때 사용합니다.

```vbscript
Dim grade
Dim rate

grade = "B"

If grade = "A" Then
    rate = 0.01
ElseIf grade = "B" Then
    rate = 0.02
ElseIf grade = "C" Then
    rate = 0.03
Else
    rate = 0
End If
```

위에서부터 조건을 검사하고, 처음으로 `True`가 된 블록만 실행합니다.

### 범위 조건 처리

```vbscript
Dim score
Dim grade

score = 87

If score >= 90 Then
    grade = "A"
ElseIf score >= 80 Then
    grade = "B"
ElseIf score >= 70 Then
    grade = "C"
Else
    grade = "D"
End If
```

!!! warning "조건 순서가 중요합니다"
    범위 조건은 일반적으로 큰 값부터 작은 값 순서로 작성해야 합니다. 먼저 `score >= 70`을 검사하면 90점도 그 조건에서 처리되어 이후 조건으로 내려가지 않습니다.

---

## 4. 논리 연산자

여러 조건을 조합할 때 `And`, `Or`, `Not`을 사용합니다.

### And

모든 조건이 참일 때만 전체 조건이 참입니다.

```vbscript
If customerNo <> "" And accountNo <> "" Then
    MsgBox "조회 가능합니다."
End If
```

### Or

조건 중 하나라도 참이면 전체 조건이 참입니다.

```vbscript
If status = "01" Or status = "02" Then
    MsgBox "처리 가능한 상태입니다."
End If
```

### Not

조건을 반대로 뒤집습니다.

```vbscript
If Not isValid Then
    MsgBox "입력값을 확인하세요."
End If
```

| 의미 | VBScript | Java / JavaScript |
|---|---|---|
| AND | `And` | `&&` |
| OR | `Or` | `||` |
| NOT | `Not` | `!` |

---

## 5. 괄호를 사용한 조건 그룹화

조건이 복잡해지면 괄호로 우선순위를 명확하게 표현하는 것이 좋습니다.

```vbscript
If (customerType = "01" Or customerType = "02") And useYn = "Y" Then
    MsgBox "처리 대상 고객입니다."
End If
```

업무 조건이 길어질수록 괄호를 사용해야 유지보수가 쉽습니다.

---

## 6. 문자열 비교

VBScript에서는 문자열 비교에도 `=`와 `<>`를 사용합니다.

```vbscript
If customerName = "김고객" Then
    MsgBox "고객이 일치합니다."
End If
```

빈 문자열 확인은 다음처럼 자주 작성합니다.

```vbscript
If customerName = "" Then
    MsgBox "고객명을 입력하세요."
End If
```

공백만 입력된 경우까지 고려하려면 `Trim`을 함께 사용합니다.

```vbscript
If Trim(customerName) = "" Then
    MsgBox "고객명을 입력하세요."
End If
```

---

## 7. Empty, Null, Nothing과 조건문

VBScript에서는 단순한 빈 문자열 외에도 `Empty`, `Null`, `Nothing`을 구분해서 봐야 합니다.

### Empty 확인

초기화되지 않은 Variant 변수는 `Empty`일 수 있습니다.

```vbscript
Dim value

If IsEmpty(value) Then
    MsgBox "값이 초기화되지 않았습니다."
End If
```

### Null 확인

DB 조회 결과나 외부 데이터 처리에서 `Null`이 들어올 수 있습니다.

```vbscript
If IsNull(value) Then
    MsgBox "값이 Null입니다."
End If
```

!!! warning "Null을 `=`로 직접 비교하지 마세요"
    `Null` 확인은 다음과 같이 `IsNull()`을 사용합니다.

    ```vbscript
    If IsNull(value) Then
        MsgBox "Null 값입니다."
    End If
    ```

### Nothing 확인

객체 참조가 없는지 확인할 때 사용합니다.

```vbscript
If obj Is Nothing Then
    MsgBox "객체가 생성되지 않았습니다."
End If
```

---

## 8. 한 줄 If

간단한 실행문은 한 줄로 작성할 수 있습니다.

```vbscript
If amount < 0 Then amount = 0
```

또는:

```vbscript
If customerNo = "" Then Exit Sub
```

짧은 검증에는 편리하지만, 조건이 길거나 처리문이 여러 개라면 블록 형태가 더 읽기 좋습니다.

```vbscript
If customerNo = "" Then
    MsgBox "고객번호를 입력하세요."
    Exit Sub
End If
```

---

## 9. Select Case

하나의 값에 따라 여러 분기로 나눌 때 사용합니다. Java/JavaScript의 `switch`와 같은 역할입니다.

```vbscript
Dim tradeType
Dim tradeName

tradeType = "01"

Select Case tradeType
    Case "01"
        tradeName = "매수"

    Case "02"
        tradeName = "매도"

    Case Else
        tradeName = "기타"
End Select
```

### 여러 값을 하나의 Case에서 처리

```vbscript
Select Case status
    Case "01", "02", "03"
        MsgBox "정상 처리 상태입니다."

    Case "90", "99"
        MsgBox "오류 또는 종료 상태입니다."

    Case Else
        MsgBox "알 수 없는 상태입니다."
End Select
```

### 범위 조건

`Case Is`를 이용해 비교 조건도 작성할 수 있습니다.

```vbscript
Dim score
score = 85

Select Case score
    Case Is >= 90
        grade = "A"

    Case Is >= 80
        grade = "B"

    Case Is >= 70
        grade = "C"

    Case Else
        grade = "D"
End Select
```

!!! tip "Select Case를 쓰기 좋은 경우"
    같은 변수에 대해 `If ... ElseIf`가 계속 반복된다면 `Select Case`가 더 읽기 쉬울 수 있습니다.

---

## 10. 조기 종료 패턴

실무 화면 이벤트에서는 잘못된 입력을 발견하면 즉시 프로시저를 종료하는 패턴이 자주 사용됩니다.

```vbscript
Sub btnSave_Click()

    If Trim(txtCustomerName.Text) = "" Then
        MsgBox "고객명을 입력하세요."
        Exit Sub
    End If

    If Not IsNumeric(txtAmount.Text) Then
        MsgBox "금액을 확인하세요."
        Exit Sub
    End If

    If CDbl(txtAmount.Text) <= 0 Then
        MsgBox "금액은 0보다 커야 합니다."
        Exit Sub
    End If

    Call SaveData()

End Sub
```

조건문을 과도하게 중첩하기보다 검증 실패 시 빠르게 종료하면 정상 처리 흐름이 아래쪽에 자연스럽게 남습니다.

---

## 11. 화면 프로그램에서 자주 보는 조건문 패턴

### 조회 조건 검증

```vbscript
If Trim(txtCustomerNo.Text) = "" Then
    MsgBox "고객번호를 입력하세요."
    Exit Sub
End If

Call SearchCustomer()
```

### 업무 상태별 분기

```vbscript
Select Case workStatus
    Case "01"
        Call ProcessRequest()

    Case "02"
        Call ProcessApproval()

    Case "03"
        Call ProcessComplete()

    Case Else
        MsgBox "처리할 수 없는 상태입니다."
End Select
```

### 서버 응답 결과 확인

```vbscript
If resultCode = "0000" Then
    MsgBox "정상 처리되었습니다."
Else
    MsgBox "처리 중 오류가 발생했습니다."
End If
```

---

## 12. 기존 소스를 읽을 때 확인할 것

조건문을 분석할 때는 문법 자체보다 **어떤 업무 조건으로 흐름이 갈라지는지**를 확인하는 것이 중요합니다.

```text
1. 어떤 값을 검사하는가?
2. 정상 조건과 오류 조건은 무엇인가?
3. 조건이 참이면 어떤 함수가 호출되는가?
4. Exit Sub / Exit Function으로 조기 종료되는가?
5. 조건에 따라 서버 호출 여부가 달라지는가?
6. 업무 상태 코드에 따라 처리가 어떻게 달라지는가?
```

!!! tip "조건문 분석 핵심"
    기존 금융 화면 소스에서는 `If` 자체보다 `status`, `resultCode`, `useYn`, `searchYn` 같은 **업무 상태 변수의 의미**를 파악하는 것이 더 중요합니다.

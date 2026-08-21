# 반복문

반복문은 동일하거나 유사한 처리를 여러 번 수행할 때 사용합니다.  
VBScript 화면 프로그램에서는 **배열 순회, 그리드 행 처리, 코드 목록 검사, 합계 계산, 특정 값 검색** 등에 자주 사용됩니다.

Java나 JavaScript의 `for`, `for...of`, `while`과 역할은 비슷하지만 VBScript 특유의 문법이 있으므로 형태를 익혀 두는 것이 좋습니다.

---

## 1. For ... Next

반복 횟수나 시작/종료 값이 명확할 때 가장 많이 사용합니다.

```vbscript
Dim i

For i = 1 To 5
    MsgBox i
Next
```

위 코드는 `i`가 1부터 5까지 증가하면서 총 5번 실행됩니다.

### 기본 구조

```vbscript
For 변수 = 시작값 To 종료값
    실행문
Next
```

`Next` 뒤에 반복 변수를 명시할 수도 있습니다.

```vbscript
Dim i

For i = 1 To 5
    MsgBox i
Next i
```

---

## 2. Step

증가 폭을 지정할 때 `Step`을 사용합니다.

### 2씩 증가

```vbscript
Dim i

For i = 0 To 10 Step 2
    MsgBox i
Next
```

### 역순 반복

```vbscript
Dim i

For i = 10 To 1 Step -1
    MsgBox i
Next
```

`Step -1`은 마지막 행부터 첫 행까지 역순으로 처리할 때 자주 볼 수 있습니다.

---

## 3. 배열과 For ... Next

배열은 `LBound`와 `UBound`를 이용해서 순회하는 것이 안전합니다.

```vbscript
Dim accounts
Dim i

accounts = Array("111", "222", "333")

For i = LBound(accounts) To UBound(accounts)
    MsgBox accounts(i)
Next
```

!!! tip "인덱스를 하드코딩하지 마세요"
    배열 크기를 직접 가정하기보다 `LBound`, `UBound`를 사용하는 것이 안전합니다.

---

## 4. For Each ... Next

컬렉션이나 배열의 요소를 하나씩 꺼내 처리할 때 사용합니다.

```vbscript
Dim item
Dim accounts

accounts = Array("111", "222", "333")

For Each item In accounts
    MsgBox item
Next
```

### Dictionary 순회 예제

```vbscript
Dim dict
Dim key

Set dict = CreateObject("Scripting.Dictionary")

dict.Add "01", "매수"
dict.Add "02", "매도"

For Each key In dict.Keys
    MsgBox key & " = " & dict(key)
Next
```

!!! note "For와 For Each의 차이"
    - 인덱스가 필요하면 `For`
    - 요소 자체만 필요하면 `For Each`
    - 컬렉션/Dictionary 순회는 `For Each`가 자주 사용됩니다.

---

## 5. Do While ... Loop

조건이 `True`인 동안 반복합니다.

```vbscript
Dim index
Dim count

index = 0
count = 5

Do While index < count
    MsgBox index
    index = index + 1
Loop
```

조건을 먼저 검사하기 때문에 처음부터 조건이 `False`이면 한 번도 실행되지 않습니다.

---

## 6. Do Until ... Loop

조건이 `True`가 될 때까지 반복합니다.

```vbscript
Dim index
index = 0

Do Until index = 5
    index = index + 1
Loop
```

```text
Do While 조건
→ 조건이 True인 동안 반복

Do Until 조건
→ 조건이 True가 될 때까지 반복
```

---

## 7. Loop While / Loop Until

조건을 반복문 마지막에서 검사할 수도 있습니다.

```vbscript
Dim index
index = 0

Do
    index = index + 1
Loop While index < 5
```

```vbscript
Dim index
index = 0

Do
    index = index + 1
Loop Until index = 5
```

이 형태는 본문을 먼저 실행한 뒤 조건을 검사하므로 **최소 한 번은 실행됩니다.**

---

## 8. Exit For

원하는 값을 찾았거나 더 이상 처리할 필요가 없으면 반복문을 종료합니다.

```vbscript
Dim accounts
Dim targetAccount
Dim found
Dim i

accounts = Array("111", "222", "333")
targetAccount = "222"
found = False

For i = LBound(accounts) To UBound(accounts)

    If accounts(i) = targetAccount Then
        found = True
        Exit For
    End If

Next
```

---

## 9. Exit Do

`Do` 반복문을 중간에 종료할 때 사용합니다.

```vbscript
Dim retryCount
retryCount = 0

Do While True

    retryCount = retryCount + 1

    If retryCount >= 3 Then
        Exit Do
    End If

Loop
```

!!! warning "무한 반복 주의"
    `Do While`, `Do Until`을 사용할 때는 종료 조건에 영향을 주는 값이 실제로 변경되는지 반드시 확인해야 합니다.

---

## 10. 중첩 반복문

반복문 안에 반복문을 사용할 수도 있습니다.

```vbscript
Dim row
Dim col

For row = 0 To 2

    For col = 0 To 3
        MsgBox "row=" & row & ", col=" & col
    Next

Next
```

그리드의 행과 열을 함께 처리하는 코드에서 볼 수 있습니다.

---

## 11. 합계 계산 패턴

반복문에서 매우 자주 등장하는 패턴입니다.

```vbscript
Dim amounts
Dim total
Dim i

amounts = Array(1000, 2000, 3000)
total = 0

For i = LBound(amounts) To UBound(amounts)
    total = total + amounts(i)
Next

MsgBox "합계 : " & total
```

금융 화면에서는 수량, 금액, 수수료 등의 합산 로직에서 비슷한 코드를 자주 볼 수 있습니다.

---

## 12. 조건에 맞는 항목만 처리

반복문 안에서 `If`를 함께 사용하는 패턴입니다.

```vbscript
Dim statuses
Dim i

statuses = Array("01", "02", "99", "01")

For i = LBound(statuses) To UBound(statuses)

    If statuses(i) = "01" Then
        MsgBox "처리 대상입니다."
    End If

Next
```

---

## 13. 그리드 행 처리 패턴

전용 UI 플랫폼마다 API 이름은 다르지만 논리 구조는 비슷합니다.

```vbscript
Dim row

For row = 0 To rowCount - 1

    ' 1. 행의 선택 여부 확인
    ' 2. 필요한 컬럼 값 읽기
    ' 3. 값 검증
    ' 4. 요청 데이터 구성
    ' 5. 합계 또는 건수 계산

Next
```

조금 더 구체적인 예:

```vbscript
Dim row
Dim selectedYn
Dim amount
Dim totalAmount

totalAmount = 0

For row = 0 To rowCount - 1

    selectedYn = grid.GetText(row, "SELECT_YN")

    If selectedYn = "Y" Then
        amount = grid.GetText(row, "AMOUNT")

        If IsNumeric(amount) Then
            totalAmount = totalAmount + CDbl(amount)
        End If
    End If

Next
```

!!! tip "그리드 루프를 읽는 방법"
    반복문 자체보다 `row`로 어떤 컬럼을 읽고, 어떤 조건의 행만 처리하며, 그 값이 어디로 전달되는지 추적하세요.

---

## 14. 반복문 선택 기준

| 상황 | 권장 반복문 |
|---|---|
| 반복 횟수가 명확함 | `For ... Next` |
| 배열 인덱스가 필요함 | `For ... Next` |
| 배열/컬렉션 값을 하나씩 처리 | `For Each ... Next` |
| 조건이 참인 동안 반복 | `Do While ... Loop` |
| 특정 조건이 될 때까지 반복 | `Do Until ... Loop` |
| 최소 한 번 실행 후 조건 검사 | `Do ... Loop While/Until` |

---

## 15. 기존 소스를 읽을 때 확인할 것

```text
1. 무엇을 반복하는가?
2. 반복 범위는 어디까지인가?
3. 어떤 값이 반복 중 변경되는가?
4. 반복문 내부에서 어떤 조건문이 사용되는가?
5. Exit For / Exit Do가 존재하는가?
6. 어떤 함수나 서버 호출이 반복 안에서 실행되는가?
```

!!! warning "서버 호출이 반복문 안에 있는지 확인"
    반복문 내부에서 서버 요청이나 연계 호출이 반복된다면 처리 건수에 따라 성능에 영향을 줄 수 있습니다. 기존 소스를 분석할 때는 **반복문 안에서 어떤 외부 호출이 수행되는지**를 확인하는 것이 중요합니다.

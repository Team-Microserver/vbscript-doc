# 배열과 반복 처리

VBScript 배열은 **여러 값을 하나의 변수에 순서대로 저장**할 때 사용합니다.  
화면 프로그램에서는 코드 목록, 조회 결과 가공, 문자열 분리 결과, 선택 항목 저장, 요청 데이터 구성 등에 자주 등장합니다.

Java나 JavaScript의 배열과 개념은 비슷하지만, **배열 선언 방식과 크기 지정 방법**에 차이가 있으므로 주의해서 봐야 합니다.

---

## 1. 배열의 기본 개념

일반 변수는 하나의 값을 저장합니다.

```vbscript
Dim accountNo
accountNo = "111"
```

배열은 여러 값을 인덱스로 구분해서 저장합니다.

```vbscript
Dim accounts(2)

accounts(0) = "111"
accounts(1) = "222"
accounts(2) = "333"
```

---

## 2. 고정 크기 배열

VBScript에서:

```vbscript
Dim accounts(2)
```

는 요소가 2개라는 뜻이 아니라 **마지막 인덱스가 2**라는 뜻입니다.

```text
accounts(0)
accounts(1)
accounts(2)
```

따라서 총 **3개**의 요소를 가집니다.

!!! warning "Java 개발자가 자주 헷갈리는 부분"
    Java의 `new String[2]`는 2개지만, VBScript의 `Dim arr(2)`는 인덱스 0~2의 총 3개입니다.

---

## 3. Array 함수로 배열 생성

간단한 값을 바로 배열로 만들 때 `Array()` 함수를 사용할 수 있습니다.

```vbscript
Dim accounts

accounts = Array("111", "222", "333")
```

```vbscript
MsgBox accounts(0)
MsgBox accounts(1)
MsgBox accounts(2)
```

---

## 4. LBound와 UBound

배열의 첫 번째 인덱스와 마지막 인덱스를 얻습니다.

```vbscript
Dim accounts

accounts = Array("111", "222", "333")

MsgBox LBound(accounts)
MsgBox UBound(accounts)
```

결과:

```text
LBound(accounts) = 0
UBound(accounts) = 2
```

### 배열 반복 처리

```vbscript
Dim accounts
Dim i

accounts = Array("111", "222", "333")

For i = LBound(accounts) To UBound(accounts)
    MsgBox accounts(i)
Next
```

!!! tip "LBound / UBound 사용 권장"
    배열 크기를 하드코딩하기보다 `LBound`, `UBound`를 사용하는 것이 안전합니다.

---

## 5. For Each로 배열 순회

인덱스가 필요하지 않다면 `For Each`를 사용할 수 있습니다.

```vbscript
Dim accounts
Dim account

accounts = Array("111", "222", "333")

For Each account In accounts
    MsgBox account
Next
```

### For와 For Each 비교

```vbscript
' 인덱스가 필요한 경우
For i = LBound(accounts) To UBound(accounts)
    MsgBox i & " : " & accounts(i)
Next
```

```vbscript
' 값만 필요한 경우
For Each account In accounts
    MsgBox account
Next
```

---

## 6. 동적 배열

배열의 크기를 선언 시점에 결정할 수 없다면 동적 배열을 사용합니다.

```vbscript
Dim accounts()
```

필요한 시점에 `ReDim`으로 크기를 지정합니다.

```vbscript
ReDim accounts(2)

accounts(0) = "111"
accounts(1) = "222"
accounts(2) = "333"
```

---

## 7. ReDim

동적 배열의 크기를 지정하거나 다시 변경할 때 사용합니다.

```vbscript
Dim accounts()

ReDim accounts(2)
```

이후 다시 크기를 변경할 수도 있습니다.

```vbscript
ReDim accounts(5)
```

!!! warning "ReDim을 다시 실행하면 기존 값이 사라질 수 있습니다"
    기존 값을 유지하면서 배열 크기를 변경하려면 `Preserve`를 사용합니다.

---

## 8. ReDim Preserve

기존 데이터를 유지하면서 배열 크기를 변경합니다.

```vbscript
Dim accounts()

ReDim accounts(2)

accounts(0) = "111"
accounts(1) = "222"
accounts(2) = "333"

ReDim Preserve accounts(4)

accounts(3) = "444"
accounts(4) = "555"
```

!!! warning "ReDim Preserve 남용 주의"
    반복문 안에서 배열 크기를 계속 늘리면 매번 배열을 다시 구성해야 하므로 비효율적일 수 있습니다. 데이터 건수가 많거나 구조가 복잡하다면 `Dictionary`나 플랫폼 데이터 구조를 검토하는 편이 좋습니다.

---

## 9. Split 결과는 배열

문자열을 구분자로 나누면 배열이 반환됩니다.

```vbscript
Dim values

values = Split("A|B|C", "|")
```

결과:

```text
values(0) = "A"
values(1) = "B"
values(2) = "C"
```

반복해서 처리할 수 있습니다.

```vbscript
Dim values
Dim i

values = Split("A|B|C", "|")

For i = LBound(values) To UBound(values)
    MsgBox values(i)
Next
```

---

## 10. Join으로 배열을 문자열로 변환

`Split`과 반대로 배열을 하나의 문자열로 합칠 때 `Join`을 사용할 수 있습니다.

```vbscript
Dim values
Dim result

values = Array("A", "B", "C")

result = Join(values, "|")

MsgBox result
```

결과:

```text
A|B|C
```

---

## 11. 배열에서 값 검색

특정 값이 배열에 존재하는지 확인하는 패턴입니다.

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

If found Then
    MsgBox "계좌를 찾았습니다."
Else
    MsgBox "계좌가 없습니다."
End If
```

---

## 12. 배열 값 필터링

특정 조건에 맞는 값만 처리할 수 있습니다.

```vbscript
Dim statuses
Dim i

statuses = Array("01", "02", "99", "01")

For i = LBound(statuses) To UBound(statuses)

    If statuses(i) = "01" Then
        MsgBox "정상 처리 대상입니다."
    End If

Next
```

---

## 13. 배열 합계 계산

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

---

## 14. 2차원 배열

VBScript에서는 다차원 배열도 선언할 수 있습니다.

```vbscript
Dim data(1, 2)

data(0, 0) = "001"
data(0, 1) = "김고객"
data(0, 2) = "정상"

data(1, 0) = "002"
data(1, 1) = "이고객"
data(1, 2) = "정지"
```

첫 번째 인덱스를 행, 두 번째 인덱스를 열처럼 사용할 수 있습니다.

```vbscript
MsgBox data(0, 1)
```

### 2차원 배열 반복

```vbscript
Dim row
Dim col

For row = 0 To 1

    For col = 0 To 2
        MsgBox data(row, col)
    Next

Next
```

---

## 15. 다차원 배열의 UBound

`UBound`의 두 번째 인수로 차원을 지정할 수 있습니다.

```vbscript
Dim data(1, 2)

MsgBox UBound(data, 1)
MsgBox UBound(data, 2)
```

반복할 때도 차원을 지정할 수 있습니다.

```vbscript
Dim row
Dim col

For row = LBound(data, 1) To UBound(data, 1)

    For col = LBound(data, 2) To UBound(data, 2)
        MsgBox data(row, col)
    Next

Next
```

---

## 16. 다차원 배열과 ReDim Preserve

다차원 배열에서 `ReDim Preserve`는 제약이 있습니다. 기존 데이터를 유지하려면 일반적으로 **마지막 차원의 크기만 변경할 수 있습니다.**

따라서 복잡한 행/열 데이터를 계속 늘려야 하는 경우에는 배열보다 다른 구조가 더 적합할 수 있습니다.

!!! tip "실무에서는 플랫폼 데이터 구조를 먼저 확인"
    Alpharo 같은 화면 개발 플랫폼에서는 자체 데이터셋, 그리드, 인터페이스 버퍼 등의 데이터 구조를 제공할 수 있습니다. 기존 소스를 분석할 때 배열처럼 보이는 데이터가 실제 VBScript 배열인지, 플랫폼 전용 객체인지 먼저 구분하는 것이 중요합니다.

---

## 17. 배열인지 확인하기

`IsArray` 함수로 값이 배열인지 확인할 수 있습니다.

```vbscript
Dim values

values = Split("A|B|C", "|")

If IsArray(values) Then
    MsgBox "배열입니다."
End If
```

---

## 18. 배열과 문자열 처리 패턴

실무에서 자주 볼 수 있는 흐름입니다.

```vbscript
Dim codeText
Dim codes
Dim i

codeText = "01|02|03"
codes = Split(codeText, "|")

For i = LBound(codes) To UBound(codes)

    Select Case codes(i)
        Case "01"
            MsgBox "조회"

        Case "02"
            MsgBox "저장"

        Case "03"
            MsgBox "삭제"
    End Select

Next
```

```text
문자열
   ↓
Split
   ↓
배열
   ↓
For 반복
   ↓
Select Case
   ↓
업무 처리
```

---

## 19. 배열을 읽을 때 확인할 것

```text
1. 배열은 어디에서 생성되는가?
2. 고정 배열인가, 동적 배열인가?
3. 배열의 인덱스 범위는 어떻게 결정되는가?
4. Split 결과인가?
5. 각 인덱스가 어떤 업무 의미를 가지는가?
6. 반복문에서 값이 어디로 전달되는가?
```

특히 다음처럼 숫자 인덱스만 사용하는 코드에서는:

```vbscript
value = resultData(3)
```

문법보다 **3번 인덱스가 어떤 업무 값을 의미하는지** 파악하는 것이 더 중요합니다.

---

## 20. 핵심 정리

```text
Dim arr(2)
→ 인덱스 0~2, 총 3개

Array(...)
→ 값을 이용해 배열 생성

LBound(arr)
→ 첫 번째 인덱스

UBound(arr)
→ 마지막 인덱스

ReDim
→ 동적 배열 크기 설정

ReDim Preserve
→ 기존 값을 유지하면서 크기 변경

Split
→ 문자열을 배열로 분리

Join
→ 배열을 문자열로 결합

IsArray
→ 배열 여부 확인
```

!!! tip "배열 학습 포인트"
    VBScript 배열 문법 자체를 깊게 암기하기보다는 `LBound`, `UBound`, `Split`, `ReDim Preserve`를 읽을 수 있는 수준까지 익힌 뒤, 실제 화면 소스에서 배열 값이 어떤 업무 데이터로 사용되는지를 추적하는 것이 더 중요합니다.

# 날짜와 숫자 처리

금융 화면에서는 금액, 수량, 비율, 거래일자, 조회기간과 같은 **숫자와 날짜 데이터**를 매우 자주 다룬다.

VBScript는 `Variant`를 기반으로 값을 처리하기 때문에 문자열 형태로 들어온 숫자나 날짜가 상황에 따라 자동 변환될 수 있다. 하지만 자동 형변환에 의존하면 입력값이나 지역 설정에 따라 예상하지 못한 오류가 발생할 수 있다.

따라서 실제 업무 코드에서는 다음 순서를 기본으로 생각하는 것이 좋다.

```text
화면 또는 외부 입력값
        ↓
공백 및 표시문자 정리
        ↓
값 존재 여부 확인
        ↓
형식 검증
        ↓
명시적 형변환
        ↓
계산 또는 비교
        ↓
화면 표시 시 Format 적용
```

!!! important "계산용 값과 표시용 값을 구분한다"
    `FormatNumber()`와 같은 함수는 **사용자에게 보여주기 위한 표시 형식**을 만드는 데 사용한다.

    실제 계산은 가능하면 원래의 숫자 값으로 수행하고, 화면에 표시하기 직전에 포맷을 적용한다.

---

## 1. 숫자 처리 기본 흐름

화면에서 입력한 값은 문자열로 들어오는 경우가 많다.

예를 들어 금액 입력값이 다음과 같다고 가정한다.

```text
"1250000"
```

또는 화면에 천 단위 구분기호가 표시되어 있다면:

```text
"1,250,000"
```

일 수 있다.

이 값을 바로 계산하기보다 다음 순서로 처리한다.

```text
입력값
  ↓
Trim
  ↓
필요하면 콤마 등 표시문자 제거
  ↓
빈 값 확인
  ↓
IsNumeric
  ↓
CLng / CDbl / CCur 등으로 변환
  ↓
계산
```

### 1.1 기본 예제

```vbscript
Option Explicit

Dim amountText
Dim amount

amountText = Trim(txtAmount.Text)
amountText = Replace(amountText, ",", "")

If amountText = "" Then

    amount = 0

ElseIf Not IsNumeric(amountText) Then

    MsgBox "금액은 숫자로 입력하세요."
    Exit Sub

Else

    amount = CLng(amountText)

End If
```

!!! note "화면 컨트롤 코드는 예시"
    `txtAmount.Text`와 같은 코드는 화면 개발 환경을 설명하기 위한 예시다.

    실제 프로젝트에서는 사용 중인 화면 개발 도구의 컨트롤 접근 방법을 확인해야 한다.

---

## 2. 숫자 검증과 형변환

### 2.1 `IsNumeric()`

`IsNumeric()`은 값이 **숫자로 해석 가능한지 확인하는 함수**다.

#### 문법

```vbscript
IsNumeric(Expression)
```

#### 파라미터

| 파라미터 | 의미 |
|---|---|
| `Expression` | 숫자로 해석 가능한지 확인할 값 |

#### 반환값

| 반환값 | 의미 |
|---|---|
| `True` | 숫자로 해석 가능 |
| `False` | 숫자로 해석할 수 없음 |

#### 예제

```vbscript
WScript.Echo IsNumeric("100")
WScript.Echo IsNumeric("123.45")
WScript.Echo IsNumeric("ABC")
```

개념적으로 다음과 같이 판단한다.

```text
"100"     → True
"123.45"  → True
"ABC"     → False
```

!!! important "`IsNumeric()`은 변환 함수가 아니다"
    `IsNumeric()`은 값이 숫자로 변환 가능한지를 **검사만 한다.**

    실제 숫자로 사용하려면 이후 `CInt()`, `CLng()`, `CDbl()`, `CCur()` 등의 형변환 함수를 사용한다.

예:

```vbscript
If IsNumeric(amountText) Then
    amount = CLng(amountText)
End If
```

---

### 2.2 `Variant`와 subtype 이해하기

VBScript의 변수를 이해할 때 가장 먼저 알아야 할 개념이 `Variant`다.

Java처럼 변수 선언 시 자료형을 직접 지정하는 방식과 달리 VBScript에서는 일반적으로 다음처럼 변수를 선언한다.

```vbscript
Dim value
Dim amount
Dim tradeDate
```

이렇게 선언된 변수의 기본 자료형은 모두 `Variant`다.

하지만 `Variant` 안에 실제로 저장되는 값에는 다시 **세부 자료형(subtype)** 이 존재한다.

```text
Variant
 ├─ Empty
 ├─ Null
 ├─ Integer
 ├─ Long
 ├─ Double
 ├─ Currency
 ├─ Date
 ├─ String
 ├─ Boolean
 └─ Object
```

즉 다음 코드를 보자.

```vbscript
Dim value

value = "100"
```

`value`라는 변수 자체는 `Variant`이지만 현재 들어 있는 값의 subtype은 `String`이다.

```text
value 변수
   ↓
Variant
   ↓
현재 저장된 값
   ↓
String subtype
```

이 상태에서 다음과 같이 형변환하면:

```vbscript
value = CLng(value)
```

변수는 여전히 `Variant`이지만 내부 값의 subtype이 `Long`으로 바뀐다.

```text
"100"
  ↓
String subtype
  ↓
CLng()
  ↓
100
  ↓
Long subtype
```

!!! important "`Variant`와 subtype을 구분한다"
    VBScript에서는 `Dim value As Long`처럼 변수 자체를 특정 숫자형으로 선언하지 않는다.

    대신 **Variant 변수 안에 어떤 subtype의 값이 들어 있는지**가 중요하다.

    따라서 `CInt()`, `CLng()`, `CDbl()`, `CCur()`, `CDate()` 같은 함수는 Variant 내부의 값을 원하는 subtype으로 변환하는 함수라고 이해하면 된다.

#### `TypeName()`으로 subtype 확인

`TypeName()`을 사용하면 현재 값의 subtype 이름을 확인할 수 있다.

```vbscript
Option Explicit

Dim value

value = "100"
WScript.Echo TypeName(value)

value = CInt(value)
WScript.Echo TypeName(value)

value = CLng(value)
WScript.Echo TypeName(value)

value = CDbl(value)
WScript.Echo TypeName(value)

value = CCur(value)
WScript.Echo TypeName(value)
```

결과:

```text
String
Integer
Long
Double
Currency
```

변수 `value`는 계속 같은 `Variant` 변수이지만, 내부 값의 subtype이 변하고 있는 것이다.

#### `VarType()`으로 subtype 코드 확인

`VarType()`은 subtype을 숫자 코드로 반환한다.

```vbscript
Option Explicit

Dim amount

amount = CCur("1234567.89")

WScript.Echo TypeName(amount)
WScript.Echo VarType(amount)
```

결과:

```text
Currency
6
```

대표적인 subtype과 `VarType()` 값은 다음과 같다.

| subtype | `VarType()` 값 | 의미 |
|---|---:|---|
| `Empty` | `0` | 아직 값이 할당되지 않음 |
| `Null` | `1` | 유효한 값이 없음을 의미 |
| `Integer` | `2` | 작은 범위의 정수 |
| `Long` | `3` | 일반 정수 |
| `Double` | `5` | 부동소수점 실수 |
| `Currency` | `6` | 고정 소수점 금액형 |
| `Date` | `7` | 날짜/시간 |
| `String` | `8` | 문자열 |
| `Boolean` | `11` | 참/거짓 |

!!! tip "소스를 읽을 때"
    다음과 같은 코드가 보이면 단순 함수 호출로만 보지 않는다.

    ```vbscript
    amount = CCur(amountText)
    ```

    다음과 같이 해석한다.

    ```text
    amountText
    → 문자열 또는 다른 Variant 값

    CCur()
    → Currency subtype으로 변환

    amount
    → Currency subtype 값을 가진 Variant
    ```

이제 숫자 형변환 함수들을 보면 각각 어떤 subtype으로 변환하는지 이해하기 쉬워진다.

| 함수 | 변환되는 subtype | 주요 용도 |
|---|---|---|
| `CInt()` | Integer | 작은 범위의 정수 |
| `CLng()` | Long | 일반적인 정수 |
| `CDbl()` | Double | 소수점이 필요한 실수 |
| `CCur()` | Currency | 금액처럼 고정 소수점 정밀도가 필요한 값 |

---

### 2.3 `CInt()`

`CInt()`는 값을 `Integer` subtype으로 변환한다.

#### 문법

```vbscript
CInt(Expression)
```

#### 파라미터

| 파라미터 | 의미 |
|---|---|
| `Expression` | Integer로 변환할 값 |

#### Integer 범위

```text
-32,768 ~ 32,767
```

범위를 벗어나면 Overflow 오류가 발생할 수 있다.

#### 문자열 숫자 변환

```vbscript
Dim value

value = "100"
value = CInt(value)

WScript.Echo value + 10
```

결과:

```text
110
```

!!! note "자동 형변환과의 차이"
    다음 코드도 VBScript의 자동 형변환 때문에 `110`이 나올 수 있다.

    ```vbscript
    Dim value

    value = "100"

    WScript.Echo value + 10
    ```

    하지만 `CInt(value)`처럼 명시적으로 변환하면 **이 값을 숫자로 사용한다는 의도**가 코드에 분명하게 나타난다.

#### 소수 값을 전달한 경우

```vbscript
WScript.Echo CInt(10.6)
```

`CInt()`는 단순히 소수점 아래를 잘라내는 함수가 아니라 **정수로 반올림하여 변환**한다.

또한 소수 부분이 정확히 `.5`인 경우에는 가까운 **짝수 정수 방향으로 반올림**하는 방식이 적용될 수 있다.

예:

```vbscript
WScript.Echo CInt(1.5)
WScript.Echo CInt(2.5)
```

결과:

```text
2
2
```

따라서 `CInt()`를 `Int()`나 `Fix()`처럼 소수점 이하를 단순 제거하는 함수로 이해하면 안 된다.

!!! warning "`CInt()`와 금융 금액"
    `Integer`의 범위가 작기 때문에 실제 금융 금액을 저장하는 용도로는 적합하지 않은 경우가 많다.

    정수 금액이라면 보통 값의 범위를 확인한 후 `CLng()` 등을 검토한다.

---

### 2.4 `CLng()`

`CLng()`는 값을 `Long` subtype으로 변환한다.

#### 문법

```vbscript
CLng(Expression)
```

#### 파라미터

| 파라미터 | 의미 |
|---|---|
| `Expression` | Long으로 변환할 값 |

#### Long 범위

```text
-2,147,483,648 ~ 2,147,483,647
```

#### 예제

```vbscript
Dim amount

amount = "1500000"
amount = CLng(amount)

WScript.Echo amount + 500000
```

결과:

```text
2000000
```

#### 업무 코드 예

```vbscript
Dim amountText
Dim amount

amountText = Replace(Trim(txtAmount.Text), ",", "")

If amountText = "" Then

    amount = 0

ElseIf Not IsNumeric(amountText) Then

    MsgBox "금액은 숫자로 입력하세요."
    Exit Sub

Else

    amount = CLng(amountText)

End If
```

!!! warning "범위 확인"
    `CLng()`도 무한히 큰 정수를 저장할 수 있는 것은 아니다.

    실제 업무 데이터가 약 21억을 넘을 수 있다면 `Long` 범위에 들어오는지 먼저 확인해야 한다.


!!! note "`CLng()`도 소수 값을 반올림한다"
    `CLng()` 역시 소수 값이 들어오면 정수로 반올림하여 변환한다.

    따라서 단순히 소수점 이하를 버리는 목적으로 사용하지 않는다.

---

### 2.5 `CDbl()`

`CDbl()`은 값을 `Double` subtype으로 변환한다.

소수점이 필요한 계산에서 주로 사용한다.

#### 문법

```vbscript
CDbl(Expression)
```

#### 파라미터

| 파라미터 | 의미 |
|---|---|
| `Expression` | Double로 변환할 값 |

#### 예제

```vbscript
Dim rate

rate = "12.5"
rate = CDbl(rate)

WScript.Echo rate + 0.5
```

결과:

```text
13
```

#### 소수 계산 예

```vbscript
Dim price
Dim quantity
Dim total

price = CDbl("1250.5")
quantity = CDbl("3")

total = price * quantity

WScript.Echo total
```

결과:

```text
3751.5
```

!!! warning "Double과 정밀도"
    `Double`은 부동소수점 방식이므로 일부 소수 계산에서는 사람이 기대하는 십진수 표현과 아주 작은 오차가 생길 수 있다.

    금액처럼 소수점 정밀도가 중요한 값은 프로젝트의 데이터 정의를 확인하고 `Currency`, DB Numeric/Decimal 등의 처리 기준과 맞추는 것이 중요하다.

---

### 2.6 `CCur()`

`CCur()`는 값을 **`Currency` subtype으로 변환하는 형변환 함수**다.

앞에서 설명한 것처럼 `amount` 같은 변수 자체가 Currency 타입으로 선언되는 것은 아니다.

```vbscript
Dim amount

amount = CCur("1234567.89")
```

이 코드를 실행하면 개념적으로 다음과 같이 된다.

```text
amount 변수
   ↓
Variant
   ↓
현재 저장된 값의 subtype
   ↓
Currency
```

즉 `CCur()`는 Variant 내부의 값을 **금액 계산에 적합한 Currency subtype 값으로 변환**한다.

#### 문법

```vbscript
CCur(Expression)
```

#### 파라미터

| 파라미터 | 의미 |
|---|---|
| `Expression` | Currency subtype으로 변환할 숫자 또는 숫자로 변환 가능한 값 |

예를 들어 문자열 `"1234567.89"`도 숫자로 변환 가능한 값이므로 다음과 같이 사용할 수 있다.

```vbscript
Dim amountText
Dim amount

amountText = "1234567.89"
amount = CCur(amountText)

WScript.Echo amount
```

#### 변환 흐름

```text
"1234567.89"
      ↓
String subtype
      ↓
CCur()
      ↓
1234567.89
      ↓
Currency subtype
```

#### `TypeName()`으로 확인

```vbscript
Option Explicit

Dim amount

amount = CCur("1234567.89")

WScript.Echo TypeName(amount)
WScript.Echo VarType(amount)
```

결과:

```text
Currency
6
```

즉:

```text
TypeName(amount)
→ Currency

VarType(amount)
→ 6
```

으로 현재 값이 Currency subtype임을 확인할 수 있다.

#### Currency 범위와 소수 자릿수

`Currency` subtype은 소수점 이하 **4자리까지 고정 정밀도**로 처리하며 다음 범위를 가진다.

```text
-922,337,203,685,477.5808
~
 922,337,203,685,477.5807
```

예를 들어:

```vbscript
Dim amount

amount = CCur("1234567.8912")

WScript.Echo amount
```

Currency는 소수점 이하 4자리 정밀도로 금액 값을 다루는 데 적합하다.

!!! important "`Currency`는 통화 기호를 붙이는 형식이 아니다"
    이름이 `Currency`라고 해서 자동으로 `₩`, `$` 같은 통화 기호를 붙이는 것은 아니다.

    `Currency`는 **숫자 값을 저장하고 계산하는 subtype**이다.

    화면에 금액을 어떤 형식으로 보여줄지는 `FormatNumber()`, `FormatCurrency()` 또는 프로젝트의 UI 포맷 규칙을 별도로 적용한다.

#### `CDbl()`과 `CCur()`의 차이

`CDbl()`과 `CCur()`는 둘 다 소수 값을 다룰 수 있지만 내부 표현 방식과 목적이 다르다.

| 구분 | `CDbl()` | `CCur()` |
|---|---|---|
| 변환 subtype | Double | Currency |
| 숫자 방식 | 부동소수점 | 고정 소수점 |
| 소수 처리 | 매우 넓은 범위와 정밀도 | 소수점 이하 4자리 고정 정밀도 |
| 주요 용도 | 일반 실수 계산 | 금액 계산 |
| 주의점 | 일부 십진수에서 미세한 표현 오차 가능 | 표현 범위와 소수 4자리 제한 |

개념적으로:

```text
CDbl
→ Double subtype
→ 부동소수점
→ 일반적인 실수 계산

CCur
→ Currency subtype
→ 고정 소수점
→ 금액 계산에 적합
```

#### 실무 예제

```vbscript
Option Explicit

Dim amountText
Dim amount
Dim feeRate
Dim fee

amountText = "1250000.50"
feeRate = CCur("0.015")

If IsNumeric(amountText) Then

    amount = CCur(amountText)
    fee = amount * feeRate

    WScript.Echo "금액 : " & FormatNumber(amount, 2)
    WScript.Echo "수수료 : " & FormatNumber(fee, 2)

End If
```

여기서 처리 흐름은 다음과 같다.

```text
문자열 입력
   ↓
IsNumeric()
   ↓
CCur()
   ↓
Currency subtype
   ↓
금액 계산
   ↓
FormatNumber()
   ↓
화면 표시
```

!!! note "실제 프로젝트 타입 기준을 우선"
    어떤 변환 함수를 사용할지는 단순히 함수 이름만 보고 정하지 않는다.

    DB 컬럼 타입, 서버 인터페이스 정의, 소수점 자리수, 최대 금액 범위 등을 확인한 뒤 프로젝트 기준에 맞게 선택한다.

---

## 3. 숫자 표시 - `FormatNumber()`

`FormatNumber()`는 숫자를 계산하기 위한 함수가 아니라 **숫자를 사용자에게 보기 좋은 형식으로 표시하기 위한 함수**다.

예를 들어:

```text
1234567.89
```

를:

```text
1,234,567.89
```

처럼 표시할 수 있다.

---

### 3.1 문법

전체 문법은 다음과 같다.

```vbscript
FormatNumber(Expression, NumDigitsAfterDecimal, IncludeLeadingDigit, UseParensForNegativeNumbers, GroupDigits)
```

뒤의 일부 파라미터는 생략할 수 있다.

가장 많이 사용하는 형태는 다음과 같다.

```vbscript
FormatNumber(Expression, NumDigitsAfterDecimal)
```

예:

```vbscript
FormatNumber(1234567.89, 2)
```

---

### 3.2 파라미터

| 순서 | 파라미터 | 의미 | 대표 값 |
|---|---|---|---|
| 1 | `Expression` | 포맷할 숫자 | `1234567.89` |
| 2 | `NumDigitsAfterDecimal` | 소수점 이하 표시 자릿수 | `0`, `1`, `2`, `3`, `-1` |
| 3 | `IncludeLeadingDigit` | 1보다 작은 값 앞에 `0`을 표시할지 여부 | `vbTrue`, `vbFalse`, `vbUseDefault` |
| 4 | `UseParensForNegativeNumbers` | 음수를 괄호 형식으로 표시할지 여부 | `vbTrue`, `vbFalse`, `vbUseDefault` |
| 5 | `GroupDigits` | 천 단위 그룹 구분기호를 사용할지 여부 | `vbTrue`, `vbFalse`, `vbUseDefault` |

`NumDigitsAfterDecimal`을 생략하거나 `-1`을 사용하면 시스템의 지역 설정에 정의된 소수 자릿수 기준을 사용할 수 있다.

선택 옵션에 자주 사용하는 상수:

| 상수 | 값 | 의미 |
|---|---:|---|
| `vbTrue` | `-1` | 기능 사용 |
| `vbFalse` | `0` | 기능 사용 안 함 |
| `vbUseDefault` | `-2` | 시스템 기본 설정 사용 |

---

### 3.3 첫 번째 파라미터 - `Expression`

첫 번째 파라미터는 포맷할 숫자다.

```vbscript
FormatNumber(1234567.89, 2)
```

여기서:

```text
Expression
= 1234567.89
```

이다.

변수를 전달할 수도 있다.

```vbscript
Dim amount

amount = 1234567.89

WScript.Echo FormatNumber(amount, 2)
```

---

### 3.4 두 번째 파라미터 - `NumDigitsAfterDecimal`

두 번째 파라미터는 **소수점 이하를 몇 자리까지 표시할지** 지정한다.

#### 소수점 2자리

```vbscript
Dim formatted

formatted = FormatNumber(1234567.89, 2)

WScript.Echo formatted
```

일반적인 숫자 지역 설정 기준:

```text
1,234,567.89
```

#### 소수점 3자리

```vbscript
formatted = FormatNumber(1234567.89, 3)

WScript.Echo formatted
```

결과:

```text
1,234,567.890
```

부족한 자리는 `0`으로 채워진다.

#### 소수점 1자리

```vbscript
formatted = FormatNumber(1234567.89, 1)

WScript.Echo formatted
```

결과:

```text
1,234,567.9
```

#### 반올림

```vbscript
WScript.Echo FormatNumber(123.4567, 2)
```

결과:

```text
123.46
```

!!! important "`FormatNumber()`는 단순 문자열 자르기가 아니다"
    지정한 소수점 자리수에 맞게 숫자를 포맷하므로 필요한 경우 반올림이 발생한다.

---

### 3.5 세 번째 파라미터 - `IncludeLeadingDigit`

세 번째 파라미터는 절댓값이 1보다 작은 숫자의 소수점 앞에 `0`을 표시할지 결정한다.

예를 들어 값이:

```text
0.75
```

인 경우다.

#### `vbTrue`

```vbscript
WScript.Echo FormatNumber(0.75, 2, vbTrue)
```

표시 형태:

```text
0.75
```

#### `vbFalse`

```vbscript
WScript.Echo FormatNumber(0.75, 2, vbFalse)
```

표시 형태는 다음처럼 앞의 `0` 없이 표현된다.

```text
.75
```

!!! tip "업무 화면"
    일반적인 업무 화면에서는 `0.75`처럼 앞의 `0`이 있는 편이 읽기 쉽다.

    프로젝트 UI 표준이 있다면 해당 표준을 우선한다.

---

### 3.6 네 번째 파라미터 - `UseParensForNegativeNumbers`

네 번째 파라미터는 음수를 괄호로 표현할지 결정한다.

일반적인 음수 표시:

```text
-1,234.56
```

괄호형 음수 표시:

```text
(1,234.56)
```

예:

```vbscript
Dim formatted

formatted = FormatNumber(-1234.56, 2, vbTrue, vbTrue, vbTrue)

WScript.Echo formatted
```

일반적인 환경에서는 다음과 같은 형태가 된다.

```text
(1,234.56)
```

회계 화면 등에서 음수를 괄호로 표시하는 경우 활용할 수 있다.

---

### 3.7 다섯 번째 파라미터 - `GroupDigits`

다섯 번째 파라미터는 **천 단위 그룹 구분기호를 표시할지 여부**를 지정한다.

#### `vbTrue`

```vbscript
WScript.Echo FormatNumber(1234567.89, 2, vbTrue, vbFalse, vbTrue)
```

일반적인 환경:

```text
1,234,567.89
```

#### `vbFalse`

```vbscript
WScript.Echo FormatNumber(1234567.89, 2, vbTrue, vbFalse, vbFalse)
```

결과:

```text
1234567.89
```

즉 마지막 인수 하나로:

```text
1,234,567.89
```

와:

```text
1234567.89
```

를 구분할 수 있다.

---

### 3.8 전체 예제

```vbscript
Option Explicit

Dim numberValue
Dim formatted

numberValue = 1234567.89

formatted = FormatNumber(numberValue, 2, vbTrue, vbFalse, vbTrue)

WScript.Echo formatted
```

각 파라미터를 풀어보면:

```text
numberValue
→ 1234567.89

2
→ 소수점 이하 2자리

vbTrue
→ 1보다 작은 수에서 앞쪽 0 표시

vbFalse
→ 음수를 괄호로 표시하지 않음

vbTrue
→ 천 단위 그룹 구분기호 사용
```

일반적인 Windows 숫자 형식에서는:

```text
1,234,567.89
```

와 같은 결과를 기대할 수 있다.

---

### 3.9 Windows 지역 설정의 영향

`FormatNumber()`의 결과는 **Windows의 지역 및 숫자 형식 설정 영향을 받을 수 있다.**

예를 들어 어떤 환경에서는:

```text
1,234,567.89
```

형식을 사용하지만 다른 지역 설정에서는:

```text
1.234.567,89
```

형식을 사용할 수 있다.

!!! warning "고정된 문자열 포맷이 필요한 경우"
    외부 전문, 파일 인터페이스, 서버 전문처럼 정확히 정해진 숫자 문자열 형식이 필요한 경우에는 `FormatNumber()` 결과를 그대로 인터페이스 값으로 사용하면 안 될 수 있다.

    `FormatNumber()`는 **화면 표시용 포맷 함수**라는 관점으로 이해하는 것이 안전하다.

---

### 3.10 계산용 값과 표시용 값 분리

권장하지 않는 방식:

```text
숫자
  ↓
FormatNumber
  ↓
포맷 문자열
  ↓
다시 계산에 사용
```

권장 방식:

```text
숫자
  ↓
계산
  ↓
최종 결과
  ↓
FormatNumber
  ↓
화면 표시
```

예:

```vbscript
Option Explicit

Dim balance
Dim formattedBalance

balance = 1234567.89

balance = balance + 10000

formattedBalance = FormatNumber(balance, 2)

WScript.Echo formattedBalance
```

---

### 3.11 콤마가 포함된 금액 입력

화면에서 다음과 같은 값이 들어올 수 있다.

```text
1,000,000
```

프로젝트의 입력 처리 기준과 지역 설정에 따라 다를 수 있으므로, 숫자 검증 전에 표시용 콤마를 제거하여 정규화하는 방식을 사용할 수 있다.

```vbscript
Dim amountText
Dim amount

amountText = Trim(txtAmount.Text)
amountText = Replace(amountText, ",", "")

If amountText = "" Then

    amount = 0

ElseIf Not IsNumeric(amountText) Then

    MsgBox "금액은 숫자로 입력하세요."
    Exit Sub

Else

    amount = CLng(amountText)

End If
```

!!! tip "입력 정규화"
    화면에서 사용하는 천 단위 구분기호와 소수점 기호가 무엇인지 먼저 확인한다.

    특히 해외 지역 설정이나 다국어 환경에서는 구분기호가 다를 수 있으므로 프로젝트 표준을 우선한다.

---

## 4. 날짜 처리 기본 흐름

날짜도 문자열 상태로 바로 비교하지 않는 것이 좋다.

권장 흐름:

```text
화면 입력값
    ↓
Trim
    ↓
빈 값 확인
    ↓
IsDate
    ↓
CDate
    ↓
날짜 비교 / DateDiff / DateAdd
```

---

## 5. 날짜 검증과 변환

### 5.1 `IsDate()`

`IsDate()`는 값이 날짜 또는 시간으로 인식 가능한지 확인한다.

#### 문법

```vbscript
IsDate(Expression)
```

#### 파라미터

| 파라미터 | 의미 |
|---|---|
| `Expression` | 날짜로 해석 가능한지 확인할 값 |

#### 반환값

| 반환값 | 의미 |
|---|---|
| `True` | 날짜로 변환 가능 |
| `False` | 날짜로 변환할 수 없음 |

#### 예제

```vbscript
WScript.Echo IsDate("2026-08-20")
WScript.Echo IsDate("ABC")
```

개념적으로:

```text
"2026-08-20" → True 가능
"ABC"        → False
```

!!! warning "날짜 형식과 지역 설정"
    문자열을 날짜로 해석하는 방식은 Windows 지역 설정의 영향을 받을 수 있다.

    `"01/02/2026"`처럼 월/일 순서가 모호한 표현은 환경에 따라 다르게 해석될 가능성이 있으므로 프로젝트의 날짜 포맷 표준을 확인한다.

---

### 5.2 `CDate()`

`CDate()`는 값을 `Date` subtype으로 변환한다.

숫자 형변환 함수와 마찬가지로 변수 자체가 Date 타입으로 새로 선언되는 것이 아니라, **Variant 내부의 값이 Date subtype으로 변환된다.**

```text
문자열 날짜
   ↓
CDate()
   ↓
Date subtype을 가진 Variant
```

#### 문법

```vbscript
CDate(Expression)
```

#### 파라미터

| 파라미터 | 의미 |
|---|---|
| `Expression` | 날짜 또는 시간으로 변환할 값 |

#### 예제

```vbscript
Dim tradeDate

tradeDate = CDate("2026-08-20")

WScript.Echo tradeDate
```

#### 화면 입력값 검증

```vbscript
Dim tradeDateText
Dim tradeDate

tradeDateText = Trim(txtTradeDate.Text)

If tradeDateText = "" Then

    MsgBox "거래일자를 입력하세요."
    Exit Sub

ElseIf Not IsDate(tradeDateText) Then

    MsgBox "거래일자를 확인하세요."
    Exit Sub

Else

    tradeDate = CDate(tradeDateText)

End If
```

이후 비교는 문자열이 아니라 `tradeDate`로 수행한다.

---

### 5.3 날짜 문자열 직접 비교를 피하는 이유

다음 두 문자열을 비교한다고 가정한다.

```text
"2026-9-1"
"2026-10-1"
```

문자열 비교는 날짜의 시간적 순서를 비교하는 것이 아니라 **문자 자체의 순서**를 비교한다.

따라서 가능하면:

```text
문자열
  ↓
IsDate
  ↓
CDate
  ↓
Date 값
  ↓
비교
```

순서로 처리한다.

예:

```vbscript
Dim startDate
Dim endDate

startDate = CDate("2026-09-01")
endDate = CDate("2026-10-01")

If startDate <= endDate Then
    WScript.Echo "정상 기간"
End If
```

---

## 6. `DateDiff()`

`DateDiff()`는 **두 날짜 사이의 차이**를 특정 단위로 계산한다.

### 6.1 문법

```vbscript
DateDiff(interval, date1, date2 [, firstdayofweek [, firstweekofyear]])
```

주로 다음 세 파라미터를 사용한다.

```vbscript
DateDiff(interval, date1, date2)
```

### 6.2 파라미터

| 파라미터 | 의미 |
|---|---|
| `interval` | 어떤 단위로 차이를 계산할지 지정 |
| `date1` | 기준이 되는 첫 번째 날짜 |
| `date2` | 비교할 두 번째 날짜 |
| `firstdayofweek` | 선택값. 주의 시작 요일 지정 |
| `firstweekofyear` | 선택값. 연도의 첫 주 기준 지정 |

#### `firstdayofweek`에 사용할 수 있는 주요 값

| 상수 | 의미 |
|---|---|
| `vbUseSystem` | 시스템 설정 사용 |
| `vbSunday` | 일요일 |
| `vbMonday` | 월요일 |
| `vbTuesday` | 화요일 |
| `vbWednesday` | 수요일 |
| `vbThursday` | 목요일 |
| `vbFriday` | 금요일 |
| `vbSaturday` | 토요일 |

#### `firstweekofyear`에 사용할 수 있는 주요 값

| 상수 | 의미 |
|---|---|
| `vbUseSystem` | 시스템 설정 사용 |
| `vbFirstJan1` | 1월 1일이 포함된 주를 첫째 주로 사용 |
| `vbFirstFourDays` | 새해의 날짜가 4일 이상 포함된 주를 첫째 주로 사용 |
| `vbFirstFullWeek` | 새해에 완전히 포함된 첫 번째 주를 첫째 주로 사용 |

일수 차이처럼 주 단위 계산과 관계없는 경우에는 일반적으로 이 두 선택 파라미터를 생략한다.

### 6.3 반환값의 방향

기본 개념:

```text
date2 - date1
```

즉:

```vbscript
DateDiff("d", startDate, endDate)
```

에서 `endDate`가 더 나중 날짜면 양수가 나오고, 더 이전 날짜면 음수가 나올 수 있다.

---

### 6.4 `interval` 값

자주 사용하는 interval 값은 다음과 같다.

| 값 | 의미 |
|---|---|
| `"yyyy"` | 연도 |
| `"q"` | 분기 |
| `"m"` | 월 |
| `"y"` | 연중 일자 |
| `"d"` | 일 |
| `"w"` | 요일 |
| `"ww"` | 주 |
| `"h"` | 시간 |
| `"n"` | 분 |
| `"s"` | 초 |

!!! tip "분은 `m`이 아니라 `n`"
    `"m"`은 **Month(월)** 이다.

    Minute(분)는 `"n"`을 사용한다.

---

### 6.5 일수 계산

```vbscript
Option Explicit

Dim startDate
Dim endDate
Dim diffDays

startDate = CDate("2026-08-01")
endDate = CDate("2026-08-20")

diffDays = DateDiff("d", startDate, endDate)

WScript.Echo diffDays
```

결과:

```text
19
```

#### 종료일이 시작일보다 빠른지 확인

```vbscript
If DateDiff("d", startDate, endDate) < 0 Then

    MsgBox "종료일은 시작일보다 빠를 수 없습니다."
    Exit Sub

End If
```

의미:

```text
endDate가 startDate보다 이전
        ↓
DateDiff 결과 음수
        ↓
잘못된 조회기간으로 판단
```

---

### 6.6 월 차이

```vbscript
Dim monthDiff

monthDiff = DateDiff("m", CDate("2026-01-01"), CDate("2026-08-01"))

WScript.Echo monthDiff
```

결과:

```text
7
```

!!! note "`DateDiff()`의 의미"
    `DateDiff()`는 지정한 interval의 경계 차이를 계산하는 함수다.

    단순히 전체 초를 계산한 뒤 나눠서 정확한 실수 형태의 기간을 반환하는 함수라고 생각하면 안 된다.

---

## 7. `DateAdd()`

`DateAdd()`는 기준 날짜에 일정 기간을 더하거나 뺀 날짜를 반환한다.

### 7.1 문법

```vbscript
DateAdd(interval, number, date)
```

### 7.2 파라미터

| 파라미터 | 의미 |
|---|---|
| `interval` | 더하거나 뺄 날짜 단위 |
| `number` | 더할 값. 양수는 미래 방향, 음수는 과거 방향 |
| `date` | 기준 날짜 |

### 7.3 `number` 사용 예

예를 들어:

```text
DateAdd("d",  1, Date) → 오늘에서 하루 후
DateAdd("d", -1, Date) → 오늘에서 하루 전
DateAdd("m",  3, Date) → 오늘에서 3개월 후
DateAdd("m", -3, Date) → 오늘에서 3개월 전
```

`number`에 정수가 아닌 값이 들어오면 날짜 계산에 사용되기 전에 정수로 반올림될 수 있으므로, 일반적인 업무 코드에서는 날짜 단위 수를 정수로 명확하게 전달하는 편이 이해하기 쉽다.

---

### 7.4 `interval` 값

`DateDiff()`와 유사한 interval을 사용한다.

| 값 | 의미 |
|---|---|
| `"yyyy"` | 연도 |
| `"q"` | 분기 |
| `"m"` | 월 |
| `"y"` | 일 |
| `"d"` | 일 |
| `"ww"` | 주 |
| `"h"` | 시간 |
| `"n"` | 분 |
| `"s"` | 초 |

---

### 7.5 하루 빼기

```vbscript
Dim yesterday

yesterday = DateAdd("d", -1, Date)

WScript.Echo yesterday
```

파라미터를 풀어보면:

```text
"d"
→ 일 단위

-1
→ 하루 빼기

Date
→ 오늘 날짜
```

즉:

```text
오늘 - 1일
```

을 의미한다.

---

### 7.6 한 달 더하기

```vbscript
Dim nextMonth

nextMonth = DateAdd("m", 1, Date)

WScript.Echo nextMonth
```

파라미터:

```text
"m"
→ 월 단위

1
→ 한 달 더하기

Date
→ 오늘 날짜
```

---

### 7.7 한 달 빼기

```vbscript
Dim previousMonth

previousMonth = DateAdd("m", -1, Date)

WScript.Echo previousMonth
```

조회기간 기본값 설정 예:

```vbscript
startDate = DateAdd("m", -1, Date)
endDate = Date
```

---

### 7.8 시간과 분

한 시간 후:

```vbscript
WScript.Echo DateAdd("h", 1, Now)
```

30분 후:

```vbscript
WScript.Echo DateAdd("n", 30, Now)
```

주의:

```text
"h" → Hour
"n" → Minute
```

---

## 8. 날짜 구성요소 - `Year()`, `Month()`, `Day()`

날짜에서 연도, 월, 일을 각각 추출할 수 있다.

### 8.1 `Year()`

문법:

```vbscript
Year(date)
```

예:

```vbscript
Dim tradeDate
Dim y

tradeDate = CDate("2026-08-20")
y = Year(tradeDate)

WScript.Echo y
```

결과:

```text
2026
```

### 8.2 `Month()`

문법:

```vbscript
Month(date)
```

예:

```vbscript
m = Month(tradeDate)

WScript.Echo m
```

결과:

```text
8
```

### 8.3 `Day()`

문법:

```vbscript
Day(date)
```

예:

```vbscript
d = Day(tradeDate)

WScript.Echo d
```

결과:

```text
20
```

---

### 8.4 날짜 구성요소 한 번에 확인

```vbscript
Option Explicit

Dim tradeDate
Dim y
Dim m
Dim d

tradeDate = CDate("2026-08-20")

y = Year(tradeDate)
m = Month(tradeDate)
d = Day(tradeDate)

WScript.Echo "Year  = " & y
WScript.Echo "Month = " & m
WScript.Echo "Day   = " & d
```

결과:

```text
Year  = 2026
Month = 8
Day   = 20
```

---

## 9. 현재 날짜와 시간

### 9.1 `Date`

현재 날짜를 반환한다.

```vbscript
WScript.Echo Date
```

### 9.2 `Time`

현재 시간을 반환한다.

```vbscript
WScript.Echo Time
```

### 9.3 `Now`

현재 날짜와 시간을 함께 반환한다.

```vbscript
WScript.Echo Now
```

개념:

```text
Date
→ 날짜

Time
→ 시간

Now
→ 날짜 + 시간
```

---

## 10. 실무 입력 검증 예제

### 10.1 조회기간 검증 예제

실제 화면에서는 시작일과 종료일을 함께 검증하는 경우가 많다.

```vbscript
Option Explicit

Dim startDateText
Dim endDateText
Dim startDate
Dim endDate

startDateText = Trim(txtStartDate.Text)
endDateText = Trim(txtEndDate.Text)

If startDateText = "" Then

    MsgBox "시작일을 입력하세요."
    Exit Sub

End If

If endDateText = "" Then

    MsgBox "종료일을 입력하세요."
    Exit Sub

End If

If Not IsDate(startDateText) Then

    MsgBox "시작일 형식을 확인하세요."
    Exit Sub

End If

If Not IsDate(endDateText) Then

    MsgBox "종료일 형식을 확인하세요."
    Exit Sub

End If

startDate = CDate(startDateText)
endDate = CDate(endDateText)

If DateDiff("d", startDate, endDate) < 0 Then

    MsgBox "종료일은 시작일보다 빠를 수 없습니다."
    Exit Sub

End If
```

전체 흐름:

```text
시작일/종료일 문자열
        ↓
빈 값 확인
        ↓
IsDate()
        ↓
CDate()
        ↓
DateDiff()
        ↓
기간 정상 여부 판단
```

---

### 10.2 금액 입력 검증 예제

```vbscript
Option Explicit

Dim amountText
Dim amount

amountText = Trim(txtAmount.Text)

If amountText = "" Then

    MsgBox "금액을 입력하세요."
    Exit Sub

End If

amountText = Replace(amountText, ",", "")

If Not IsNumeric(amountText) Then

    MsgBox "금액은 숫자로 입력하세요."
    Exit Sub

End If

amount = CLng(amountText)

If amount < 0 Then

    MsgBox "금액은 0보다 작을 수 없습니다."
    Exit Sub

End If

WScript.Echo FormatNumber(amount, 0)
```

전체 흐름:

```text
화면 입력
   ↓
Trim
   ↓
빈 값 검사
   ↓
콤마 제거
   ↓
IsNumeric
   ↓
CLng
   ↓
업무 검증
   ↓
FormatNumber
   ↓
화면 표시
```

---

## 11. 요약

### 11.1 자주 사용하는 함수 요약

| 함수 | 목적 | 예 |
|---|---|---|
| `IsNumeric()` | 숫자 여부 검사 | `IsNumeric("100")` |
| `CInt()` | Integer 변환 | `CInt("100")` |
| `CLng()` | Long 변환 | `CLng("1000000")` |
| `CDbl()` | Double 변환 | `CDbl("12.5")` |
| `CCur()` | Currency 변환 | `CCur("1234.56")` |
| `FormatNumber()` | 숫자 표시 형식 | `FormatNumber(1234.5, 2)` |
| `IsDate()` | 날짜 여부 검사 | `IsDate("2026-08-20")` |
| `CDate()` | Date 변환 | `CDate("2026-08-20")` |
| `DateDiff()` | 날짜 차이 계산 | `DateDiff("d", d1, d2)` |
| `DateAdd()` | 날짜 더하기/빼기 | `DateAdd("m", 1, d)` |
| `Year()` | 연도 추출 | `Year(d)` |
| `Month()` | 월 추출 | `Month(d)` |
| `Day()` | 일 추출 | `Day(d)` |
| `Date` | 현재 날짜 | `Date` |
| `Time` | 현재 시간 | `Time` |
| `Now` | 현재 날짜/시간 | `Now` |

---

### 11.2 실무에서 기억할 핵심

#### 숫자

```text
문자열 입력
   ↓
Trim / Replace
   ↓
IsNumeric
   ↓
CLng / CDbl / CCur
   ↓
계산
   ↓
FormatNumber
   ↓
화면 표시
```

#### 날짜

```text
문자열 입력
   ↓
Trim
   ↓
IsDate
   ↓
CDate
   ↓
DateDiff / DateAdd
   ↓
비교 및 계산
```

!!! warning "자동 형변환에 지나치게 의존하지 않는다"
    VBScript는 여러 상황에서 자동 형변환을 수행한다.

    하지만 금융 화면에서는 입력값의 출처와 값의 상태가 다양하므로 **검증 → 명시적 변환 → 계산** 순서로 작성하는 것이 코드를 이해하고 오류를 예방하기 쉽다.

!!! tip "소스를 읽을 때"
    다음 형태의 코드가 보이면 하나의 처리 흐름으로 읽는다.

    ```vbscript
    If Not IsNull(value) Then
        If IsNumeric(value) Then
            amount = CLng(value)
        End If
    End If
    ```

    의미:

    ```text
    Null 여부 확인
        ↓
    숫자 변환 가능 여부 확인
        ↓
    Long 숫자로 명시적 변환
        ↓
    이후 계산에 사용
    ```

    함수 하나씩 따로 외우기보다 **입력값 검증과 형변환의 전체 흐름**을 함께 이해하는 것이 중요하다.

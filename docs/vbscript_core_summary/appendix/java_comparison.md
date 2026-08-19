# Java 개발자용 비교표

Java 경험자가 VBScript를 빠르게 읽기 위한 핵심 차이를 정리합니다.

| 개념 | Java | VBScript |
|---|---|---|
| 변수 선언 | `String name;` | `Dim name` |
| 문자열 연결 | `+` | `&` 권장 |
| 같음 | `==` | `=` |
| 다름 | `!=` | `<>` |
| 논리 AND | `&&` | `And` |
| 논리 OR | `||` | `Or` |
| 조건 블록 | `{ ... }` | `If ... End If` |
| 반복 | `for (...)` | `For ... Next` |
| 함수 반환 | `return value;` | `FunctionName = value` |
| 메서드형 프로시저 | `void` | `Sub` |
| 객체 할당 | 일반 `=` | `Set obj = ...` |
| null 개념 | `null` | `Null`, `Nothing`, `Empty` 구분 |
| 예외 처리 | `try/catch` | `On Error Resume Next`, `Err` |

## 가장 낯선 세 가지

### 1. Function 이름에 결과를 넣는다

```vb
Function Add(a, b)
    Add = a + b
End Function
```

### 2. 객체는 Set으로 할당한다

```vb
Set dict = CreateObject("Scripting.Dictionary")
```

### 3. 값 없음의 종류가 여러 개다

DB 값은 `Null`, 선언 후 미설정은 `Empty`, 객체 참조 없음은 `Nothing`을 의식해야 합니다.

!!! warning "Java식 단축평가 습관"
    `And`, `Or` 표현식에 Java의 `&&`, `||`와 동일한 단축평가를 기대해 Null 체크와 메서드 호출을 한 줄에 몰아넣지 않는 편이 안전합니다.

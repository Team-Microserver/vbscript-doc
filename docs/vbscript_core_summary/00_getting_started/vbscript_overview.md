# VBScript 이해하기

VBScript는 Visual Basic 계열 문법을 기반으로 한 스크립트 언어입니다. 변수 선언과 제어문이 비교적 단순하고, 객체를 사용할 수 있으며, Windows 환경의 자동화나 과거 웹/업무 시스템의 스크립팅 용도로 널리 사용되었습니다.

금융권의 오래된 화면 플랫폼에서는 브라우저의 일반적인 JavaScript 실행 환경과는 별개로, 제품 내부 스크립트 엔진을 통해 VBScript 문법을 사용하는 경우가 있습니다. 이런 환경에서는 언어 문법과 플랫폼 API를 분리해서 이해해야 합니다.

!!! important "언어와 플랫폼을 구분하기"
    `If`, `For`, `Function`, `Trim`, `CStr` 등은 VBScript 언어 기능입니다. 반면 `Grid.GetValue`, `DataSet.Send`, `Transaction()` 같은 형태의 함수가 있다면 대부분 특정 제품 또는 프로젝트가 제공하는 API일 가능성이 높습니다.

## VBScript 코드의 기본적인 모양

```vb
Option Explicit

Dim userName
userName = "Kim"

Sub ShowUser()
    MsgBox "사용자: " & userName
End Sub
```

Java와 비교하면 타입 선언이 보이지 않고, `{}` 대신 `End Sub`처럼 블록 종료 키워드를 사용합니다.

### 세미콜론이 없다

VBScript에서는 일반적으로 한 줄이 하나의 명령문입니다.

```vb
Dim amount
amount = 10000
```

### 문자열 연결은 `&`

```vb
message = "금액: " & amount & "원"
```

`+`도 일부 상황에서 동작할 수 있지만 숫자 덧셈과 문자열 연결의 의미가 섞일 수 있으므로 문자열 연결은 `&`를 사용하는 습관이 안전합니다.

!!! tip "실무 Tip"
    화면 메시지나 로그 문자열을 만들 때는 무조건 `&`를 사용한다고 생각하면 됩니다.

## Option Explicit의 중요성

`Option Explicit`를 사용하면 변수를 사용하기 전에 `Dim` 등으로 선언해야 합니다. 오타로 인해 새로운 변수가 암묵적으로 생성되는 문제를 줄일 수 있습니다.

```vb
Option Explicit

Dim customerName
customerName = "KIM"
```

반대로 아래처럼 오타가 있어도 `Option Explicit`가 없으면 문제를 찾기 어려울 수 있습니다.

```vb
customerName = "KIM"
customerNmae = "LEE"  ' 오타
```

!!! warning "레거시 코드 주의"
    기존 프로젝트에서 `Option Explicit`를 사용하지 않는다고 해서 새 코드까지 무조건 동일하게 작성해야 하는 것은 아닙니다. 다만 프로젝트 코딩 규칙과 실행환경의 제약을 먼저 확인해야 합니다.

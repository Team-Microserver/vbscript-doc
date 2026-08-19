# 변수와 상수

VBScript에서 변수는 값을 보관하는 이름입니다. Java의 `String name`, `int count`처럼 타입을 함께 선언하지 않고 `Dim` 키워드만 사용합니다.

## Dim을 이용한 변수 선언

```vb
Dim customerName
Dim accountNo
Dim balance
```

여러 변수를 한 줄에서 선언할 수도 있습니다.

```vb
Dim customerName, accountNo, balance
```

그러나 실무에서는 변수별 의미를 주석으로 남기기 쉽도록 중요한 변수는 줄을 나누는 것도 좋습니다.

## 값 할당

일반 값은 `=`로 할당합니다.

```vb
customerName = "김고객"
balance = 1500000
```

객체를 할당할 때는 `Set`이 필요합니다. 이것은 뒤의 객체 장에서 자세히 다룹니다.

```vb
Set dict = CreateObject("Scripting.Dictionary")
```

!!! warning "Set을 빼먹지 않기"
    일반 값 할당과 객체 참조 할당은 문법이 다릅니다. 객체를 다룰 때 `Set`을 빠뜨리는 것은 VBScript 초보자가 자주 만나는 오류 중 하나입니다.

## Option Explicit

`Option Explicit`를 파일 상단에 선언하면 사용되는 모든 변수를 미리 선언해야 합니다.

```vb
Option Explicit

Dim customerName
customerName = "KIM"
```

아래 코드는 변수명 오타입니다.

```vb
Dim customerName
customerName = "KIM"
customerNmae = "LEE"
```

`Option Explicit`가 없으면 `customerNmae`가 새로운 변수로 취급될 수 있어 오류를 찾기 어렵습니다.

!!! tip "실무 권장"
    신규 스크립트라면 특별한 제약이 없는 한 `Option Explicit`를 권장합니다. 다만 전용 개발도구가 스크립트를 조합하는 방식에 따라 파일 최상단 선언이 제약될 수 있으므로 프로젝트 표준을 우선 확인하세요.

## Const 상수

변하지 않는 값은 `Const`로 선언합니다.

```vb
Const STATUS_NORMAL = "N"
Const MAX_RETRY_COUNT = 3
```

상수는 코드 곳곳에 의미 없는 리터럴이 흩어지는 것을 줄여줍니다.

!!! example "의미 없는 값보다 상수 사용"
    나쁜 예:
    ```vb
    If status = "N" Then
        ' 처리
    End If
    ```

    개선 예:
    ```vb
    Const STATUS_NORMAL = "N"

    If status = STATUS_NORMAL Then
        ' 처리
    End If
    ```

금융 화면에서는 업무 상태코드, 거래구분, 처리구분처럼 코드값이 자주 등장합니다. 가능한 범위에서 이름을 부여하면 유지보수가 쉬워집니다.

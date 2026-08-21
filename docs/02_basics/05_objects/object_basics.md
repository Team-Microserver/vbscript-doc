# 객체와 Set

VBScript에서 객체를 다루는 문법은 일반 값과 다릅니다. 객체 참조를 변수에 넣을 때는 `Set`을 사용합니다.

## 일반 값과 객체의 차이

일반 값:

```vb
Dim name
name = "KIM"
```

객체:

```vb
Dim dict
Set dict = CreateObject("Scripting.Dictionary")
```

`Set`은 "이 변수에 객체의 참조를 연결한다"고 이해하면 됩니다.

## 속성과 메서드

객체는 속성(Property)과 메서드(Method)를 가질 수 있습니다.

```vb
dict.Add "A", "정상"
count = dict.Count
```

여기서 `Add`는 동작을 수행하는 메서드이고 `Count`는 상태 값을 제공하는 속성입니다.

## Nothing으로 참조 해제

```vb
Set dict = Nothing
```

현대 환경에서는 참조 해제를 매번 수동으로 해야만 메모리가 회수된다고 단순화해서 이해할 필요는 없지만, 레거시 코드에서는 객체 사용 종료를 명시하기 위해 흔히 볼 수 있습니다.

## 전용 UI 컨트롤도 객체처럼 보일 수 있다

실제 화면 플랫폼에서는 다음과 같은 형태를 볼 수 있습니다.

```vb
value = txtAccountNo.Text
Call grid.Clear()
```

정확한 API는 제품마다 다르지만 핵심은 같습니다. `txtAccountNo`, `grid`가 객체 또는 객체와 유사한 컨트롤 참조이고, `.Text`, `.Clear` 등을 통해 속성과 동작에 접근합니다.

!!! tip "낯선 객체를 분석하는 법"
    객체명을 발견하면 먼저 같은 프로젝트에서 `객체명.`으로 검색해보세요. 어떤 속성과 메서드가 실제로 사용되는지 확인하는 것이 문서 없이 API를 파악하는 가장 빠른 방법 중 하나입니다.

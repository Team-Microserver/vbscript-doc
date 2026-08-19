# 매개변수와 ByRef / ByVal

VBScript에서 프로시저와 함수의 매개변수는 기본적으로 참조 전달의 영향을 받을 수 있습니다. 특히 기존 코드에서 함수 호출 후 원래 변수 값이 바뀌는 경우가 있다면 `ByRef`와 `ByVal`을 확인해야 합니다.

## ByVal

`ByVal`은 호출한 쪽의 원본 값 자체를 직접 변경하지 않도록 값을 전달하는 의도를 나타냅니다.

```vb
Sub Increase(ByVal value)
    value = value + 1
End Sub

Dim count
count = 10
Call Increase(count)

' count는 10
```

## ByRef

`ByRef`는 전달받은 변수를 프로시저 내부에서 변경하면 호출한 쪽에도 영향을 줄 수 있습니다.

```vb
Sub Increase(ByRef value)
    value = value + 1
End Sub

Dim count
count = 10
Call Increase(count)

' count는 11
```

!!! warning "숨은 변경을 주의"
    `ByRef`를 사용하면 함수 이름만 보고는 원본 값이 변경되는지 알기 어렵습니다. 출력 매개변수처럼 의도적으로 값을 변경해야 하는 경우가 아니라면 `ByVal`을 명시하는 편이 코드 이해에 도움이 됩니다.

## 여러 값을 반환하는 레거시 패턴

VBScript에서는 객체나 배열을 사용하지 않고 `ByRef` 매개변수 여러 개를 이용해 결과를 돌려주는 오래된 코드가 있을 수 있습니다.

```vb
Sub GetCustomerInfo(ByVal customerNo, ByRef customerName, ByRef grade)
    customerName = "김고객"
    grade = "A"
End Sub
```

호출하는 쪽은 다음처럼 결과를 받습니다.

```vb
Dim name, grade
Call GetCustomerInfo("1001", name, grade)
```

이 패턴을 만나면 `name`, `grade`가 입력값이 아니라 사실상 출력값이라는 것을 인지해야 합니다.

## 함수 매개변수 읽는 방법

처음 보는 함수가 있다면 다음 순서로 확인하세요.

1. 어떤 값이 입력되는가
2. `ByVal`인가 `ByRef`인가
3. 내부에서 매개변수에 다시 값을 할당하는가
4. 함수 자체의 반환값도 존재하는가

!!! tip "리팩터링보다 우선할 것"
    레거시 금융 프로젝트에서는 먼저 기존 호출 관계와 부작용을 정확히 이해해야 합니다. 스타일이 마음에 들지 않는다는 이유만으로 `ByRef`를 `ByVal`로 바꾸면 기존 동작이 달라질 수 있습니다.

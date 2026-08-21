# 자주 만나는 오류

VBScript 초보자가 자주 만나는 문제는 문법 오류보다 값 상태와 객체 처리에서 더 많이 발생합니다.

## Object required

객체가 필요한 위치에 일반 값이 있거나 객체가 설정되지 않은 경우를 의심합니다.

```vb
Dim dict
dict.Add "A", "B"   ' Set으로 객체를 만들지 않음
```

## Type mismatch

숫자로 계산할 수 없는 문자열, Null 변환 등 타입이 맞지 않을 때 발생할 수 있습니다.

```vb
amount = CLng("10A")
```

해결할 때는 `IsNumeric`, `IsDate`, `IsNull` 등을 이용해 입력 상태를 먼저 확인합니다.

## Subscript out of range

배열의 범위를 벗어난 인덱스 접근 등을 확인합니다.

```vb
Dim arr(2)
value = arr(3)
```

## Object doesn't support this property or method

객체가 해당 속성/메서드를 제공하지 않거나 잘못된 객체를 참조했을 수 있습니다. 전용 UI 플랫폼에서는 컨트롤 종류에 따라 지원 API가 다를 수 있습니다.

## 오류가 안 보이는데 동작이 이상하다

가장 먼저 `On Error Resume Next`가 넓은 범위에 걸려 있는지 확인하세요.

!!! danger "숨겨진 오류"
    `On Error Resume Next` 때문에 실제 오류가 무시된 뒤 빈 값이나 이전 값으로 후속 로직이 실행되는 경우가 있습니다. 오류 발생 의심 지점에서 `Err.Number`와 `Err.Description`을 확인하세요.

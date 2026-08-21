# 배열과 반복 처리

VBScript 배열은 여러 값을 순서대로 보관할 때 사용합니다. 화면에서 코드 목록을 관리하거나 문자열을 분리한 결과를 처리할 때 자주 볼 수 있습니다.

## 고정 크기 배열

```vb
Dim accounts(2)
accounts(0) = "111"
accounts(1) = "222"
accounts(2) = "333"
```

괄호 안의 숫자는 요소 개수가 아니라 **마지막 인덱스**입니다. 따라서 `Dim accounts(2)`는 0, 1, 2 총 세 개의 요소를 가집니다.

!!! warning "Java 개발자가 자주 헷갈리는 부분"
    Java의 `new String[2]`는 2개지만 VBScript의 `Dim arr(2)`는 3개입니다.

## UBound와 LBound

배열의 마지막/첫 인덱스를 얻습니다.

```vb
For i = LBound(accounts) To UBound(accounts)
    MsgBox accounts(i)
Next
```

하드코딩한 숫자보다 `LBound`, `UBound`를 사용하는 것이 안전합니다.

## 동적 배열과 ReDim

처음에 크기를 정하지 않고 나중에 지정할 수 있습니다.

```vb
Dim accounts()
ReDim accounts(4)
```

`ReDim Preserve`를 사용하면 기존 값을 유지하면서 크기를 변경할 수 있습니다.

```vb
ReDim Preserve accounts(9)
```

단, 다차원 배열에서는 `Preserve` 사용에 제약이 있으므로 복잡한 데이터 구조는 Dictionary나 플랫폼 데이터셋 사용을 검토하는 편이 좋습니다.

## Split 결과도 배열

```vb
Dim values
values = Split("A|B|C", "|")

For i = LBound(values) To UBound(values)
    MsgBox values(i)
Next
```

문자열 기반 프로토콜이나 코드 목록을 다룰 때 매우 자주 등장하는 패턴입니다.

# 단계별 실습

실습은 문법 문제를 많이 푸는 것보다 **실제 화면 코드와 비슷한 작은 문제를 반복해서 작성하는 방식**으로 구성했습니다. 각 문제는 정답을 바로 외우기보다 먼저 직접 작성한 뒤 예시 답안과 비교하는 것을 권장합니다.

## 권장 순서

1. 변수와 문자열
2. 조건문과 검증
3. 반복문과 배열
4. Sub / Function
5. Null / 형 변환
6. 이벤트 패턴
7. 조회/저장 흐름
8. 기존 코드 읽기

!!! tip "실습 규칙"
    예제를 복사해 실행하는 것보다 변수명이나 조건을 바꿔 직접 다시 작성해보세요. `왜 Exit Sub를 사용하는가`, `왜 IsNumeric을 먼저 호출하는가`를 설명할 수 있어야 실제 업무 코드에 적용할 수 있습니다.

## 완료 기준

다음 코드를 보고 각 줄의 역할을 설명하고 비슷한 검증 함수를 직접 작성할 수 있다면 기초 단계는 충분합니다.

```vb
Function ValidateAmount(ByVal amountText)
    Dim value
    ValidateAmount = False

    value = Replace(Trim(amountText), ",", "")

    If value = "" Then Exit Function
    If Not IsNumeric(value) Then Exit Function
    If CDbl(value) <= 0 Then Exit Function

    ValidateAmount = True
End Function
```

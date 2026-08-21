# VBScript 오류 처리

VBScript의 대표적인 오류 처리 방식은 `On Error Resume Next`와 `Err` 객체를 이용하는 것입니다. Java의 `try-catch`와 구조가 다르므로 반드시 별도로 익혀야 합니다.

## On Error Resume Next

```vb
On Error Resume Next

result = 10 / 0

If Err.Number <> 0 Then
    MsgBox "오류: " & Err.Description
    Err.Clear
End If
```

`On Error Resume Next`는 오류가 발생해도 다음 문장으로 계속 진행하도록 합니다. 따라서 오류를 무시하는 기능이 아니라 **오류를 직접 확인하고 처리하겠다는 선언**에 가깝게 사용해야 합니다.

!!! danger "가장 위험한 사용법"
    파일 상단이나 긴 함수의 시작에서 `On Error Resume Next`만 선언하고 `Err.Number`를 확인하지 않는 것입니다. 실제 오류가 발생해도 코드가 계속 실행되면서 잘못된 상태가 뒤로 전파될 수 있습니다.

## Err 객체

주요 정보는 다음과 같습니다.

```vb
Err.Number
Err.Description
Err.Source
```

오류를 처리한 뒤에는 `Err.Clear`로 상태를 정리할 수 있습니다.

## On Error GoTo 0

오류 무시/직접 처리 모드를 종료하고 기본 오류 처리로 되돌리는 데 사용합니다.

```vb
On Error Resume Next
Call RiskyOperation()

If Err.Number <> 0 Then
    ' 오류 처리
    Err.Clear
End If

On Error GoTo 0
```

!!! tip "범위를 작게 유지"
    오류 가능성이 있는 몇 줄만 `On Error Resume Next`로 감싸고 가능한 빨리 `On Error GoTo 0`으로 복원하는 방식이 안전합니다.

## 오류를 다시 발생시키기

업무 함수에서 오류를 감지하고 호출자에게 전달해야 한다면 `Err.Raise`를 사용할 수 있습니다.

```vb
If amount < 0 Then
    Err.Raise 1001, "ValidateAmount", "금액은 0보다 작을 수 없습니다."
End If
```

프로젝트에 공통 오류처리 프레임워크가 있다면 임의 번호를 사용하기보다 해당 규칙을 따릅니다.

# Null, Empty, Nothing

VBScript를 실무에서 사용할 때 반드시 이해해야 하는 주제입니다. 세 단어 모두 '값이 없다'는 느낌을 주지만 의미와 검사 방법이 서로 다릅니다.

## Empty

`Dim`으로 변수를 선언한 뒤 아직 명시적인 값을 넣지 않은 상태를 생각하면 이해하기 쉽습니다.

```vb
Dim value

If IsEmpty(value) Then
    MsgBox "값이 아직 할당되지 않았습니다."
End If
```

## Null

`Null`은 유효한 데이터가 없다는 의미의 특별한 값입니다. 데이터베이스 컬럼의 NULL 값이 스크립트로 넘어오는 상황에서 흔히 볼 수 있습니다.

```vb
If IsNull(customerName) Then
    customerName = ""
End If
```

`Null`이 연산에 섞이면 결과도 `Null`이 되는 경우가 많아 조심해야 합니다.

```vb
result = Null & "ABC"
```

이런 표현식에 의존하기보다 `IsNull`로 먼저 처리하는 것이 안전합니다.

## 빈 문자열

```vb
value = ""
```

빈 문자열은 정상적인 문자열 값이며 `Null`이나 `Empty`와 다릅니다.

## Nothing

`Nothing`은 객체 참조가 없는 상태입니다.

```vb
Dim dict
Set dict = CreateObject("Scripting.Dictionary")

Set dict = Nothing
```

객체 여부는 일반 문자열처럼 비교하지 않습니다.

!!! important "구분 요약"
    - `Empty` : Variant에 아직 의미 있는 값이 설정되지 않은 상태
    - `Null` : 데이터가 존재하지 않음을 나타내는 특별한 값
    - `""` : 길이가 0인 문자열
    - `Nothing` : 객체 참조가 없음

## 안전한 문자열 변환 함수 예시

프로젝트에서 Null이 자주 들어온다면 작은 공통 함수를 사용할 수 있습니다.

!!! example "Null을 빈 문자열로 변환"
    ```vb
    Function NzString(ByVal value)
        If IsNull(value) Or IsEmpty(value) Then
            NzString = ""
        Else
            NzString = CStr(value)
        End If
    End Function
    ```

단, `Null`과 빈 문자열이 업무적으로 다른 의미를 가지는 경우에는 무조건 합쳐서는 안 됩니다. 예를 들어 DB 업데이트에서 `NULL 유지`와 `빈 문자열 저장`이 다를 수 있습니다.

!!! warning "업무 의미를 먼저 확인"
    Null 처리 함수는 편리하지만 데이터의 의미를 바꿀 수 있습니다. 화면 표시 목적과 서버 전송 목적을 구분하세요.

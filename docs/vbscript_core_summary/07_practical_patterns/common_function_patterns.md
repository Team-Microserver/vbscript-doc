# 공통 함수 설계

공통 함수는 중복 제거에 도움이 되지만, 너무 많은 기능을 숨기면 오히려 소스 추적이 어려워집니다. 특히 레거시 화면에서는 `gfn`, `fn`, `util` 같은 접두어를 가진 공통 함수가 대량으로 존재할 수 있으므로 역할을 분류해야 합니다.

## 공통화하기 좋은 기능

- Null/문자열 정규화
- 금액 표시 형식
- 날짜 형식 변환
- 공통 메시지
- 코드명 조회
- 반복되는 기본 검증
- 로그 출력 래퍼

## 너무 업무적인 로직은 공통화에 신중

예를 들어 특정 상품의 거래 가능 여부처럼 업무 규칙이 자주 바뀌는 로직을 범용 유틸리티에 넣으면 의존성이 커집니다.

## 작은 함수 예시

```vb
Function SafeText(ByVal value)
    If IsNull(value) Or IsEmpty(value) Then
        SafeText = ""
    Else
        SafeText = Trim(CStr(value))
    End If
End Function
```

```vb
Function IsBlank(ByVal value)
    If IsNull(value) Or IsEmpty(value) Then
        IsBlank = True
    Else
        IsBlank = (Trim(CStr(value)) = "")
    End If
End Function
```

!!! warning "공통 함수의 의미를 먼저 확인"
    기존 프로젝트에 `IsEmptyValue`, `NVL`, `NullToBlank` 같은 함수가 있다면 새 함수를 만들기 전에 정확한 동작을 확인하세요. 이름은 비슷해도 Null, 숫자 0, 빈 문자열을 처리하는 기준이 다를 수 있습니다.

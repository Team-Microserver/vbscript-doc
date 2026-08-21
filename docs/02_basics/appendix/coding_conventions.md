# 코딩 규칙 권장안

실제 프로젝트에 공식 코딩 규칙이 있다면 그 규칙이 최우선입니다. 아래 내용은 별도 표준이 없을 때 학습 및 신규 코드에 적용할 수 있는 권장안입니다.

## 변수명은 역할이 보이게

```vb
Dim accountNo
Dim customerName
Dim totalAmount
```

`a`, `tmp1`, `data2`처럼 의미가 약한 이름은 짧은 반복문 인덱스를 제외하면 피합니다.

## Boolean은 질문처럼

```vb
Dim isValid
Dim hasError
Dim canSave
```

## 함수는 동사 중심

```text
ValidateInput
BuildRequest
LoadCommonCode
BindResult
CalculateTotalAmount
```

## 이벤트 함수는 짧게

```vb
Sub btnSearch_Click()
    If Not ValidateSearch() Then Exit Sub
    Call DoSearch()
End Sub
```

## 매직값 줄이기

```vb
Const STATUS_COMPLETE = "03"
```

## 오류 무시 범위 최소화

```vb
On Error Resume Next
Call RiskyOperation()

If Err.Number <> 0 Then
    Call HandleError(Err.Number, Err.Description)
    Err.Clear
End If
On Error GoTo 0
```

!!! warning "레거시 코드의 대규모 정리"
    금융 시스템 유지보수에서는 스타일 개선보다 동작 안정성이 우선입니다. 업무 수정과 무관한 대규모 리팩터링은 영향도와 테스트 범위를 늘릴 수 있으므로 별도 계획 없이 섞지 않는 것이 좋습니다.

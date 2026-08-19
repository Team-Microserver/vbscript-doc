# 금융 화면 실전 실습

이 장은 실제 제품 API가 아니라 화면 개발의 논리 구조를 연습하기 위한 예제입니다.

## 실습 1. 조회 조건 검증

요구사항은 다음과 같습니다.

- 계좌번호는 필수
- 시작일/종료일은 날짜여야 함
- 종료일은 시작일보다 빠를 수 없음

!!! example "예시 답안"
    ```vb
    Function ValidateSearch(ByVal accountNo, ByVal startText, ByVal endText)
        Dim startDate, endDate
        ValidateSearch = False

        If Trim(accountNo) = "" Then Exit Function
        If Not IsDate(startText) Then Exit Function
        If Not IsDate(endText) Then Exit Function

        startDate = CDate(startText)
        endDate = CDate(endText)

        If DateDiff("d", startDate, endDate) < 0 Then Exit Function

        ValidateSearch = True
    End Function
    ```

## 실습 2. 선택 행 금액 합계

플랫폼 API 대신 배열 두 개를 사용해 선택 여부와 금액을 표현합니다.

```vb
Function SumSelected(ByVal selected, ByVal amounts)
    Dim i, total
    total = 0

    For i = LBound(amounts) To UBound(amounts)
        If selected(i) = True Then
            If IsNumeric(amounts(i)) Then
                total = total + CDbl(amounts(i))
            End If
        End If
    Next

    SumSelected = total
End Function
```

이 패턴을 실제 프로젝트에서는 `grid.GetValue(row, ...)` 같은 프로젝트 전용 API로 바꾸게 됩니다.

## 실습 3. 저장 이벤트 설계

```vb
Sub btnSave_Click()
    If Not ValidateSaveData() Then
        Exit Sub
    End If

    If Not ConfirmSave() Then
        Exit Sub
    End If

    Call BuildSaveRequest()
    Call RequestSave()
End Sub
```

!!! tip "핵심"
    실습의 목적은 위 함수명을 외우는 것이 아니라 이벤트 안에 검증, 확인, 요청구성, 서버호출의 단계가 분리되어 있다는 구조를 익히는 것입니다.

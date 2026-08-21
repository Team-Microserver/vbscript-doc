# 화면 이벤트 패턴

전용 화면 플랫폼의 이벤트명과 컨트롤 API는 다를 수 있지만, 이벤트 기반 화면 로직의 구조는 대부분 비슷합니다. 화면 로딩, 버튼 클릭, 값 변경, 행 선택 같은 이벤트를 시작점으로 업무 함수가 호출됩니다.

## 화면 초기화

```vb
Sub Form_Load()
    Call InitScreen()
    Call LoadCommonCode()
End Sub
```

초기화 이벤트 안에 모든 코드를 직접 작성하기보다 역할별 함수로 분리하면 좋습니다.

## 조회 버튼

```vb
Sub btnSearch_Click()
    If Not ValidateSearchCondition() Then
        Exit Sub
    End If

    Call DoSearch()
End Sub
```

## 저장 버튼

```vb
Sub btnSave_Click()
    If Not ValidateSaveData() Then
        Exit Sub
    End If

    If MsgBox("저장하시겠습니까?", vbYesNo) <> vbYes Then
        Exit Sub
    End If

    Call DoSave()
End Sub
```

실제 플랫폼에서는 메시지 함수가 별도 공통 함수로 제공될 수 있습니다.

## 값 변경 이벤트

값 변경 이벤트에서 서버 호출을 즉시 수행하면 사용자가 입력하는 동안 불필요한 요청이 발생할 수 있습니다. 이벤트의 빈도와 호출 비용을 고려해야 합니다.

!!! warning "이벤트 재진입"
    값 변경 이벤트 안에서 다시 같은 컨트롤 값을 변경하면 플랫폼에 따라 이벤트가 연속해서 발생할 수 있습니다. 기존 화면이 이벤트 플래그를 사용하는지 확인하세요.

## 이벤트에서 해야 할 일과 하지 말아야 할 일

이벤트 함수는 다음 흐름이 읽히는 정도가 좋습니다.

```text
사용자 동작
  → 검증
  → 확인
  → 업무 함수 호출
  → 후처리
```

!!! example "이벤트는 얇게"
    ```vb
    Sub btnDelete_Click()
        If Not CanDelete() Then Exit Sub
        If Not ConfirmDelete() Then Exit Sub
        Call DeleteSelectedRows()
    End Sub
    ```

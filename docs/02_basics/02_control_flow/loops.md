# 반복문

반복문은 그리드 행 처리, 배열 순회, 코드 목록 검사, 합계 계산 등에 사용됩니다.

## For ... Next

반복 횟수가 명확할 때 사용합니다.

```vb
Dim i
For i = 1 To 5
    MsgBox i
Next
```

증가 폭은 `Step`으로 지정합니다.

```vb
For i = 10 To 1 Step -1
    ' 역순 처리
Next
```

## For Each ... Next

컬렉션이나 객체 목록을 순회할 때 사용합니다.

```vb
Dim key
For Each key In dict.Keys
    MsgBox key & "=" & dict(key)
Next
```

## Do While ... Loop

조건이 참인 동안 반복합니다.

```vb
Do While index < count
    index = index + 1
Loop
```

## Do Until ... Loop

조건이 참이 될 때까지 반복합니다.

```vb
Do Until isFinished
    ' 처리
Loop
```

## Exit For / Exit Do

원하는 값을 찾았거나 더 이상 반복할 필요가 없으면 중간에 종료할 수 있습니다.

```vb
For i = 0 To UBound(accounts)
    If accounts(i) = targetAccount Then
        found = True
        Exit For
    End If
Next
```

!!! warning "무한 반복 주의"
    `Do While`, `Do Until` 내부에서는 종료 조건에 영향을 주는 값이 실제로 변경되는지 반드시 확인하세요.

## 화면 행 처리 패턴

전용 UI 플랫폼의 그리드 API는 프로젝트마다 다르지만 논리 구조는 비슷합니다.

```vb
For row = 0 To rowCount - 1
    ' 1. 행의 선택 여부 확인
    ' 2. 필요한 값 읽기
    ' 3. 값 검증 또는 요청 데이터 생성
Next
```

!!! tip "그리드 루프를 읽을 때"
    반복문 자체보다 `row`를 사용해 어떤 컬럼을 읽고, 그 값이 어디로 전달되는지를 추적하세요. 플랫폼 API 이름을 몰라도 업무 흐름을 먼저 파악할 수 있습니다.

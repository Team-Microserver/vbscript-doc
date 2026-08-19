# Dictionary와 컬렉션 패턴

키와 값의 쌍으로 데이터를 관리해야 할 때 `Scripting.Dictionary`를 자주 사용할 수 있습니다. 다만 전용 화면 플랫폼이 자체 Map/Collection 객체를 제공한다면 프로젝트 표준을 우선해야 합니다.

## Dictionary 생성

```vb
Dim dict
Set dict = CreateObject("Scripting.Dictionary")
```

## 값 추가와 조회

```vb
dict.Add "A", "정상"
dict.Add "E", "오류"

MsgBox dict("A")
```

## Exists

키가 있는지 확인합니다.

```vb
If dict.Exists(status) Then
    statusName = dict(status)
Else
    statusName = "알 수 없음"
End If
```

!!! example "코드명 변환"
    ```vb
    Function GetStatusName(ByVal status)
        Dim statusMap
        Set statusMap = CreateObject("Scripting.Dictionary")

        statusMap.Add "01", "접수"
        statusMap.Add "02", "처리중"
        statusMap.Add "03", "완료"

        If statusMap.Exists(status) Then
            GetStatusName = statusMap(status)
        Else
            GetStatusName = "기타"
        End If

        Set statusMap = Nothing
    End Function
    ```

## Keys 순회

```vb
Dim key
For Each key In dict.Keys
    MsgBox key & ": " & dict(key)
Next
```

## 언제 사용하면 좋은가

- 코드값과 표시명을 대응시킬 때
- 임시 속성 묶음을 만들 때
- 중복 여부를 빠르게 확인할 때
- 단순한 Key/Value 설정을 관리할 때

!!! warning "무조건 Dictionary로 바꾸지 않기"
    프로젝트 프레임워크의 데이터셋이나 전송 객체가 있다면 Dictionary를 거쳐 다시 변환하는 것이 오히려 복잡할 수 있습니다. 플랫폼이 제공하는 표준 데이터 구조를 먼저 확인하세요.

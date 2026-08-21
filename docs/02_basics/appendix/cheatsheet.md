# 자주 쓰는 함수 치트시트

## 문자열

| 함수 | 용도 | 예시 |
|---|---|---|
| `Trim` | 앞뒤 공백 제거 | `Trim(value)` |
| `Len` | 문자열 길이 | `Len(value)` |
| `Left` | 왼쪽 일부 추출 | `Left(value, 3)` |
| `Right` | 오른쪽 일부 추출 | `Right(value, 3)` |
| `Mid` | 중간 문자열 추출 | `Mid(value, 2, 4)` |
| `Replace` | 문자열 치환 | `Replace(value, "-", "")` |
| `InStr` | 포함 위치 검색 | `InStr(value, "A")` |
| `Split` | 문자열→배열 | `Split(value, ",")` |
| `Join` | 배열→문자열 | `Join(arr, ",")` |
| `UCase` | 대문자 변환 | `UCase(value)` |
| `LCase` | 소문자 변환 | `LCase(value)` |

## 값 상태/변환

| 함수 | 용도 |
|---|---|
| `IsNull` | Null 여부 |
| `IsEmpty` | Empty 여부 |
| `IsNumeric` | 숫자 변환 가능 여부 |
| `IsDate` | 날짜 변환 가능 여부 |
| `CStr` | 문자열 변환 |
| `CLng` | Long 변환 |
| `CDbl` | Double 변환 |
| `CDate` | Date 변환 |
| `TypeName` | 값 타입 이름 확인 |

## 날짜

| 함수 | 용도 |
|---|---|
| `Date` | 현재 날짜 |
| `Now` | 현재 날짜/시간 |
| `DateAdd` | 날짜 더하기/빼기 |
| `DateDiff` | 날짜 차이 |
| `Year` | 연도 |
| `Month` | 월 |
| `Day` | 일 |

## 배열

| 함수/키워드 | 용도 |
|---|---|
| `Array(...)` | 배열 생성 |
| `LBound` | 최소 인덱스 |
| `UBound` | 최대 인덱스 |
| `ReDim` | 배열 크기 재설정 |
| `ReDim Preserve` | 기존 값 유지하며 크기 변경 |

!!! tip "외우지 말고 자주 찾아보기"
    실무에서 한두 주 반복해 사용하면 자연스럽게 기억됩니다. 처음부터 모든 함수의 인자를 외우는 것보다 어떤 함수가 존재하는지 아는 것이 중요합니다.

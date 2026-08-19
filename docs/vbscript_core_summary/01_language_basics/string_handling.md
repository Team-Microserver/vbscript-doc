# 문자열 처리

화면 개발에서 가장 자주 다루는 값은 문자열입니다. 계좌번호, 고객명, 코드, 날짜 입력값, 서버 응답값 대부분이 화면 컨트롤을 거칠 때 문자열 형태로 다뤄지는 경우가 많습니다.

## Trim, LTrim, RTrim

사용자 입력 앞뒤의 불필요한 공백을 제거할 때 `Trim`을 사용합니다.

```vb
accountNo = Trim(txtAccountNo.Text)
```

입력값 검증을 할 때는 원본 값을 바로 비교하기보다 `Trim`한 값을 기준으로 판단하는 편이 안전합니다.

!!! example "필수 입력값 검증"
    ```vb
    customerName = Trim(txtCustomerName.Text)

    If customerName = "" Then
        MsgBox "고객명을 입력하세요."
        Exit Sub
    End If
    ```

## Len

문자열 길이를 확인합니다.

```vb
If Len(accountNo) <> 10 Then
    MsgBox "계좌번호 길이를 확인하세요."
End If
```

## Left, Right, Mid

문자열 일부를 추출합니다.

```vb
Left("ABCDEFG", 3)     ' ABC
Right("ABCDEFG", 3)    ' EFG
Mid("ABCDEFG", 3, 2)   ' CD
```

업무코드의 접두어/접미어를 확인하거나 고정 포맷 데이터를 분리할 때 자주 쓰입니다.

## InStr

문자열 안에서 특정 문자열의 위치를 찾습니다.

```vb
If InStr(accountNo, "-") > 0 Then
    accountNo = Replace(accountNo, "-", "")
End If
```

## Replace

문자열 일부를 치환합니다.

```vb
phoneNo = Replace(phoneNo, "-", "")
```

## UCase, LCase

대소문자를 통일해 비교할 때 사용합니다.

```vb
If UCase(status) = "ACTIVE" Then
    ' ...
End If
```

## Split과 Join

구분자로 문자열을 나누거나 배열을 다시 문자열로 합칩니다.

```vb
Dim codes
codes = Split("A,B,C", ",")

MsgBox codes(0)  ' A
```

```vb
result = Join(codes, "|")
```

!!! tip "입력값 정규화"
    검증하기 전에 `Trim`, `Replace`, `UCase` 등을 이용해 입력 형식을 정규화하면 조건문이 단순해집니다. 단, 원본 입력값을 보존해야 하는 업무라면 별도 변수에 정규화 결과를 저장하세요.

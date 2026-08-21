# DO · DOF · QO

## 1. DO 개발 흐름

```text
Meta 등록
 ↓
DataObject 생성
 ↓
Meta Field 추가
 ↓
Message 설정
 ↓
Java Source Generation
```

---

## 2. Input / Output DO

서비스는 일반적으로 Input과 Output 데이터 구조를 가집니다.

```text
CustomerSearchInDO
 └─ customerNo

CustomerSearchOutDO
 ├─ customerNo
 ├─ customerName
 └─ customerStatus
```

---

## 3. DB DOF

DB DOF에서는 SQL과 Parameter/Result Mapping을 정의합니다.

예:

```sql
SELECT CUSTOMER_NO,
       CUSTOMER_NAME,
       CUSTOMER_STATUS
  FROM TB_CUSTOMER
 WHERE CUSTOMER_NO = :customerNo
```

입력:

```text
customerNo
    ↓
:customerNo
```

결과:

```text
CUSTOMER_NO     → customerNo
CUSTOMER_NAME   → customerName
CUSTOMER_STATUS → customerStatus
```

---

## 4. CRUD

```sql
-- 조회
SELECT *
  FROM TB_ACCOUNT
 WHERE ACCOUNT_NO = :accountNo;
```

```sql
-- 등록
INSERT INTO TB_ACCOUNT (
    ACCOUNT_NO,
    CUSTOMER_NO,
    STATUS
) VALUES (
    :accountNo,
    :customerNo,
    :status
);
```

```sql
-- 수정
UPDATE TB_ACCOUNT
   SET STATUS = :status
 WHERE ACCOUNT_NO = :accountNo;
```

```sql
-- 삭제
DELETE FROM TB_ACCOUNT
 WHERE ACCOUNT_NO = :accountNo;
```

---

## 5. 데이터 계층 분석 포인트

```text
어떤 DO를 사용하는가?
어떤 Datasource인가?
SQL은 무엇인가?
Bind Parameter는 무엇인가?
단건인가 다건인가?
Result가 어디에 Mapping되는가?
Transaction에 포함되는가?
```

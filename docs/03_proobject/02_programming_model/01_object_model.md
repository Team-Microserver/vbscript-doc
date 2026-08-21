# 객체 모델

## 1. 핵심 객체

```text
DO  : 데이터
DOF : DB/File 접근
QO  : Query
BO  : 업무 기능
SO  : 서비스 흐름
JO  : 배치
```

---

## 2. DO

Data Object는 ProObject 모듈 간 데이터 전달의 기본 단위이며 SO의 입출력 형식으로 사용됩니다.

개념적인 생성 Java:

```java
public class CustomerDO {

    private String customerNo;
    private String customerName;

    public String getCustomerNo() {
        return customerNo;
    }

    public void setCustomerNo(String customerNo) {
        this.customerNo = customerNo;
    }
}
```

실제 생성 클래스는 ProObject가 제공하는 기반 클래스와 메타 구조를 사용하므로 프로젝트의 Generated Source를 확인합니다.

---

## 3. DOF

Data Object Factory는 DB 또는 File I/O를 담당합니다.

```text
DB DOF
File DOF
```

DB DOF:

```sql
SELECT CUSTOMER_NO,
       CUSTOMER_NAME
  FROM TB_CUSTOMER
 WHERE CUSTOMER_NO = :customerNo
```

---

## 4. QO

Query Object는 DB Query를 수행하는 객체입니다.

프로젝트가 DOF와 QO를 어떤 기준으로 사용하는지는 프로젝트 개발 표준을 확인해야 합니다.

---

## 5. BO

Biz Object는 재사용 가능한 업무 기능입니다.

개념 예:

```java
public CustomerDO searchCustomer(String customerNo) {

    CustomerDO customer = customerDOF.selectCustomer(customerNo);

    if (customer == null) {
        throw new RuntimeException("고객 정보가 없습니다.");
    }

    return customer;
}
```

---

## 6. SO

Service Object는 BO를 Orchestration하여 서비스의 실행 Flow를 구성합니다.

```text
Input
 ↓
Validation BO
 ↓
Search BO
 ↓
Output
```

---

## 7. JO

Job Object는 배치 실행 단위입니다.

```text
Scheduler
 ↓
JO
 ↓
Task
 ↓
BO
 ↓
DOF
```

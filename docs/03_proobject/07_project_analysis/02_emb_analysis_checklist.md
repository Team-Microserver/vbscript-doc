# EMB 분석 체크리스트

EMB 화면을 처음 열었을 때 아래 순서로 확인합니다.

## 1. 기본 정보

- [ ] SO인가 BO(Design)인가?
- [ ] Object 이름은?
- [ ] Method는?
- [ ] Input DO는?
- [ ] Output DO는?

---

## 2. 전체 Flow

- [ ] Start와 End 확인
- [ ] 주요 Node 수 확인
- [ ] 큰 분기 확인
- [ ] Loop 확인
- [ ] 다른 SO 호출 확인

---

## 3. BO Node

- [ ] 어떤 BO인가?
- [ ] 어떤 Method인가?
- [ ] Input Parameter는?
- [ ] Return Type은?
- [ ] 선할당은?
- [ ] 후할당은?

---

## 4. QO/DOF

- [ ] Datasource
- [ ] Query
- [ ] Bind
- [ ] 단건/다건
- [ ] Result Mapping

---

## 5. Java Source

- [ ] Generated Source 위치
- [ ] Flow와 호출 순서 일치
- [ ] 조건문
- [ ] 반복문
- [ ] Exception
- [ ] Virtual Module 코드

---

## 6. Service Call

- [ ] 호출 대상 SO
- [ ] SYNC/ASYNC
- [ ] Input Mapping
- [ ] Output Mapping
- [ ] Transaction
- [ ] Timeout

---

## 7. 한 줄 요약

EMB 분석이 끝나면 반드시 한 문장으로 업무를 정리합니다.

예:

> 고객번호를 검증하고 고객 기본정보와 보유계좌를 조회한 후 화면 출력 DO로 조합하는 서비스.

이 문장이 만들어지지 않는다면 아직 Flow를 충분히 이해하지 못한 것입니다.

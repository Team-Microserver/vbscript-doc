# ProObject 용어 빠른 정리

| 용어 | 의미 |
|---|---|
| ProStudio | ProObject 개발 IDE |
| ProManager | 관리/테스트 도구 |
| Application | 최상위 애플리케이션 단위 |
| Service Group | 서비스 논리 그룹 |
| DO | 데이터 전달 객체 |
| DOF | DB/File I/O 객체 |
| QO | Query Object |
| BO | 업무 기능 객체 |
| SO | Service Object |
| JO | Job Object |
| EMB | Enterprise Module Bus |
| Object Flow Editor | EMB Flow 설계 도구 |
| Mapping | Object 간 값 연결 |
| Virtual Module | Flow 내부 사용자 Java 코드 영역 |
| Image Log | 서비스 입출력/오류 데이터 기록 |
| GUID | 거래 추적에 활용되는 식별 정보 |

---

## Java 개발자가 기억할 대응

```text
DTO              ≒ DO
DAO              ≒ DOF/QO
Service Method   ≒ BO
Service Flow     ≒ SO + EMB
Batch Job        ≒ JO
```

정확한 1:1 대응은 아니며 이해를 돕기 위한 비교입니다.

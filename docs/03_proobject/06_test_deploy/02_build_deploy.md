# 형상관리 · 빌드 · 배포

## 1. 개발 Resource

ProObject 프로젝트에서는 Java Source뿐 아니라 여러 Meta Resource가 함께 관리될 수 있습니다.

예:

```text
DO
DOF
BO
SO
Flow
Service Group Resource
Generated Source
```

---

## 2. Commit 전 확인

```bash
git status
git diff
```

Git을 사용하는 프로젝트라면 생성/변경된 Resource를 함께 확인합니다.

!!! warning "Generated Resource 누락 주의"
    Java Source만 Commit하면 되는지, Meta/Flow Resource도 함께 Commit해야 하는지 프로젝트 표준을 확인합니다.

---

## 3. 공개 문서의 배포 예

ProStudio 공개 문서에서는 Git Staging에서 Resource를 Commit/Push한 뒤 Jenkins Hook을 통해 자동 배포하는 예시를 설명합니다.

프로젝트에 따라:

```text
Commit
 ↓
Push
 ↓
Jenkins
 ↓
Build
 ↓
Deploy
```

형태일 수 있습니다.

---

## 4. 배포 후 확인

```text
배포 Node
Resource Version
Build Time
Deploy Time
Service 등록
Service Test
```

다중 Node 환경에서는 모든 Node의 반영 여부를 확인합니다.

---

## 5. Rollback

```text
이전 Resource
DB Rollback
Config 원복
Service Disable
이전 Build
```

운영 배포 전 반드시 Rollback 방법을 확인합니다.

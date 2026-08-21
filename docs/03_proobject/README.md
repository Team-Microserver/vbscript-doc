# ProObject 사전 학습 가이드 v2

ProObject 프로젝트 투입 전 전체 구조와 개발 프로세스를 학습하기 위한 MkDocs Markdown 문서입니다.

## v2 주요 보강

- EMB(Enterprise Module Bus)를 독립 핵심 Chapter로 구성
- EMB Designer
- Node / 선할당 / 후할당 / Mapping
- 조건 / Loop / Inner Module / Virtual Module
- 다른 SO 호출
- EMB와 Generated Java Source 대응
- 기존 EMB 분석 체크리스트
- 온라인 서비스 개발 End-to-End 흐름
- Transaction / Exception / Image Log
- Test / Build / Deploy
- 현장 투입 체크리스트

## 문서 기준

TmaxSoft 공개 ProObject 7 Fix#1 문서를 기준으로 작성했습니다.

실제 현장에서는 ProObject 버전과 프로젝트 개발 표준을 최우선으로 적용해야 합니다.

## 설치 위치 예

이 ZIP의 폴더 구조를 다음처럼 복사할 수 있습니다.

```text
docs/
└─ proobject/
   ├─ 00_overview/
   ├─ 01_environment/
   ├─ 02_programming_model/
   ├─ 03_emb/
   ├─ 04_service_development/
   ├─ 05_batch/
   ├─ 06_test_deploy/
   ├─ 07_project_analysis/
   └─ 08_quick_reference/
```

`mkdocs_nav_snippet.yml`은 기존 `mkdocs.yml`의 `nav:`에 맞춰 병합합니다.

## 코드 블록

문서의 코드 블록은 내용에 맞는 언어를 지정했습니다.

- Java: `java`
- SQL: `sql`
- YAML: `yaml`
- XML: `xml`
- Properties: `properties`
- Bash/Git: `bash`
- Mermaid: `mermaid`
- 개념 구조: `text`

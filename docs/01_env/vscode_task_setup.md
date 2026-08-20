# VS Code 실행 Task 구성

## 1. 목적

이 문서는 VS Code에서 현재 열려 있는 `.vbs` 파일을 `cscript.exe`로 실행하는 Task를 구성하는 방법을 설명한다.

최종적으로 다음 단축키를 사용한다.

```text
Ctrl + Shift + B
```

실행 구조:

```text
Ctrl + Shift + B
        ↓
VS Code 기본 Build Task
        ↓
VBScript: Run Current File
        ↓
cscript.exe
        ↓
현재 활성화된 .vbs 파일
        ↓
VS Code Terminal
```

!!! note "`Ctrl + Shift + B`는 일반적인 Run 단축키가 아니다"
    `Ctrl + Shift + B`는 VS Code에서 **기본 Build Task(Default Build Task)** 를 실행하는 단축키다.

    본 프로젝트에서는 VBScript 실행 Task를 기본 Build Task로 등록했기 때문에 결과적으로 `.vbs` 실행 단축키처럼 사용한다.

---

## 2. Workspace 루트 확인

Task를 만들기 전에 VS Code가 어떤 폴더를 Workspace 루트로 열고 있는지 확인한다.

본 프로젝트의 기준:

```text
C:\projects\vbscript-doc
```

권장 구조:

```text
C:\projects\vbscript-doc
│
├─ .vscode
│   └─ tasks.json
│
├─ labs
│   └─ hello.vbs
│
├─ docs
└─ mkdocs.yml
```

!!! warning "`.vscode` 폴더 위치"
    `.vscode`는 `labs` 아래가 아니라 **VS Code에서 열어 둔 프로젝트 루트 바로 아래**에 위치해야 한다.

    정상:

    ```text
    C:\projects\vbscript-doc\.vscode\tasks.json
    ```

    잘못된 예:

    ```text
    C:\projects\vbscript-doc\labs\.vscode\tasks.json
    ```

---

## 3. `.vscode` 폴더 생성

프로젝트 루트에 다음 폴더를 생성한다.

```text
.vscode
```

구조:

```text
C:\projects\vbscript-doc
│
├─ .vscode
├─ labs
└─ docs
```

`.vscode`는 현재 Workspace에서 사용하는 VS Code 프로젝트 설정을 저장하는 폴더다.

---

## 4. `tasks.json` 생성

`.vscode` 아래에 다음 파일을 생성한다.

```text
tasks.json
```

최종 위치:

```text
C:\projects\vbscript-doc\.vscode\tasks.json
```

---

## 5. 기본 설정

`tasks.json`에 다음 내용을 입력한다.

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "VBScript: Run Current File",
            "type": "process",
            "command": "${env:WINDIR}\\System32\\cscript.exe",
            "args": [
                "//nologo",
                "${file}"
            ],
            "options": {
                "cwd": "${fileDirname}"
            },
            "group": {
                "kind": "build",
                "isDefault": true
            },
            "presentation": {
                "reveal": "always",
                "panel": "shared",
                "clear": true
            },
            "problemMatcher": []
        }
    ]
}
```

저장:

```text
Ctrl + S
```

---

## 6. `label`

```json
"label": "VBScript: Run Current File"
```

Task의 이름이다.

VS Code에서 Task 목록을 열면 다음 이름으로 표시된다.

```text
VBScript: Run Current File
```

---

## 7. `type`

```json
"type": "process"
```

외부 실행 프로그램을 직접 Process 형태로 실행한다.

본 Task에서 실행하는 프로그램은:

```text
cscript.exe
```

이다.

---

## 8. `command`

```json
"command": "${env:WINDIR}\\System32\\cscript.exe"
```

VBScript를 실행할 프로그램을 지정한다.

`${env:WINDIR}`는 현재 Windows 설치 경로를 의미한다.

일반적으로:

```text
C:\Windows
```

이므로 실제 실행 프로그램은 다음과 같다.

```text
C:\Windows\System32\cscript.exe
```

!!! tip "Windows 환경변수를 사용하는 이유"
    `C:\Windows`를 직접 고정하지 않고 `${env:WINDIR}`를 사용하면 Windows 설치 경로 차이에 조금 더 유연하게 대응할 수 있다.

---

## 9. `args`

```json
"args": [
    "//nologo",
    "${file}"
]
```

`cscript.exe`에 전달할 실행 옵션과 대상 파일을 정의한다.

실제로 다음과 같은 명령을 수행하는 것과 같은 의미다.

```powershell
cscript.exe //nologo 현재열려있는파일.vbs
```

### 9.1 `//nologo`

Windows Script Host의 로고와 버전 정보를 생략한다.

```text
//nologo
```

학습 중에는 실제 스크립트 출력만 확인하기 쉽다.

### 9.2 `${file}`

`${file}`은 VS Code에서 **현재 활성화된 Editor 파일의 전체 경로**를 의미한다.

예:

```text
C:\projects\vbscript-doc\labs\hello.vbs
```

따라서 특정 파일명을 `tasks.json`에 고정하지 않는다.

```text
hello.vbs
loop_test.vbs
condition_test.vbs
```

중 어떤 파일을 열더라도 현재 활성화된 파일이 실행된다.

---

## 10. `options.cwd`

```json
"options": {
    "cwd": "${fileDirname}"
}
```

Current Working Directory를 현재 `.vbs` 파일이 위치한 폴더로 설정한다.

예:

```text
C:\projects\vbscript-doc\labs\04_file\filesystem_object.vbs
```

를 실행하면 작업 디렉터리는:

```text
C:\projects\vbscript-doc\labs\04_file
```

가 된다.

이 설정은 이후 상대 경로 기반의 파일 읽기/쓰기 예제에서 중요하다.

---

## 11. `group`과 기본 Build Task

```json
"group": {
    "kind": "build",
    "isDefault": true
}
```

이 설정은 현재 Task를 VS Code의 **Build Task 그룹**에 등록하고 그중 **기본 Build Task**로 지정한다.

!!! note "`Ctrl + Shift + B`와 기본 Build Task"
    `Ctrl + Shift + B`는 VS Code에서 **기본 Build Task(Default Build Task)를 실행하는 단축키**이다.

    VBScript는 Java와 달리 별도의 컴파일이나 빌드 과정이 없지만, 본 학습 환경에서는 `.vbs` 파일을 편리하게 실행하기 위해 **VBScript 실행 Task를 Build 그룹의 기본 Task로 등록**한다.

    다음 설정에서:

    ```json
    "group": {
        "kind": "build",
        "isDefault": true
    }
    ```

    `kind: "build"`는 해당 Task를 VS Code의 **Build Task 그룹에 등록**한다는 의미다.

    `isDefault: true`는 여러 Build Task 중 이 Task를 **기본 Build Task로 지정**한다는 의미다.

    따라서 현재 프로젝트에서는 다음과 같이 동작한다.

    ```text
    Ctrl + Shift + B
            ↓
    VS Code 기본 Build Task 실행
            ↓
    VBScript: Run Current File
            ↓
    cscript.exe //nologo 현재파일.vbs
            ↓
    현재 VBScript 파일 실행
    ```

    즉, `Ctrl + Shift + B`를 누른다고 해서 VBScript를 실제로 **빌드(Build)** 하는 것은 아니다.

    VS Code가 제공하는 기본 Build Task 단축키를 **VBScript 실행 Task에 연결하여 사용**하는 것이다.

    Java나 Spring Boot 프로젝트에서는 `Ctrl + Shift + B`가 실제 컴파일이나 패키징 등의 Build Task에 연결될 수 있으므로, 이 단축키를 모든 언어의 공통적인 **프로그램 실행 단축키**로 이해하면 안 된다.

---

## 12. `presentation`

```json
"presentation": {
    "reveal": "always",
    "panel": "shared",
    "clear": true
}
```

### 12.1 `reveal`

```json
"reveal": "always"
```

Task 실행 시 Terminal을 자동으로 표시한다.

### 12.2 `panel`

```json
"panel": "shared"
```

동일한 Terminal 패널을 재사용한다.

### 12.3 `clear`

```json
"clear": true
```

실행할 때 이전 출력 내용을 정리해 현재 결과를 보기 쉽게 한다.

---

## 13. `problemMatcher`

```json
"problemMatcher": []
```

현재 Task에서는 별도의 VS Code Problem Matcher를 사용하지 않는다.

VBScript 오류는 우선 `cscript.exe`가 Terminal에 출력하는 파일명, 줄 번호, 오류 메시지를 직접 확인한다.

---

## 14. Task 실행

실행할 `.vbs` 파일을 활성화한다.

예:

```text
labs/hello.vbs
```

먼저 저장한다.

```text
Ctrl + S
```

그 다음:

```text
Ctrl + Shift + B
```

를 누른다.

정상적으로 설정되었다면 `VBScript: Run Current File` Task가 실행되고 Terminal에 결과가 표시된다.

```text
Hello VBScript
```

---

## 15. `No build task to run found`가 표시되는 경우

`Ctrl + Shift + B`를 눌렀을 때 다음 메시지가 표시될 수 있다.

```text
No build task to run found.
Configure Build Task...
```

이 메시지는 VS Code가 현재 Workspace에서 **기본 Build Task를 찾지 못했다는 의미**다.

우선 다음 구조를 확인한다.

```text
C:\projects\vbscript-doc
│
├─ .vscode
│   └─ tasks.json
│
└─ labs
    └─ hello.vbs
```

확인 항목:

1. VS Code에서 `C:\projects\vbscript-doc` 폴더 자체를 열었는가?
2. `.vscode` 폴더가 Workspace 루트 바로 아래에 있는가?
3. 파일명이 정확히 `tasks.json`인가?
4. `tasks.json`을 저장했는가?
5. 다음 설정이 존재하는가?

```json
"group": {
    "kind": "build",
    "isDefault": true
}
```

!!! tip "`Configure Build Task...`를 반드시 누를 필요는 없다"
    본 가이드에서는 자동 생성 대신 프로젝트 루트에 `.vscode/tasks.json`을 직접 작성한다.

    올바른 위치에 파일을 저장한 후 다시 `Ctrl + Shift + B`를 실행한다.

---

## 16. 메뉴에서 Task 실행

단축키 대신 메뉴에서도 실행할 수 있다.

```text
Terminal
  ↓
Run Task...
  ↓
VBScript: Run Current File
```

Command Palette:

```text
Ctrl + Shift + P
```

검색:

```text
Tasks: Run Task
```

선택:

```text
VBScript: Run Current File
```

---

## 17. F5와의 차이

VS Code에서 일반적으로 `F5`는 **Debugger 실행**에 사용한다.

VBScript는 VS Code의 기본 디버깅 대상이 아니므로 본 환경에서는 F5 기반 Step Debugging을 기본으로 구성하지 않는다.

```text
F5
= Debug 실행

Ctrl + Shift + B
= 기본 Build Task 실행
= 본 프로젝트에서는 VBScript 실행 Task
```

!!! note "본 환경의 목적"
    이 구성의 핵심은 **가이드 예제를 빠르게 작성 → 저장 → 실행 → 결과 확인**하는 것이다.

---

## 18. 다음 단계

!!! tip "다음 가이드"
    `Ctrl + Shift + B`를 이용한 Task 실행이 정상적으로 동작한다면 여러 `.vbs` 파일을 만들어 실제 실행을 검증한다.

    **[스크립트 실행 및 검증](vbscript_run_verification.md)**

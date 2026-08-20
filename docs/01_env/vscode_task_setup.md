# VS Code 실행 Task 구성

## 1. 목적

이 문서는 VS Code에서 현재 열려 있는 `.vbs` 파일을 다음 단축키로 실행하도록 설정하는 방법을 설명한다.

```text
Ctrl + Shift + B
```

최종 실행 구조:

```text
Ctrl + Shift + B
        ↓
tasks.json
        ↓
cscript.exe
        ↓
현재 열려 있는 .vbs 파일
        ↓
VS Code Terminal
```

---

## 2. `.vscode` 폴더 생성

프로젝트 루트에 다음 폴더를 생성한다.

```text
.vscode
```

구조:

```text
C:\dev\vbscript-lab
│
├─ .vscode
│
└─ hello.vbs
```

`.vscode` 폴더는 현재 Workspace에서 사용하는 VS Code 설정을 저장하는 위치다.

---

## 3. `tasks.json` 생성

`.vscode` 폴더 아래에 다음 파일을 생성한다.

```text
tasks.json
```

최종 구조:

```text
C:\dev\vbscript-lab
│
├─ .vscode
│   └─ tasks.json
│
└─ hello.vbs
```

---

## 4. 기본 설정

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

---

## 5. `label`

```json
"label": "VBScript: Run Current File"
```

Task의 이름이다.

VS Code에서 Task를 선택할 때 다음 이름으로 표시된다.

```text
VBScript: Run Current File
```

---

## 6. `type`

```json
"type": "process"
```

외부 실행 프로그램을 직접 Process 형태로 호출한다.

이번 환경에서는 다음 프로그램을 실행한다.

```text
cscript.exe
```

---

## 7. `command`

```json
"command": "${env:WINDIR}\\System32\\cscript.exe"
```

VBScript를 실행할 프로그램을 지정한다.

`${env:WINDIR}`는 Windows 설치 경로를 의미한다.

일반적으로:

```text
C:\Windows
```

따라서 실제 실행 파일은 보통 다음과 같다.

```text
C:\Windows\System32\cscript.exe
```

!!! tip "절대 경로 대신 Windows 환경변수 사용"
    `C:\Windows`를 직접 고정하지 않고 `${env:WINDIR}`를 사용하면 Windows 설치 경로 차이에 조금 더 유연하게 대응할 수 있다.

---

## 8. `args`

```json
"args": [
    "//nologo",
    "${file}"
]
```

`cscript.exe`에 전달할 실행 옵션과 파일을 정의한다.

실제로는 다음 명령과 같은 의미다.

```powershell
cscript.exe //nologo 현재파일.vbs
```

### `${file}`

`${file}`은 VS Code에서 **현재 활성화되어 있는 파일의 전체 경로**를 의미한다.

예:

```text
C:\dev\vbscript-lab\01_basic\loop.vbs
```

따라서 `tasks.json`에서 특정 파일명을 고정하지 않는다.

다음 파일들이 존재해도:

```text
hello.vbs
variable.vbs
condition.vbs
loop.vbs
```

현재 Editor에서 열어둔 파일을 실행한다.

---

## 9. `options.cwd`

```json
"options": {
    "cwd": "${fileDirname}"
}
```

스크립트를 실행할 때 Current Working Directory를 현재 `.vbs` 파일의 폴더로 설정한다.

예:

```text
C:\dev\vbscript-lab\04_file\filesystem_object.vbs
```

를 실행하면 작업 디렉터리는:

```text
C:\dev\vbscript-lab\04_file
```

가 된다.

이 설정은 이후 상대 경로 기반 파일 처리 예제를 학습할 때 유용하다.

---

## 10. `group`

```json
"group": {
    "kind": "build",
    "isDefault": true
}
```

현재 Task를 VS Code의 기본 Build Task로 지정한다.

따라서 다음 단축키로 실행할 수 있다.

```text
Ctrl + Shift + B
```

흐름:

```text
Ctrl + Shift + B
        ↓
Default Build Task
        ↓
VBScript: Run Current File
```

---

## 11. `presentation`

```json
"presentation": {
    "reveal": "always",
    "panel": "shared",
    "clear": true
}
```

### `reveal`

```json
"reveal": "always"
```

실행할 때 Terminal을 표시한다.

### `panel`

```json
"panel": "shared"
```

동일한 Terminal 패널을 재사용한다.

### `clear`

```json
"clear": true
```

이전 출력 내용을 정리하여 현재 결과를 보기 쉽게 한다.

---

## 12. `problemMatcher`

```json
"problemMatcher": []
```

현재 Task에서는 별도의 VS Code Problem Matcher를 사용하지 않는다.

VBScript 오류는 우선 `cscript.exe`가 Terminal에 출력하는 오류 메시지를 직접 확인하는 방식으로 학습한다.

---

## 13. Task 실행

`hello.vbs` 파일을 열고 저장한다.

```text
Ctrl + S
```

실행:

```text
Ctrl + Shift + B
```

처음 실행할 때 Task 선택 화면이 나온다면 다음 항목을 선택한다.

```text
VBScript: Run Current File
```

정상적으로 기본 Task가 지정되면 이후에는 바로 실행된다.

---

## 14. 메뉴에서 실행하는 방법

단축키 대신 메뉴에서도 실행할 수 있다.

```text
Terminal
  ↓
Run Task...
  ↓
VBScript: Run Current File
```

또는 Command Palette:

```text
Ctrl + Shift + P
```

검색:

```text
Tasks: Run Task
```

Task 선택:

```text
VBScript: Run Current File
```

---

## 15. F5 대신 `Ctrl + Shift + B`를 사용하는 이유

VS Code의 `F5`는 일반적으로 Debugger 실행에 사용된다.

VBScript는 VS Code의 기본 디버깅 대상이 아니므로 본 학습 환경에서는 Step Debugging 구성을 기본으로 하지 않는다.

따라서:

```text
F5
```

대신:

```text
Ctrl + Shift + B
```

를 사용한다.

!!! note "이 환경의 목적"
    이 구성의 핵심은 **가이드 예제를 빠르게 작성 → 저장 → 실행 → 결과 확인**하는 것이다.

    IDE 수준의 VBScript 디버깅 환경 구축은 별도 주제로 다룬다.

---

## 16. 다음 단계

Task 구성이 완료되었다면 실제로 여러 `.vbs` 파일이 현재 파일 기준으로 실행되는지 검증한다.

[스크립트 실행 및 검증](vbscript_run_verification.md)

# Windows VBScript 실행 기능 확인

## 1. 목적

이 문서는 Windows 11 Pro에서 **VBScript를 실행할 수 있는 Windows 기본 환경이 정상인지 확인하고 테스트하는 과정**을 설명한다.

VS Code 설정 전에 반드시 이 단계부터 확인한다.

```text
Windows 실행 기능 확인
        ↓
VBScript 직접 실행 성공
        ↓
VS Code 구성
```

---

## 2. Windows Script Host 이해

Windows에서는 Windows Script Host(WSH)를 통해 스크립트를 실행할 수 있다.

VBScript 실행에 주로 사용하는 프로그램은 다음 두 가지다.

```text
Windows Script Host
│
├─ cscript.exe
│   └─ 콘솔 기반 실행
│
└─ wscript.exe
    └─ Windows GUI 기반 실행
```

### `cscript.exe`

명령행 환경에서 `.vbs` 파일을 실행한다.

```powershell
cscript.exe hello.vbs
```

본 가이드에서는 **`cscript.exe`를 기본 실행 프로그램으로 사용한다.**

이유는 실행 결과와 오류 메시지를 VS Code Terminal에서 바로 확인할 수 있기 때문이다.

### `wscript.exe`

Windows GUI 방식으로 스크립트를 실행한다.

```powershell
wscript.exe hello.vbs
```

`WScript.Echo` 출력 등이 팝업 창으로 표시될 수 있으므로 반복 학습 환경에서는 `cscript.exe`가 더 편리하다.

---

## 3. Windows 버전 확인

키보드에서 다음을 누른다.

```text
Windows + R
```

실행 창에 다음을 입력한다.

```text
winver
```

Windows 버전을 확인한다.

PowerShell에서도 확인할 수 있다.

```powershell
Get-ComputerInfo |
    Select-Object WindowsProductName, WindowsVersion, OsBuildNumber
```

!!! note "버전을 확인하는 이유"
    VBScript는 Microsoft에서 사용 중단(deprecated) 기술로 지정되었으며 최신 Windows에서는 선택적 기능으로 단계적으로 전환되고 있다.

    따라서 PC 환경에 따라 VBScript 기능 상태가 다를 수 있다.

---

## 4. `cscript.exe` 확인

PowerShell을 실행한다.

다음 명령을 입력한다.

```powershell
Get-Command cscript.exe
```

정상적인 경우 `cscript.exe`와 해당 경로가 표시된다.

추가 확인:

```powershell
where.exe cscript.exe
```

일반적인 Windows 설치 환경에서는 다음 경로가 확인된다.

```text
C:\Windows\System32\cscript.exe
```

`wscript.exe`도 확인할 수 있다.

```powershell
where.exe wscript.exe
```

---

## 5. `cscript.exe` 실행 확인

다음 명령을 실행한다.

```powershell
cscript.exe //?
```

Windows Script Host의 도움말이 표시되면 `cscript.exe` 자체는 실행 가능한 상태다.

!!! success "정상 확인"
    다음 두 가지가 모두 성공해야 한다.

    ```text
    Get-Command cscript.exe
    cscript.exe //?
    ```

---

## 6. VBScript 선택적 기능 상태 확인

최신 Windows에서는 VBScript가 Feature on Demand 형태로 제공될 수 있다.

관리자 권한 PowerShell을 실행한다.

```text
시작 메뉴
  ↓
PowerShell 검색
  ↓
마우스 오른쪽 클릭
  ↓
관리자 권한으로 실행
```

다음 명령을 실행한다.

```powershell
Get-WindowsCapability -Online |
    Where-Object { $_.Name -like "VBSCRIPT*" }
```

환경에 따라 다음과 비슷한 결과가 표시될 수 있다.

```text
Name  : VBSCRIPT~~~~
State : Installed
```

`State`가 다음과 같으면 설치된 상태다.

```text
Installed
```

---

## 7. VBScript 기능이 설치되어 있지 않은 경우

Windows 설정 검색에서 다음을 검색한다.

```text
선택적 기능
```

또는:

```text
Optional features
```

목록에서 `VBScript`를 검색하여 설치한다.

!!! note "Windows 빌드별 메뉴 차이"
    Windows 11 빌드에 따라 설정 화면의 세부 경로가 달라질 수 있다.

    따라서 메뉴를 단계적으로 찾기보다 Windows 설정 검색에서 **선택적 기능**을 검색하는 방식을 권장한다.

---

## 8. DISM을 이용한 확인 및 설치

GUI에서 확인하기 어렵다면 관리자 권한 터미널에서 DISM을 사용할 수 있다.

상태 확인:

```cmd
DISM /Online /Get-CapabilityInfo /CapabilityName:VBSCRIPT~~~~
```

설치가 필요한 경우:

```cmd
DISM /Online /Add-Capability /CapabilityName:VBSCRIPT~~~~
```

설치 후 PowerShell에서 다시 확인한다.

```powershell
Get-WindowsCapability -Online |
    Where-Object { $_.Name -like "VBSCRIPT*" }
```

!!! warning "설치 명령부터 실행하지 않는다"
    먼저 `cscript.exe` 실행 여부와 Capability 상태를 확인한다.

    이미 정상적으로 사용할 수 있다면 다시 설치할 필요가 없다.

---

## 9. 단독 실행 테스트 폴더 생성

VS Code를 연결하기 전에 `.vbs` 파일을 Windows에서 직접 실행해 본다.

예제 폴더:

```text
C:\dev\vbscript-lab
```

PowerShell:

```powershell
New-Item -ItemType Directory -Path C:\dev\vbscript-lab -Force
cd C:\dev\vbscript-lab
```

---

## 10. `hello.vbs` 생성

다음 파일을 만든다.

```text
hello.vbs
```

내용:

```vbscript
Option Explicit

Dim message
message = "Hello VBScript"

WScript.Echo message
```

파일 구조:

```text
C:\dev\vbscript-lab
└─ hello.vbs
```

---

## 11. PowerShell에서 실행

다음 명령을 실행한다.

```powershell
cscript.exe //nologo .\hello.vbs
```

정상 결과:

```text
Hello VBScript
```

### `//nologo`

Windows Script Host의 로고와 버전 표시를 생략하고 실제 실행 결과에 집중하기 위한 옵션이다.

기본 학습 명령은 다음처럼 사용한다.

```powershell
cscript.exe //nologo script.vbs
```

!!! success "Windows 실행 환경 검증 완료"
    다음 결과가 정상적으로 출력되면 Windows 차원의 VBScript 실행 환경은 준비된 것이다.

    ```text
    Hello VBScript
    ```

    이제 [VS Code 작업 환경 구성](vscode_workspace_setup.md)으로 진행한다.

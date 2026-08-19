# CreateObject와 COM 개념

`CreateObject`는 등록된 COM 객체를 생성할 때 사용하는 VBScript의 대표적인 기능입니다. 학습 예제에서는 `Scripting.Dictionary`나 `Scripting.FileSystemObject`를 자주 볼 수 있습니다.

```vb
Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")
```

## 왜 알아야 하는가

프로젝트 화면 코드에서 `CreateObject("...")`가 보이면 단순 함수 호출이 아니라 외부 객체를 생성하는 코드라는 것을 알아야 합니다. 객체 이름에 따라 파일, XML, HTTP, 사내 컴포넌트 등 서로 다른 기능일 수 있습니다.

!!! warning "프로젝트에서 무분별하게 사용하지 않기"
    금융권 단말/화면 환경은 보안정책과 실행권한이 엄격할 수 있습니다. 학습 환경에서 생성 가능한 COM 객체가 실제 업무 환경에서도 허용된다고 가정하면 안 됩니다.

## FileSystemObject 예제

아래 예제는 문법 이해용입니다.

```vb
Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")

If fso.FileExists("C:\temp\sample.txt") Then
    MsgBox "파일이 존재합니다."
End If

Set fso = Nothing
```

## CreateObject를 발견했을 때 분석 순서

1. ProgID 문자열을 확인한다.
2. 같은 객체 생성 코드가 어디에 더 있는지 검색한다.
3. 생성 후 어떤 메서드/속성을 호출하는지 본다.
4. 공통 컴포넌트인지 로컬 기능인지 구분한다.
5. 예외 발생 시 프로젝트 표준 오류 처리 방법을 확인한다.

전용 개발도구 자체가 객체를 이미 주입해주는 구조라면 `CreateObject` 없이 화면 객체를 바로 사용할 수도 있습니다.

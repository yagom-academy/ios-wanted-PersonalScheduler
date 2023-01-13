# PersonalScheduler

## 🙋🏻‍♂️ 프로젝트 소개
원티드 프리온 보딩 `PersonalScheduler` 앱 프로젝트 입니다.

> 프로젝트 기간: 2023-01-09 ~ 2023-01-13 (5일)
> 팀원: [브래드](https://github.com/bradheo65)

## 📑 목차

- [🧑🏻‍💻🧑🏻‍💻 개발자 소개](#-개발자-소개)
- [🔑 핵심기술](#-핵심기술)
- [📱 실행화면](#-실행화면)
- [⚙️ 적용한 기술](#-적용한-기술)
- [🛠 아쉬운 점](#-아쉬운-점)


## 🧑🏻‍💻🧑🏻‍💻 개발자 소개

|[브래드](https://github.com/bradheo65)|
|:---:|
|<image src = "https://i.imgur.com/35bM0jV.png" width="250" height="250">|


## 🔑 핵심기술
- **`UI 구현`**
    - Swift UI
- **`로그인`**
    - Kakao, Facebook, FirebaseAuth
- **`파일 저장 형식`**
    - FireBaseStore
- **`비동기처리`**
    - escaping closer
    - async await

## 📱 실행화면

|`FirebaseAuth 회원가입`|`FirebaseAuth 로그인`|
|:---:|:---:|
|<image src = "https://i.imgur.com/LUHtngo.gif" width="250" height="500">|<image src = "https://i.imgur.com/AUMl0g3.gif" width="250" height="500">|  

|`페이스북 로그인`|`카카오 로그인`|
|:---:|:---:|
|<image src = "https://i.imgur.com/kKqaxT1.gif" width="250" height="500">|<image src = "https://i.imgur.com/M5kFrRu.gif" width="250" height="500">|

|`자동 로그인`|`푸쉬 알람`|
|:---:|:---:|
|<image src = "https://i.imgur.com/jDtGWkv.gif" width="250" height="500">|<image src = "https://i.imgur.com/iDlwRXJ.gif" width="250" height="500">| 

|`추가 기능`|`편집 및 삭제 기능`|
|:---:|:---:|
|<image src = "https://i.imgur.com/u1EwH0w.gif" width="250" height="500">|<image src = "https://i.imgur.com/ZmFztGp.gif" width="250" height="500">| 

## 🔭 프로젝트 구조

### - File Tree
    
```
.
├── Assets.xcassets
│   ├── AccentColor.colorset
│   │   └── Contents.json
│   ├── AppIcon.appiconset
│   │   └── Contents.json
│   ├── Contents.json
│   ├── Image.imageset
│   │   └── Contents.json
│   └── KakoLoginImageButton.imageset
│       ├── Contents.json
│       └── kakao_login_medium_narrow.png
├── Config.xcconfig
├── Extension
│   ├── Date+Extension.swift
│   └── String+Extension.swift
├── GoogleService-Info.plist
├── Info.plist
├── Manager
│   ├── FirebaseStorageManager.swift
│   ├── LoginManager
│   │   ├── FacebookLoginManager.swift
│   │   ├── FirebaseLoginManager.swift
│   │   └── KakaoLoginManager.swift
│   └── NotificationManager.swift
├── Model
│   ├── KakaoInfo.swift
│   ├── ScheduleList.swift
│   └── UserInfoData.swift
├── PersonalSchedulerApp.swift
├── Preview Content
│   └── Preview Assets.xcassets
│       └── Contents.json
├── View
│   ├── FBLogView.swift
│   ├── LoginView.swift
│   ├── ScheduleAddView.swift
│   ├── ScheduleListCellView.swift
│   ├── ScheduleListView.swift
│   └── SignUpView.swift
└── ViewModel
    ├── LoginViewModel.swift
    ├── ScheduleAddViewModel.swift
    ├── ScheduleListViewModel.swift
    └── SignUpViewModel.swift
```
    
## ⚙️ 적용한 기술
    
### ✅ View
    
- SwiftUI View 구현

### ✅ Auth 

- Kakao Login
- Facebook Login
- FirebaseAuth 
    - 카카오톡, 페이스북 로그인 연동 구현
    
### ✅ RemoteDatabase

- FirebaseStore
    - CRUD 구현
    - 계정의 고유한 ID 'UID'식별을 통한 데이터 저장

### ✅ 자동 로그인

- 선택 버튼
    - UserDefault
    
- 로그인 정보
    - FirebaseStore의 Auth.auth().currentUser.uid의 value로 로그인

### ✅ Push Alarm

- UserNotifications
    - 애플에서 제공하는 기본 라이브러리를 통해 구현
    
## 🛠 아쉬운 점
    
- 애플 아이디 로그인 구현 시 애플 개발자 계정이 필요하기에 구현하지 못했다.
- Firebase cloud messaging, Apple push notification center 애플 개발자 계정이 필요하기에 구현하지 못했다.

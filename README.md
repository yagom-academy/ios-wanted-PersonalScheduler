# [Wanted-PersonScheduler]

## 🗒︎ 목차
1. [소개](#-소개)
2. [개발환경 및 라이브러리](#-개발환경-및-라이브러리)
3. [팀원](#-팀원)
4. [타임라인](#-타임라인)
5. [파일구조](#-파일구조)
6. [실행화면](#-실행-화면)
7. [구현내용](#-구현-내용)


<br>

## 👋 소개

**아이폰환경에서 개인 로그인 정보 및 일정 데이터를 Firebase로 관리해주는 프로젝트**
- 프로젝트 기간 : 23.02.06 ~ 23.02.12 (1주)

## 💻 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.6-orange)]()
[![macOS](https://img.shields.io/badge/macOS_Deployment_Target-14.0-blue)]()

<br>

## 🧑 팀원 소개

- **소개**


|Dragon|
|:---:|
|<img src = "https://i.imgur.com/LI25l3O.png" width=200 height=200>| 
| [Github](https://github.com/YongGeun2) |

<br>

## 🕖 타임라인

|날짜|구현 내용|
|--|--| 
|23.02.06| 로그인 및 회원가입 View - UI 구성|
|23.02.07| 일정리스트 및 일정데이터 View - UI 구성 및 데이터 저장 구현|
|23.02.08| 기본 로그인 및 회원가입 기능 구현 <br /> SNS를 통한 로그인 기능 구현 <br /> 아이디+비밀번호 로그인 또는 SNS 로그인시 Firebase에 유저정보 저장 구현 |
|23.02.09| Firebase에 Collection 생성 및 데이터 읽기&업데이트 기능 구현 <br /> 일정 데이터 저장시 날짜정보 필수 입력하도록 사용자 안내 구현
|23.02.10| 일정 데이터 접근시 읽기/편집모드에 따른 기능 분리 구현 <br /> 전체적으로 디테일 및 동작 개선
|23.02.12| 일정시간과 관련된 동작 구현 <br /> - 일정 생성시 종료일자가 시작일자 이후로 설정할 수 있게 구현 <br /> - 오늘날짜가 저장된 일자와 동일할 경우 하이라이트 표시 (지났을 경우. 회색표시) 구현 <br /> - 일정리스트를 가까운 날짜순으로 정리 <br /> `Code` 정리 및 앱 동작 최종 검토 <br /> 프로젝트 README 작성|

<br>

## 💻 실행 화면

|<img src="https://user-images.githubusercontent.com/102534252/218307270-58705181-1415-4279-95cf-76a942b80ec0.gif" width=250>|<img src="https://user-images.githubusercontent.com/102534252/218307278-7cfefcdd-efc6-4a8c-b2cf-69728598f645.gif" width=250>|<img src="https://user-images.githubusercontent.com/102534252/218307284-f985492f-047e-47bf-8f12-940b10fa7a39.gif" width=250>|
|:-:|:-:|:-:|
|회원가입&로그인|카카오 로그인|페이스북 로그인|

|<img src="https://user-images.githubusercontent.com/102534252/218307291-0d4d7d3c-b9bd-4501-a11d-3048865ee491.gif" width=250>|<img src="https://user-images.githubusercontent.com/102534252/218307296-c9ae5f01-354f-4d5c-b66d-cc760e4074d8.gif" width=250>|<img src="https://user-images.githubusercontent.com/102534252/218307301-b72c1954-c7eb-40f6-915e-9d65753891f8.gif" width=250>|
|:-:|:-:|:-:|
|데이터 생성|데이터 삭제|데이터 읽기&편집|

|<img src="https://user-images.githubusercontent.com/102534252/218307305-80d49d43-54f2-4ff4-b78f-d989734adeaa.gif" width=250>|<img src="https://user-images.githubusercontent.com/102534252/218307310-57276848-2686-4f20-8dab-bed824a507b8.gif" width=250>|<img src="https://user-images.githubusercontent.com/102534252/218307313-1519ba86-3a1d-4399-899e-4036016c5348.gif" width=250>|
|:-:|:-:|:-:|
|완료/진행/예정 일정 구분|계정구분 데이터 로드|날짜 확인 후 시간별 저장|

<br>

## 💾 파일구조

### tree
```bash
[PersonScheduler]
├── Info.plist
├── Resource
│   ├── Assets.xcassets
│   └── LaunchScreen.storyboard
├── Source
├   ├── App
│   │   ├── AppDelegate.swift
│   │   └── SceneDelegate.swift
│   ├── Model
│   │   ├── Extension
│   │   │   ├── JSONDecoder +.swift
│   │   │   ├── JSONEncoder +.swift
│   │   │   └── UITextField +.swift
│   │   ├── Mode.swift
│   │   ├── Protocol
│   │   │   ├── AlertPresentable.swift
│   │   │   ├── DataSendable.swift
│   │   │   └── UserInfoSendable.swift
│   │   └── Schedule.swift
│   └── Scene
│       └── Main
│           ├── CreateUserInfo
│           │   └── CreateUserInfoViewController.swift
│           ├── List
│           │   ├── ListViewController.swift
│           │   ├── ScheduleInfo
│           │   │   ├── ScheduleInfoViewController.swift
│           │   │   └── View
│           │   │       └── ScheduleInfoView.swift
│           │   └── View
│           │       ├── ListTableViewCell.swift
│           │       └── ListView.swift
│           ├── MainViewController.swift
│           └── View
│               └── NormalLoginView.swift
└── README.md

```
<br>

## 🎯 구현 내용

- **MVC 아키텍쳐**를 사용하여 구현
- **CocoaPods**를 사용하여 외부라이브러리 관리

#### [파일 설명]
- **Controller**
    - MainViewController
        - 로그인 화면으로 기본적인 아이디+비밀번호 로그인 또는 SNS 로그인 가능
            - 계정이 없을 경우 회원가입 화면으로 이동
    - CreateUSerInfoViewController
        - 회원가입 화면으로 기본적인 아이디+비밀번호 생성 가능
    - ListViewController
        - 일정 리스트 화면으로 간소화된 일정 데이터를 보여주거나 일정을 추가 가능
    - ScheduleInfoViewController
        - 일정 데이터를 생성&읽기&편집 모드에 따라 데이터 관리 가능
<br>

- **View**
    - NormalLoginView
        - 기본적인 아이디+비밀번호를 입력하는 TextField와 커스텀 가능한 버튼으로 구성된 View
    - ListView
        - 일정 리스트 정보를 보여주는 TableView와 일정 추가 버튼으로 구성된 View
    - ListTableViewCell
        - 일정 정보를 간소화하여 TableView에 올라가는 Cell
    - ScheduleInfoView
        - 일정의 전체 데이터를 보여주는 View
<br>

- **Model**
    - AlertPersentable
        - Alert 생성을 간소화하고 Alert을 관리하는 Protocol+Extension
    - DataSendable
        - 화면간의 일정 데이터를 전달하는 Protocol
    - UserInfoSendable
        - 화면간의 계정 데이터를 전달하는 Protocol
    - UITextField + Extension 
        - 프로젝트에 맞춰 커스텀된 UITextField 기능을 담은 Extension
    - JSONDecoder + Extension
        - 프로젝트에 맞춰 커스텀된 JSONDecoder 기능을 담은 Extension
    - JSONEncoder + Extension
        - 프로젝트에 맞춰 커스텀된 JSONEncoder 기능을 담은 Extension
    - Schedule
        - 일정 데이터의 전체 항목을 담은 Struct
    - Mode
        - 로그인 또는 회원가입 모드구분, 데이터 생성&읽기&편집 모드구분

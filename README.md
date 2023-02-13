# 🗒️ Personal Scheduler

## 📖 목차
1. [앱 소개](#-앱-소개)
2. [팀 소개](#-팀-소개)
3. [실행 화면](#-실행-화면)
4. [Diagram](#-diagram)
5. [사용한 기술](#-사용한-기술)
6. [폴더 구조](#-폴더-구조)
7. [타임라인](#-타임라인)


## 🔬 앱 소개
- OAuth, OpenID를 통해 회원가입을 지원하고 유저를 식별합니다
- 파이어베이스를 활용한 스케줄링 앱 입니다

#### 개발 기간
- 2023년 2월 6일(월) ~ 2023년 2월 12일(일)

## 🌱 팀 소개
|[Wonbi](https://github.com/wonbi92)|
|:---:|
| <img width="180px" img style="border: 2px solid lightgray; border-radius: 90px;-moz-border-radius: 90px;-khtml-border-radius: 90px;-webkit-border-radius: 90px;" src="https://avatars.githubusercontent.com/u/88074999?v=4">| 

## 🛠 실행 화면
|앱을 처음시작할 경우|이미 로그인을 한 경우|
|:-:|:-:|
![](https://i.imgur.com/iTcAl3O.gif)|![](https://i.imgur.com/4rnAAxX.gif)

|Facebook 로그인|Kakao 로그인|
|:-:|:-:|
![](https://i.imgur.com/KNryQHy.gif)|![](https://i.imgur.com/m48ShWO.gif)|

|로그아웃|스크롤 및 특정날짜 하이라이트|
|:-:|:-:|
![](https://i.imgur.com/lmJ11YL.gif)|![](https://i.imgur.com/s3NjgQB.gif)|

|다크모드|
|:-:|
![](https://i.imgur.com/fBGNeMf.gif)|


## 👀 Diagram

### 🐙 기술스택 마인드맵
![](https://i.imgur.com/2TE3agR.png)

### 🏗 아키텍쳐
![](https://i.imgur.com/45Kd6le.png)

## 🏃🏻 사용한 기술

#### ⚙️ MVVM 
- 💡 역할 간 계층을 분리를 통해 하나의 객체가 모든 책임을 다 가지도록 하지 않게 하고, 앱의 유지보수 및 수정을 편리하게 하기 위해 사용하였습니다.

#### ⚙️ Design Patten - FactoryMethod

- 💡 ViewController를 생성하는 책임을 분리하여, `ViewControllerFactory` 객체를 통해 ViewController 생성을 전담하도록 하였습니다.

#### ⚙️ Design Patten - Builder
- 💡 사용자에게 특정 정보를 알려주는 Alert을 만들어주는 `AlertBuilder` 객체를 통해 Alert을 생성 시 각 상황에 맞게 사용할 수 있도록 하였습니다.
- 💡 마찬가지로 로그인 버튼을 ButtonBuilder 객체를 통해서 만들어지도록 하여 필요한 부분만 설정하면 나머지는 규격에 맞게 설정되도록 구현해보았습니다.

 
## 🗂 폴더 구조


<details>
<summary> 
펼쳐보기
</summary>

```
PersonalScheduler
├── Utility
│   ├── AlretBuilder.swift
│   ├── ButtonBuilder.swift
│   ├── Date+.swift
│   ├── LoginButton.swift
│   ├── RemoteDBError.swift
│   └── ViewControllerFactory.swift
├── Scene
│   ├── LoginView
│   │   ├── LoginViewController.swift
│   │   └── LoginViewModel.swift
│   ├── SchedulePreview.swift
│   └── ScheduleView
│       ├── Components
│       │   ├── ScheduleCell.swift
│       │   ├── ScheduleCellViewModel.swift
│       │   └── ScheduleHeaderView.swift
│       ├── ScheduleViewController.swift
│       └── ScheduleViewModel.swift
├── Service
│   ├── LoginService.swift
│   ├── Protocol
│   │   └── ScheduleServiceable.swift
│   ├── Schedule.swift
│   └── ScheduleService.swift
├── Repository
│   ├── DefaultRepository.swift
│   ├── Protocol
│   │   └── Repository.swift
│   └── ScheduleEntity.swift
├── AppDelegate.swift
├── SceneDelegate.swift
├── Config.xcconfig
├── Info.plist
└── Assets.xcassets
    ├── AccentColor.colorset
    │   └── Contents.json
    ├── AppIcon.appiconset
    │   ├── 1024.png
    │   ├── 114.png
    │   ├── 120.png
    │   ├── 180.png
    │   ├── 29.png
    │   ├── 40.png
    │   ├── 57.png
    │   ├── 58.png
    │   ├── 60.png
    │   ├── 80.png
    │   ├── 87.png
    │   └── Contents.json
    ├── facebook.imageset
    │   ├── Contents.json
    │   ├── f_logo_RGB-White_144.png
    │   ├── f_logo_RGB-White_250.png
    │   └── f_logo_RGB-White_72.png
    ├── kakao.imageset
    │   ├── Contents.json
    │   ├── kakao_l.png
    │   ├── kakao_m.png
    │   └── kakao_s.png
    └── Contents.json
```
</details>

## ⏰ 타임라인

#### 👟 2023/02/06
- 기술스택 결정
    - ✅ 요구사항과 현재 상황에 가장 적합하다 판단되는 기술스택 결정
- 프로젝트 기본 사항 설정
- 의존성 관리도구를 활용해 외부 라이브러리 설치

#### 👟 2023/02/07
- 외부 라이브러리 설치
    - ✅ Facebook, Kakao, Firebase 설치
- Repository 구현
    - ✅ Repository Protocol 구현
    - ✅ DefaultRepository 구현

#### 👟 2023/02/08
- Service 구현
    - ✅ ScheduleService Protocol 구현
    - ✅ ScheduleService 구현
    - ✅ LoginService 구현
- ViewModel 구현
    - ✅ ScheduleViewModel 구현
- View 구현
    - ✅ 커스텀 로그인 버튼 구현

#### 👟 2023/02/09
- Login 구현
    - ✅ Facebook Auth 로그인 구현
    - ✅ Kakao OpenID 로그인 구현
    - ✅ 각 로그인을 통해 받아온 uid로 Firebase Auth 로그인 구현
- View 구현
    - ✅ 로그인 화면 문구, 앱아이콘, 글꼴 구현

#### 👟 2023/02/11
- ViewModel 구현
    - ✅ 두번째 뷰 구현
    - ✅ 각 상황에 필요한 빌더 패턴과 팩토리 메서드 패턴 구현
- View 구현
    - ✅ 앱의 톤엔 매너를 일치시키기 위한 디자인 구현

### 🫠 미구현
- 스케쥴을 추가하고 상세 스케쥴을 관리할 수 있는 세번째 뷰 미구현
- 원격DB 및 로그인 중 발생하는 전반적인 에러 핸들링 
---

[⬆️ 맨 위로 이동하기](#-gyro-data)


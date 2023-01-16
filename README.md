[![Swift 5.7](https://img.shields.io/badge/swift-5.7-ED523F.svg?style=flat)](https://swift.org/download/) [![Xcode 14.1](https://img.shields.io/badge/Xcode-14.1-ED523F.svg?style=flat&color=blue)](https://swift.org/download/)

# PersonalSchedular  

> 프로젝트 기간: 2023.01.09 - 2023.01.13
> 일정 및 스케줄을 기록하는 앱

&nbsp;


&nbsp;

## 💻 개발자 소개

|예톤|
|:-:|
|<img src="https://avatars.githubusercontent.com/u/98514397?v=4" width="200">|
|- FirebaseManager 구현</br>- 로그인 기능 구현</br>- Combine을 이용한 binding 구현</br>- MVVM 아키텍처 사용|

&nbsp;

## 목차

* [파일 디렉토리 구조](#-파일-디렉토리-구조)
* [기술 스택](#-기술-스택)
* [기능 및 UI](#-기능-및-ui)
* [설계 및 구현](#-설계-및-구현)
* [실행 화면](#-실행-화면)
* [기술적 도전](#-기술적-도전)
    * [Combine](#combine)
    * [Firebase-FireStore](#firebase-firestore)
* [고민했던 점](#-고민했던-점)
    * [처음 구현해본 로그인 기능](#-처음-구현해본-로그인-기능)

## 🗂 파일 디렉토리 구조

```
PersonalScheduler
│   ├── GoogleService-Info.plist
│   ├── Info.plist
│   ├── PersonalScheduler.entitlements
│   ├── Presentation
│   │   ├── View
│   │   │   ├── CreateEmailViewController.swift
│   │   │   ├── FacebookLoginViewController.swift
│   │   │   ├── KakaoLoginViewController.swift
│   │   │   ├── LoginViewController.swift
│   │   │   ├── MainViewController.swift
│   │   │   ├── SchedularViewController.swift
│   │   │   └── WritingScheduleViewController.swift
│   │   └── ViewModel
│   │       ├── ScheduleCell.swift
│   │       └── ScheduleViewModel.swift
│   └── Sources
│       └── Repositories
│       │   ├── FirebaseManager.swift
│       │   ├── KakaoLoginManager.swift
│       │   └── Model
│       │       └── Schedule.swift
│       ├── App
│       │   ├── AppDelegate.swift
│       │   └── SceneDelegate.swift
│       ├── Extensions
│       │   ├── Date+Extension.swift
│       │   ├── Encodable+Extension.swift
│       │   ├── UIColor+Extension.swift
│       │   ├── UIFont+Extension.swift
│       │   └── UIStackView+Extension.swift
│       └── Repositories
│           ├── FirebaseManager.swift
│           ├── KakaoLoginManager.swift
│           └── Model
│               └── Schedule.swift
│   ├── Resources
│   │       └── LaunchScreen.storyboard


```

&nbsp;

## 🛠 기술 스택

* Swift/UIKit
* Combine

### 아키텍처

* MVVM
    * Input/Output Modeling

## 📱 기능 및 UI

|기능/UI|설명|
|:-|:-|
|로그인 화면|이메일로 로그인, 페이스북으로 로그인, 카카오로 로그인 할 수 있는 화면|
|이메일로 로그인/ 페이스북 로그인/ 카카오 로그인 화면|각각의 매체마다 아이디와 비밀번호를 입력할 수 있도록 하는 중간다리 역할의 화면|
|로그인 성공 화면|로그인에 성공할 시 사용자 이름을 보여주고 로그아웃 기능과 스케줄 목록을 확인할 수 있는 화면|
|스케줄 목록 화면|작성한 스케줄 목록을 테이블 뷰에 나타낸다. 제목, 내용, 오늘 기분, 날짜로 이루어져있다.|
|스케줄 작성 화면|제목,내용,오늘 기분, 날짜를 입력하는 화면을 구성했다. 저장을 누르면 FireStore DB에 저장한다.|

&nbsp;

## 💻 설계 및 구현

### MVVM + Combine 구조

&nbsp;

### 역할 분배

|class/struct|역할|
|:-|:-|
|`LoginViewController`|페이스북, 카카오, 이메일 로그인 가능한 화면|
|`CreateEmailViewController`|이메일과 비밀번호를 입력하여 로그인 하는 화면|
|`FacebookLoginViewController`|페이스북으로 로그인 하는 화면|
|`KakaoLoginViewController`|카카오로 로그인 하는 화면|
|`MainViewController`|로그인 중인 사용자의 이메일을 보여주고 스케줄작성으로 넘어가거나 로그아웃을 할 수 있는 화면|
|`SchedularViewController`|스케줄 목록을 보여주는 화면|
|`WritingScheduleViewController`|스케줄을 작성할 수 있는 화면|

&nbsp;

### Utilities
|class/struct|역할|
|:-|:-|
|`FirebaseManager`|FirebaseStore의 CRUD 기능을 하는 타입|
|`KakaoLoginManager`|카카오 로그인과 관련한 기능을 하는 타입|

&nbsp;


## 👀 실행 화면

> 👩‍💻 실행 화면

<img src="https://i.imgur.com/okOPFhG.gif" width="30%">

&nbsp;

> 📘 로그인 화면

<img src="https://i.imgur.com/Xc74Cz8.png" width="30%">

&nbsp;

> 📕 이메일 / 카카오 / 페이스북 로그인 화면

| 이메일 | 카카오 | 페이스북 |
|:-:|:-:|:-:|
|<img src="https://i.imgur.com/4CtfMR1.png" width="100%">|<img src="https://i.imgur.com/rUcsWQz.png" width="100%">|<img src="https://i.imgur.com/ThXPtIY.png" width="100%">|

&nbsp;

| 로그인 완료시  | 스케줄 목록 화면 | 스케줄 작성 화면 |
|:-:|:-:|:-:|
|<img src="https://i.imgur.com/1MuBPOf.png" width="100%">|<img src="https://i.imgur.com/XR0G728.png" width="100%">|<img src="https://i.imgur.com/cXHvt3F.png" width="100%">|

&nbsp;

## 💪🏻 기술적 도전

### Combine

연속된 escaping closure를 피하고, 선언형 프로그래밍을 통한 높은 가독성과 오퍼레이터들을 통한 효율적인 비동기 처리를 위해서 Combine을 사용하였다.


&nbsp;

### Firebase-FireStore

하나의 쿼리에 정렬과 필터링 모두 가능하여 복합적인 쿼리가 가능하고, 대용량 데이터가 자주 읽힐 때 사용하기 좋은 FireStore 데이터베이스를 사용하였다.

&nbsp;

## 😵‍💫 고민했던 점

### 👩‍💻 처음 구현해본 로그인 기능

- 로그인이 되는 원리는 무엇일까?
- 자동 로그인이 되도록 하려면 어떻게 해야 할까?
- 로그인시 이미 FireBase Auth에 계정이 존재할 경우에는 어떻게 처리를 해주어야 할까?

에 대해 고민을 했다.

**OAuth**는 사용자 인증 방식에 대한 업계 표준으로, id나 pw를 노출하지 않고 OAuth를 사용하는 업체의 API 접근 권한을 위임 받는다. 

페이스북으로 사용자가 로그인을 요청하면 페이스북을 페이스북 서비스 제공회사에 토큰을 요청하고, 페이스북 회사는 사용자에게 권한 위임을 확인해달라고 요청한다. 사용자가 위임을 승인하면 이때 페이스북은 토큰을 보내주게 된다.

따라서 이 어플은 사용자의 비밀번호와 아이디를 알지못하지만, 토큰을 부여받음으로써 페이스북의 사용자 정보에 접근할 수 있게 되는 것이다.
이런 토큰을 관리하는 것을 Firebase Auth에서 해주게 된다.


&nbsp;





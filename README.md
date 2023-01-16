###### tags: `README`

# Personal Scheduler

## 🙋🏻‍♂️ 프로젝트 소개
원티드 프리온 보딩 `Personal Scheduler` 앱 프로젝트 입니다.

> 프로젝트 기간: 2023-01-09 ~ 2022-01-13 (5일)

## 📑 목차

- [🧑🏻‍💻🧑🏻‍💻 개발자 소개](#-개발자-소개)
- [🔑 핵심기술](#-핵심기술)
- [🔭 프로젝트 구조](#-프로젝트)

<br>

## 🧑🏻‍💻🧑🏻‍💻 개발자 소개

|[웡빙](https://github.com/wongbingg)|
|:---:|
| <image src = "https://i.imgur.com/fQDo8rV.jpg" width="250" height="250">|


<br>
    
## 🔑 핵심기술
    
- **`MVVM`**
    - 데이터 관련 로직은 **ViewModel**, 뷰의 상태 관리는 **ViewContoller**, 뷰의 로직은 View로 MVVM 패턴을 사용해 이번 프로젝트를 진행해 보았습니다.

- **`DIContainer`**
    - 각 Scene에 필요한 의존성을 모두 가지는 DIContainer를 각 Coordinator로 주입시켜주어 사용 했습니다.

    
- **`Coordinator`**
    - 화면 전환 로직을 Coordinator 에서 처리하도록 구현 했습니다.
    - 화면 전환시 viewController에 필요한 viewModel과 viewModel에 필요한 의존성들을 주입해주는 과정을 Coordinator 에서 처리 하였습니다.


- **`디자인패턴`**
    - 옵저버블 패턴
        - MVVM 구현시 데이터 바인딩을 위해 옵저버블 패턴으로 구현을 해보았습니다.
    - 싱글톤 패턴
        - 데이터베이스로 사용하는 FirestoreManager 구현 시 하나의 인스턴스를 유지하기 위해 싱글톤 패턴을 적용했습니다.
- **`UI 구현`**
    - 코드 베이스 UI
    - 오토레이아웃
- **`데이터베이스`**
    - Firestore
- **`사용자인증`**
    - FirebaseAuth
    - Kakao Login
    - Facebook Login
- **`비동기처리`**
    - async - await
    - @escaping closure
    

<br>
    
## 🔭 프로젝트 구조
```
├── Application
│   ├── AppCoordinator.swift
│   ├── AppDelegate.swift
│   ├── DIContainer
│   │   ├── AppDIContainer.swift
│   │   ├── LoginSceneDIContainer.swift
│   │   └── ScheduleSceneDIContainer.swift
│   └── SceneDelegate.swift
├── Domain
│   ├── Entities
│   │   ├── LoginError.swift
│   │   ├── LoginInfo.swift
│   │   └── Schedule.swift
│   └── UseCase
│       ├── FacebookLoginUseCase.swift
│       ├── FirebaseAuthUseCase.swift
│       └── KakaoLoginUseCase.swift
├── Presentation
│   ├── LoginScene
│   │   ├── Flows
│   │   │   └── LoginFlowCoordinator.swift
│   │   ├── Login
│   │   │   ├── View
│   │   │   │   ├── LoginView.swift
│   │   │   │   ├── LoginViewController.swift
│   │   │   │   └── Subviews
│   │   │   │       ├── LabelSeparator.swift
│   │   │   │       └── LogoImageButton.swift
│   │   │   └── ViewModel
│   │   │       └── LoginViewModel.swift
│   │   └── Signin
│   │       ├── View
│   │       │   └── SigninViewController.swift
│   │       └── ViewModel
│   │           └── SigninViewModel.swift
│   └── ScheduleScene
│       ├── Flows
│       │   └── MainFlowCoordinator.swift
│       ├── ScheduleDetail
│       │   ├── View
│       │   │   ├── ScheduleDetailView.swift
│       │   │   └── ScheduleDetailViewController.swift
│       │   └── ViewModel
│       │       └── ScheduleDetailViewModel.swift
│       └── ScheduleList
│           ├── View
│           │   ├── ListCell.swift
│           │   ├── ScheduleCollectionView.swift
│           │   └── ScheduleListViewController.swift
│           └── ViewModel
│               └── ScheduleListViewModel.swift
├── Resources
│   ├── Assets.xcassets
│   │   ├── AccentColor.colorset
│   │   │   └── Contents.json
│   │   ├── AppIcon.appiconset
│   │   │   └── Contents.json
│   │   ├── Contents.json
│   │   ├── apple_custom.imageset
│   │   │   ├── Contents.json
│   │   │   └── apple_custom.png
│   │   ├── facebook_custom.imageset
│   │   │   ├── Contents.json
│   │   │   └── facebook_custom.png
│   │   ├── facebook_login.imageset
│   │   │   ├── Contents.json
│   │   │   └── facebook_login.png
│   │   ├── kakao_custom.imageset
│   │   │   ├── Contents.json
│   │   │   └── kakao_custom.png
│   │   ├── kakao_login_large_wide.imageset
│   │   │   ├── Contents.json
│   │   │   └── kakao_login_large_wide.png
│   │   ├── kakao_login_medium.imageset
│   │   │   ├── Contents.json
│   │   │   └── kakao_login_medium.png
│   │   └── kakao_login_medium_wide.imageset
│   │       ├── Contents.json
│   │       └── kakao_login_medium_wide.png
│   ├── Base.lproj
│   │   └── LaunchScreen.storyboard
│   └── Info.plist
├── Services
│   ├── FacebookLoginService.swift
│   ├── FireStoreManager.swift
│   ├── FirebaseAuthService.swift
│   └── KakaoLoginService.swift
└── Utils
    ├── AlertBuilder.swift
    ├── Coordinator.swift
    ├── DateManager.swift
    ├── Extension
    │   └── UITextField+.swift
    ├── LoginCacheManager.swift
    └── Observable.swift
```


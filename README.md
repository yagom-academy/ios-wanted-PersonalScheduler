# Personal Scheduler
- oAuth를 활용한 사용자 로그인 기능
- 사용자의 스케쥴을 관리

## 🌱 팀 소개
 |[미니](https://github.com/leegyoungmin)|
 |:---:|
|<a href="https://github.com/leegyoungmin"><img height="150" src="https://i.imgur.com/pcJY2Gn.jpg"></a>|


## 💾 개발환경 및 라이브러리
![Badge](https://img.shields.io/badge/UIKit-UI_Configure-informational?style=for-the-badge&logo=Swift&logoColor=white)

![Badge4](https://img.shields.io/badge/MVVM-Architecture-success?style=for-the-badge)

![Badge2](https://img.shields.io/badge/Firebase-Remote_DataBase-yellow?style=for-the-badge)

## 🗂 폴더 구조
```bash!
├── Application
├── Data
│   ├── Model
│   │   ├── Errors
│   │   │   └── StoreError.swift
│   │   └── Schedule.swift
│   └── Repositories
│       ├── LoginRepository
│       │   ├── AppleLoginRepository.swift
│       │   ├── FacebookLoginRepository.swift
│       │   └── KakaoLoginRepository.swift
│       └── ScheduleRepository
│           ├── ScheduleDetailRepository.swift
│           ├── ScheduleListRepository.swift
│           └── ScheduleUserRepository.swift
├── Domain
│   ├── Repositories
│   │   └── LoginRepository.swift
│   └── Services
│       └── FirebaseAuthService.swift
├── Infrastructure
│   └── Utility
│       └── Extensions
│           ├── Date+Extension.swift
│           ├── FireStore+Extension.swift
│           ├── Previews.swift
│           ├── UIButton+Extension.swift
│           ├── UIControl+Extension.swift
│           ├── UIDatePicker+Extension.swift
│           ├── UITextField+Extension.swift
│           └── UITextView+Extension.swift
└── Presentation
    ├── Login
    │   ├── View
    │   │   ├── LoginView.swift
    │   │   ├── LoginViewController.swift
    │   │   └── SocialLoginButton.swift
    │   └── ViewModel
    │       └── LoginViewModel.swift
    ├── ScheduleDetail
    │   ├── View
    │   │   ├── ScheduleDetailViewController.swift
    │   │   └── Subviews
    │   │       ├── ScheduleDetailTitleView.swift
    │   │       └── ScheduleTextField.swift
    │   └── ViewModel
    │       └── ScheduleDetailViewModel.swift
    ├── ScheduleList
    │   ├── View
    │   │   ├── ScheduleListViewController.swift
    │   │   └── Subviews
    │   │       ├── ScheduleListCell.swift
    │   │       ├── ScheduleListTitleView.swift
    │   │       ├── ScheduleSegmentControlView.swift
    │   │       └── SegmentButton.swift
    │   └── ViewModel
    │       └── ScheduleListViewModel.swift
    └── Utility
        └── NavigationView.swift
```

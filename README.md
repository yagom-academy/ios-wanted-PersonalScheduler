## 프로젝트 소개

* 페이스북/카카오 계정으로 로그인 할 수 있는 개인 스케줄 관리 앱입니다. 
* 스케줄 정보(제목/실행 일시/본문)를 등록하거나 수정/삭제할 수 있습니다.
* 등록/수정/삭제된 스케줄 정보는 Firestore에 저장됩니다.
* **프로젝트 기간 : 2023-02-06 ~ 2023-02-12**

## 팀원

|<img src="https://camo.githubusercontent.com/a482a55a5f5456520d73f6c2debdd13375430060d5d1613ca0c733853dedacc0/68747470733a2f2f692e696d6775722e636f6d2f436558554f49642e706e67" width=160>|
|:--:|
|[junho](https://github.com/junho15)|

## 개발환경 및 라이브러리

![Swift](https://img.shields.io/badge/Swift-5.7.2-orange) ![Xcode](https://img.shields.io/badge/Xcode-14.2.0-pink) ![iOS](https://img.shields.io/badge/iOS-14.0-green) ![Firebase](https://img.shields.io/badge/Firebase-10.5.0-red) ![KakaoSDK](https://img.shields.io/badge/KakaoSDK-2.13.1-yello) ![FacebookSDK](https://img.shields.io/badge/FacebookSDK-14.1.0-blue)

## 실행 화면

|**페이스북 로그인**|**카카오톡 로그인**|
|:--:|:--:|
|![](https://i.imgur.com/sY0p6tL.gif)|![](https://i.imgur.com/YGRvxep.gif)|
|**등록**|**수정**|
|![](https://i.imgur.com/nTcl4GR.gif)|![](https://i.imgur.com/8pqeJZA.gif)|
|**삭제**|**로컬라이징**|
|![](https://i.imgur.com/e46Wd4n.gif)|<img src="https://i.imgur.com/4XhbYDa.png" width=300px>|

## 파일 구조

```
├── AppDelegate.swift
├── SceneDelegate.swift
├── GoogleService-Info.plist
├── Info.plist
├── Extensions
│   ├── Date+.swift
│   └── UILabel+.swift
├── Models
│   ├── FirestoreRepository.swift
│   ├── FirestoreService.swift
│   ├── FriestoreEntity.swift
│   └── Schedule.swift
├── Controllers
│   ├── EditViewController.swift
│   ├── ListViewController.swift
│   └── LoginViewController.swift
└── Views
    ├── DatePickerContentView.swift
    ├── ListContentView.swift
    ├── TextFieldContentView.swift
    └── TextViewContentView.swift
```
    

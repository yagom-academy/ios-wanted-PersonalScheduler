# Personal Scheduler ReadME

- Kyo가 만든 일정을 관리할 수 있는 Personal Scheduler App입니다.

## 목차
1. [소개](#팀-소개)
2. [실행 화면](#실행-화면)
3. [Diagram](#diagram)
4. [폴더 구조](#폴더-구조)
5. [타임라인](#타임라인)

## 소개
 |[Kyo](https://github.com/KyoPak)|
 |:---:|
| <img width="180px" img style="border: 2px solid lightgray; border-radius: 90px;-moz-border-radius: 90px;-khtml-border-radius: 90px;-webkit-border-radius: 90px;" src= "https://user-images.githubusercontent.com/59204352/193524215-4f9636e8-1cdb-49f1-9a17-1e4fe8d76655.PNG" >|


## 실행 화면

### ▶️ 로그인 실행화면
    
|**카카오 로그인**|**페이스북 로그인**|**데이터 추가,수정, 삭제**|
|:--:|:--:|:--:|
|<img src="https://i.imgur.com/sR0Bzc0.gif" width=300>|<img src="https://i.imgur.com/mwMbW8N.gif" width=300>|<img src="https://i.imgur.com/HLetQpH.gif" width=300>|

 
## 폴더 구조

```
PersonalScheduler
├── Resource
└── Source
    ├── Application
    │   ├── AppDelegate.swift
    │   └── SceneDelegate.swift
    ├── Model
    │   ├── Mode.swift
    │   ├── Process.swift
    │   ├── Schedule.swift
    │   └── Social.swift
    ├── Network
    │   └── FireStoreManager.swift
    ├── Scene
    │   ├── Detail
    │   │   ├── DetailViewController.swift
    │   │   └── ViewModel
    │   │       └── DetailViewModel.swift
    │   ├── List
    │   │   ├── ListViewController.swift
    │   │   ├── ScheduleTableViewCell.swift
    │   │   └── ViewModel
    │   │       ├── CellViewModel.swift
    │   │       └── ListViewModel.swift
    │   └── Login
    │       ├── LoginViewController.swift
    │       └── ViewModel
    │           └── LoginViewModel.swift
    └── Util
        ├── Extension
        │   └── DateFormatter+Extension.swift
        ├── FireBaseError.swift
        └── Protocol
            ├── Identifiable.swift
            └── Manageable.swift
```

##  타임라인
### 👟 Step 1

- 사용 기술 스택
    - ✅ MVVM
    - ✅ SPM
    - ✅ FireBaseStore
    - ✅ FireBase OIDC
    - ✅ Kakao Social Login
    - ✅ FaceBook Social Login


![](https://i.imgur.com/vCBUE8c.png)



## 파이어베이스 컬렉션 구성

컬렉션      도큐먼트      컬렉션           도큐먼트(새로운 데이터)   필드
Scedule -  kakao  -   User token  -        uuid           - 데이터

```
Collection ── Document ── Collection ── Document ── Field

Schdule ── kakao ── User token ── uuid ── Schedule Data
      |                      |
      |                      └─── uuid ── Schedule Data
      |
      └── facebook ── (other)User token ── uuid ── Schedule Data

```




|**컬렉션**|**도큐먼트**|**컬렉션**|**도큐먼트**|**필드**|
|:--:|:--:|:--:|:--:|:--:|
|Schedule|kakao|User token|uuid|Schedule Data|
||||(new)uuid|Schedule Data|
||facebook|user token|uuid|Schdule Data|

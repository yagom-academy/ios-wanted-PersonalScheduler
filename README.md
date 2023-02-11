# 🗓️ Personal Scheduler

## 🌱 소개
사용자의 일정을 관리하는 앱입니다.  
소셜 로그인 기능이 있으며 로그인 이후에 앱의 기능을 이용할 수 있습니다.  
한번했던 로그인 이후에 앱을 다시실행할때 자동으로 로그인이 되고 로그아웃 후에 다른 소셜로그인이 가능합니다.  
데이터는 원격 데이터베이스인 Firebase에 저장하며 가져옵니다.  
|<img src="https://avatars.githubusercontent.com/u/49121469" width=160>|
|:--:|
|[Mangdi](https://github.com/MangDi-L)|

❗️중요❗️  
[GoogleService_info.plist 파일 다운로드](https://drive.google.com/file/d/1b0NipX0212Oy9zRuWBzAUJROhJqLtmUK/view?usp=share_link)  
다운로드한 파일은 폴더 최상단에 위치하면 됩니다!  
<img width="290" alt="스크린샷 2023-02-12 오전 6 45 46" src="https://user-images.githubusercontent.com/49121469/218282447-e6a7019b-c107-48ee-abd8-8d2495612e61.png">

## 💻 개발환경
[![swift](https://img.shields.io/badge/swift-5.7.2-orange)]()
[![xcode](https://img.shields.io/badge/Xcode-14.2-blue)]()

## 🛒 사용 기술 스택
|UI구현|아키텍처|RemoteDB|의존성관리도구|
|:--:|:--:|:--:|:--:|
|UIKit|MVC|Firebase|CocoaPods|

## 📱 실행 화면

코드로 구현하기 전에 Figma로 UI를 먼저 구성해보았습니다.
|첫번째화면|두번째화면|세번째화면|
|:--:|:--:|:--:|
|<img width="239" alt="스크린샷 2023-02-12 오전 4 16 54" src="https://user-images.githubusercontent.com/49121469/218278012-9ad8e4f5-a2bd-4e0a-bae1-daf9dec34d08.png">|<img width="238" alt="스크린샷 2023-02-12 오전 4 17 07" src="https://user-images.githubusercontent.com/49121469/218278011-129a7843-e73a-4713-9623-6c8186b9d1de.png">|<img width="241" alt="스크린샷 2023-02-12 오전 4 17 15" src="https://user-images.githubusercontent.com/49121469/218278010-55911966-a986-4134-9701-ad50aa4f1b42.png">|

|카카오톡 로그인|카카오톡 자동로그인 및 로그아웃|
|:--:|:--:|
|![one](https://user-images.githubusercontent.com/49121469/218279461-a0509c53-99da-42d7-8f5c-531f7b3f81f8.gif)|![two](https://user-images.githubusercontent.com/49121469/218279465-1642506c-b13e-44d6-9cd1-218cb5a2b7db.gif)|
|**페이스북 로그인**|**페이스북 자동로그인 및 로그아웃**|
|![three](https://user-images.githubusercontent.com/49121469/218279470-afd4a4ff-9a6a-4f41-baa0-07f98576e04f.gif)|![four](https://user-images.githubusercontent.com/49121469/218279479-32c29bed-2e97-4456-9ad8-b6a706a46fba.gif)|

|스케쥴 추가하기 (오늘보다 날짜 크게)|
|:--:|
|![five](https://user-images.githubusercontent.com/49121469/218279480-f91e318e-d2df-4fa9-88ad-5d20eeed624d.gif)|
|**스케쥴 추가하기 (오늘보다 날짜 작게)**|
|![six](https://user-images.githubusercontent.com/49121469/218279481-6c9ffa8d-8107-4ac3-abb1-3c07fccedc11.gif)|
|**스케쥴 수정하기 (-인날짜 +로 수정)**|
|![seven](https://user-images.githubusercontent.com/49121469/218279483-cc3d6bab-1068-433e-b6d4-676e44990c6c.gif)|
|**스케쥴 삭제**|
|![eight](https://user-images.githubusercontent.com/49121469/218279486-168bf08e-13aa-4cee-be2c-09f5500ebbd9.gif)|


## 😭 구현하지못한 부분
1. 애플 로그인
2. FCM, APNs를 이용한 푸시 알람 띄우기

> 애플 Developer Membership이 없어서 일단 우선순위를 뒤로 두로 다른기능들을 우선 개발했습니다. 제출마감까지 2시간남아서 결국 해보지못했습니다.
소셜로그인같은경우 애플로그인을 꼭 포함시켜서 개발해야하기때문에 필수로 구현해야하는 부분이라 공부해보겠습니다.
FCM과 APNs를 이용한 푸시 알람도 공부하겠습니다.


---

[🔝 맨 위로 이동하기](#-personal-scheduler)

---

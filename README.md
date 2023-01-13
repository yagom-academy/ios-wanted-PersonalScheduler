# 📆 PersonalScheduler

## 📜 프로젝트 및 개발자 소개
> **소개** : sns 로그인을 지원하고 일정을 추가, 수정, 삭제할 수 있는 앱 <br>**프로젝트 기간** : 2023.1.9 ~ 2023.1.13

| **제리** |
|:---:|
|<img src="https://i.imgur.com/DnKXXzd.jpg" width="300" height="300" />|
[Jerry_hoyoung](https://github.com/llghdud921)|

<br>

## 💡 키워드
- **Kakao, Apple Sign**
- **Firebase**
- **Keychain**
- **async await**
- **diffable datasource**

<br>

## 📱 구현 화면

|**카카오 로그인** | **애플 로그인** | 
| :--------: | :--------: |
|  <img src = "https://i.imgur.com/GM3QmkU.gif" width="300" height="600">|  <img src = "https://user-images.githubusercontent.com/40068674/212350278-ea3dc800-e004-4f4f-a6c9-eb43be60fa18.gif" width="300" height="600"> | 

|**자동로그인** | **일정 관리** | 
| :--------: | :--------: |
|  <img src = "https://i.imgur.com/c9xxgcX.gif" width="300" height="600">|  <img src = "https://i.imgur.com/YcXzdIv.gif" width="300" height="600"> | 

## 📱 FireStore data

![](https://i.imgur.com/4UPCPlk.png)
- `UserId`로 각 멤버의 id값을 지정하고 `schedules` Array에 일정을 저장하였습니다

<br>

## 🏛 프로젝트 구조

### MVVM

- **ViewModel** 
view에서 받은 이벤트를 가지고 데이터를 가공하여 UseCase에 전달
- **View**
사용자의 입력을 받아 ViewModel에 이벤트를 전달하고 ViewModel로부터 데이터를 가져와 화면에 출력
- **Model** 
 데이터 구조를 정의
 
### Obsevable을 이용한 데이터 바인딩

- MVVM 구조에서 `ViewModel`과 `View`의 데이터를 바인딩하기 위해 `Observable` 클래스를 구현하여 사용

### Clean Architecture 적용
#### Domain Layer
- Domain Layer내에는 비즈니스 로직이 있는 `UseCase`와 model type인 `Entity`, Data layer의 `Repository Interface`를 가지고 있습니다
- 저희 앱에서는 `Auth`, `Schedule`, `User` 총 세가지의 `UseCase`로 구성되어 있어 `Repository`에서 받아온 데이터를 가공하여 `ViewModel`에 전달하거나 다시 `Repository`로 전송하는 역할 등을 하고 있습니다
- `Repository` 객체가 아닌 `Interface`를 가지고 있어 의존성 역전을 통해 의존성을 없앴습니다

#### Data Layer
- Data Layer에서는 API 또는 Local storage로 접근하는 객체인 `Repository`를 가지고 있습니다
- 저희 앱에서는 네트워크를 하는 `Kakao`, `Apple`, `FireBase` 그리고 local storage인 `Keychain` 총 네가지의 Repository로 구성되어 있습니다

#### Storage
- 데이터 저장소인 `Storage` 객체는 `KeyChainStorage`, `FirebaseStorage`가 있으며 각 저장소에 접근할 수 있는 method로 구성되어 있습니다

<br>

## 👩🏻‍💻 코드 설명

### Async Await을 이용한 비동기 처리
- 기존에 사용하던 `completion handler`의 과도하게 중첩된 `callback` 메서드와 에러 핸들링 로직을 개선하기 위하여 `async await`을 이용하였습니다
- 보기쉬운 코드의 구조를 구성할 수 있었고 throws를 이용한 error handling으로 가독성이 향상되었습니다
- `kakao Login sdk`내 구성되어있던 `completion handler` 코드를 사용하는 경우 `withCheckedThrowingContinuation`를 활용하여 레거시 코드와 결합하는 방식을 익혔습니다  

### Diffable DataSource를 사용한 TableView
- `Reload`를 이용한 `tableView` 값 갱신 로직의 끊기는 animation을 개선하기 위하여 `diffable datasource`로 `tableView`내 데이터를 관리하였습니다 

### KeyChain
- Auth에서 가져온 `UserId`나 `access token`의 값을 안전하게 저장하기 위해 `KeyChain`을 활용하였습니다
- `KeyChain`에 접근하는 객체인 `KeyChainStorage`를 구현하였습니다

### FireStore
- `FireStore`를 이용하여 Remote DataBase를 구성하였습니다
- `Firebase`의 data에 접근하는 객체인 `FirebaseStorage`를 구현하였으며 `field`나 `document`를 `update`, `delete`, `add`할 수 있습니다 

<br>

## 📁 구현하지 못한 기능
- Facebook auth기능을 구현하지 못하였습니다
- FCM, APNS를 이용한 스케줄 알림 기능을 구현하지 못하였습니다

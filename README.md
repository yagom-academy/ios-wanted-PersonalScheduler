# PersonalScheduler 프로젝트
<img src="https://i.imgur.com/E6QY0KD.png" width="230"/> <img src="https://i.imgur.com/NE2B0Yy.png" width="230"/><img src="https://i.imgur.com/ejyH7g8.png" width="230"/>![]()

<br>

## 프로젝트 및 개발자 소개
> **소개** : 개인 스케줄을 등록하고 관리하는 앱입니다.<br>
> **프로젝트 기간** : 2022.01.8 ~ 2022.01.13<br>

| **[우롱차](https://github.com/dnwhd0112)** |
|:---:|
|<img src="https://avatars.githubusercontent.com/u/43274246?v=4" width="200">||

<br>

## 미구현 사항
애플 개발자 계정이 없어 OAuth를 통해 회원가입 불가 및 노티피케이션 알림 불가능.

## 테스트용 계정
facebook
email: xipainuwlv_1673603946@tfbnw.net
password: testpassword

### 우롱차

## 📱 구현 화면

|**메인 화면** | **리스트 화면** | **상세 화면** |
| -------- | -------- | -------- |
|![](https://i.imgur.com/20sD2UR.gif)|![](https://i.imgur.com/AwNiUb3.gif)| ![](https://i.imgur.com/NBD7R9l.gif) |



<br>

## 폴더 구조
- **Entry**: AppDelegate과 SceneDelegate이 있습니다.
- **Model**: 네트워킹, 파이어베이스에 사용되는 모델입니다.
- **Network**: FierBase의 CRUD 로직과 Kakao, Facebook 계정연동시 필요한 로직을 포합합니다.
- **Domain**: 화면 별 구현사항을 포함합니다.
- **Extension**: 커스텀한 Extension의 집합입니다.
- **Error**: 정의된 에러타입이 있습니다.
- **Utility**: 정의된 Observable이 있습니다.

<br>

## 구현 내용

### 단방향 MVVM
내부 로직이 혼잡해지는 것을 방지하고자 로직의 흐름을 input과 output 처럼 **단방향**으로 제한했습니다. 이러한 형태를 ViewModelAble로 추상화하였습니다. ViewController에서 추상화 된 ViewModelAble로 ViewModel의 Newtork객체 모두 **의존성주입** 형태로 초기화하며 이러한 구조는 **테스트 코드 작성에도 용이**합니다.

### FireBase 데이터 구조
Firebase의 저장구조는 Key: Value 형태로 저장이 됩니다. 사용자로부터 카카오톡이나 페이스북에서 고유한 ID를 가져온뒤 이에 할당하는 UserID를 새로 발급해주었습니다. 이 아이디를 key 값으로 데이터를 저장합니다. 물론 저장되는 데이터도 고유한 UserId를 가집니다.이를 트리로 나타내면 다음과 같습니다.
![](https://i.imgur.com/ZV6axRd.png)

### firebaseDatable 구현
파이어 베이스의 데이터를 조회하는 경로를 protocol로 정의하고 원하는 데이터의 경로에 따라 다르게 조회할수 있게끔 구현하였습니다.

### Observable을 사용한 뷰처리
**Observable**을 사용하여 데이터에 따라 뷰가 알맞게 변경되게끔 구현하였습니다.

<br>


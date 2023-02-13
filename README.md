# 🗓 PersonalScheduler App ![iOS badge](https://img.shields.io/badge/Swift-F05138?style=flat&logo=Swift&logoColor=white) ![iOS badge](https://img.shields.io/badge/iOS-14.0%2B-blue)

> 👩🏻‍💻 2023.02.06~ 2023.02.12

**유저의 스케쥴을 관리할 수 있는 애플리케이션입니다.**
- SNS로그인을 사용합니다.
- 유저가 새로운 스케쥴을 등록/ 수정/ 삭제하며 스케쥴을 관리 할 수 있습니다.

---

## 📖 목차
1. [팀 소개](#-팀-소개)
2. [기능 소개](#-기능-소개)
3. [개발환경 및 적용기술](#-개발환경-및-적용기술)

---

## 🌱 팀 소개

- 1인 개발
 
|[써니쿠키](https://github.com/sunny-maeng)|
|:---:|
| <img width="180px" img style="border: 2px solid lightgray; border-radius: 90px;-moz-border-radius: 90px;-khtml-border-radius: 90px;-webkit-border-radius: 90px;" src="https://avatars.githubusercontent.com/u/107384230?v=4">|

---

## 📱 기능 소개
### 1. 로그인 화면
- 카카오, 페이스북 아이디를 연동해 로그인 할 수 있습니다.


|로그인 화면|로그인|
|:-:|:-:|
|<img src="https://i.imgur.com/Jr5DbWW.png" width="200" height="400"/>|<img src="https://i.imgur.com/29354G0.gif" width="200" height="400"/>|


### 2. 이벤트 리스트 화면
- 저장해놓은 이벤트들을 날짜 순으로 리스트로 보여줍니다. 
- 오늘 날짜에 해당하는 이벤트는 연두색으로 보여줍니다.
- 진행한 이벤트는 체크버튼으로 삭제할 수 있습니다.
- 이벤트를 스와이프해 삭제할 수 있습니다.

|리스트 화면|이벤트 완료|이벤트 삭제|
|:-:|:-:|:-:|
|<img src="https://i.imgur.com/QBnPmKN.png" width="200" height="400"/>|<img src="https://i.imgur.com/JO1yCLW.gif" width="200" height="400"/>| <img src="https://i.imgur.com/Fv1c3bc.gif" width="200" height="400"/>|

### 3. 이벤트 수정/등록 화면
- 이벤트 터치 시, 이벤트 디테일을 자세히 볼 수 있고, 수정이 가능합니다.
- +버튼을 터치해 NEW 이벤트롤 등록할 수 있습니다.

|이벤트 수정| 이벤트 수정 | NEW 이벤트 등록|
|:-:|:-:|:-:|
|<img src="https://i.imgur.com/oVftray.png" width="200" height="400"/>|<img src="https://i.imgur.com/wWBBEHB.gif" width="200" height="400"/>| <img src="https://i.imgur.com/BdsnDTA.gif" width="200" height="400"/>|


---

## 🛠 개발환경 및 적용기술
![iOS badge](https://img.shields.io/badge/Swift-V5.7-red) ![iOS badge](https://img.shields.io/badge/Xcode-V14.2-blue)

| UI  | RemoteDB | 의존성관리도구 | 아키텍처 |
| :--------: | :--------: | :--------: |  :--------: | 
| <img height = 70, src = "https://i.imgur.com/q6rTXrE.png">     | <img height = 70, src = "https://i.imgur.com/by0H2pU.png">    |  <img height = 70, src = "https://i.imgur.com/uIBJ8aO.png">     | <img height = 70, src = "https://i.imgur.com/ezwfWM7.png">     |
| UIKit |  Firebase |  SPM | MVVM |



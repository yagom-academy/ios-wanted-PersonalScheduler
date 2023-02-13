# 🗂️ Personal Scheduler

## 🗣 프로젝트 및 개발자 소개
>소개: 소셜로그인을 지원하는 스케줄링 메모 앱입니다.
프로젝트 기간 : 2023-02-06 ~ 2023-02-12


|[@zhilly](https://github.com/zhilly11)|
|:---:|
|<img src = "https://i.imgur.com/LI4k2B7.jpg" width=300 height=300>|

## 📱 실행화면

| 시작화면 | 스케줄링 메모화면 |
| :--------: | :--------: |
| <img src = "https://i.imgur.com/GL7Zrpi.jpg" width=300 height=600> | <img src = "https://i.imgur.com/sm9GNGe.jpg" width=300 height=600> | 

## ✏️ 구현 내용
- 카카오 로그인, 로그아웃
- 카카오 로그인 성공시 UserID와 UserEmail을 통한 Firebase 로그인
- 사용자 nickname을 Header로 하는 Schedule 화면 구현
- AppColor를 통해 사용자가 다크모드 여부와 관계없이 일정한 화면을 볼 수 있도록 구현했습니다.

## 🛠️ 적용기술

- `MVVM`
    - ViewController가 비대해지는 문제를 막고, 구현 간 코드수정 및 추후 유지보수에 용이하게 하기 위해 MVVM 패턴을 선택하였습니다.
    - Observable 객체를 통한 데이터 바인딩을 구현했습니다.
- `GitFlow`
    - 기능단위로 작업단위를 나누어 브랜치 전략을 세워 진행했습니다.


## 🚀 트러블 슈팅

### UIButton에 image 크기 조절
button 크기에 비해 image크기가 작게 나오던 현상이 있었습니다.
`contentVerticalAlignment`와 `contentHorizontalAlignment` 값을 변경해줘서 해당 문제를 해결했습니다.

```swift
    private let kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "kakao_login_large_wide"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
```

# Personal Scheduler

**기간: 2023/01/09 ~ 2023/01/13**

**제작인원 : 1명**

**제작자 소개:**

<img src="https://avatars.githubusercontent.com/u/67148595?v=4" alt="img" style="zoom: 10%;" />

**nickname: Neph**

**본명: 천수현**



# 앱 작동화면 및 설명

## [Onboarding](https://github.com/Neph3779/ios-wanted-PersonalScheduler/tree/main/PersonalScheduler/Presentation/OnboardingScene)

<img src="https://raw.githubusercontent.com/Neph3779/Blog-Image/forUpload/img/20230113212224.gif" alt="Simulator Screen Recording - iPhone 13 - 2023-01-13 at 21.13.08" style="zoom:33%;" />

- 앱의 화면을 미리 보여주어서 사용자의 로그인을 유도합니다.
- Facebook OAuth 로그인의 경우 해킹당한 페이스북 계정의 복구가 마지막날까지 되지 않아 구현하지 못했습니다.



## [Schedule 관리 화면](https://github.com/Neph3779/ios-wanted-PersonalScheduler/tree/main/PersonalScheduler/Presentation/ScheduleListScene)

| ![mainPage](https://raw.githubusercontent.com/Neph3779/Blog-Image/forUpload/img/20230113212554.PNG) | ![expandableTextView](https://raw.githubusercontent.com/Neph3779/Blog-Image/forUpload/img/20230113212600.PNG) | ![deleteWithLongPress](https://raw.githubusercontent.com/Neph3779/Blog-Image/forUpload/img/20230113212604.PNG) |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
|                          메인 화면                           |                 셀을 터치하여 전체 내용 보기                 |                    셀을 꾹 눌러 삭제하기                     |

- 상단의 달력을 통해 해당날짜로 이동할 수 있습니다.
- 오늘 버튼을 누르면 오늘 날짜로 이동합니다.
- 장기간 프로젝트의 경우 시간과 함께 날짜도 함께 노출됩니다.
- 셀을 터치하면 전체 내용이 보이도록 셀이 늘어납니다.
- 셀을 꾹 누르면 삭제 alert을 노출합니다.



## [Schedule 작성 화면](https://github.com/Neph3779/ios-wanted-PersonalScheduler/tree/main/PersonalScheduler/Presentation/ScheduleListScene)

| ![scheduleMaking](https://raw.githubusercontent.com/Neph3779/Blog-Image/forUpload/img/20230113214008.PNG) | ![errorMessage](https://raw.githubusercontent.com/Neph3779/Blog-Image/forUpload/img/20230113212845.PNG) | ![notification](https://raw.githubusercontent.com/Neph3779/Blog-Image/forUpload/img/20230113212851.PNG) |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
|                   유동적으로 조절되는 화면                   |                 잘못된 시간 설정 Error Alert                 |                           앱 알림                            |

- 제목, 내용, 일정의 시작 시간과 끝마치는 시간 설정하여 일정을 생성할 수 있습니다.
- 내용은 450자가 넘어가면 500자 제한 경고문구를 보여주고, 500자가 넘어가면 더이상 입력되지 않습니다.
- 시간 설정은 시작시간과 종료시간을 직관적으로 파악할 수 있는 UI를 통해 설정할 수 있습니다. 
  - 사용자 편의성을 위해 1분 단위가 아닌, 5분단위로 시간을 조절하도록 설정하였습니다.
- 시작시간이 종료시간보다 뒤라면 에러 문구를 보여줍니다.
- 시작시간이 되면 앱에 알림이 발송됩니다.



# 적용한 아키텍쳐: Clean Architecture

![image-20230113214316524](https://raw.githubusercontent.com/Neph3779/Blog-Image/forUpload/img/20230113214316.png)

- 클린 아키텍쳐의 핵심인 Domain, Presentation, Data Layer의 구분이 이루어졌습니다.
- 의존성 주입을 관리하기 위해 DIContainer를 사용하였습니다.
- 화면 전환을 관리하기 위해 Coordinator를 사용하였습니다.
- APIKey 폴더의 경우 외부에 노출되지 않도록 gitignore에 추가하였습니다.

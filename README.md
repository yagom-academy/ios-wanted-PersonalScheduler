# PersonalScheduler
- 구현 기능
  - 
  - SplashVC를 통해 유저가 로그인한 적이 있는지 확인 후 결과에 따른 뷰 이동
  - Kakao 로그인 -> Firebase에도 계정 생성 -> User DB 생성
  - 유저의 스케줄을 FireSotre에서 불러와 TableView에 보여주기
  - 유저 스케줄 생성
  - 유저 스케줄 편집
  - 현재 시간에 따른 Cell 배경색 변경
- 구현하지 못한 기능
  -
  - FacaeBook Login 페이스북 로그인은 페이스북 개발자 사이트에 접속을 하여야하는데 FacecBook 계정인증 처리가 늦어 하지 못하였습니다. 
  조금더 일찍 인증을 시작했다면 페이스북 로그인을
  구현해볼 수 있었을 것 같아 너무 아쉽고 스케줄을 제대로 짜지 못해 일어난 일이라 다음엔 개발 일정을 더 체계적으로 잡아야 할 것 같습니다.
  
    <img width="500" alt="스크린샷 2023-01-13 오후 3 14 12" src="https://user-images.githubusercontent.com/81068345/212252808-911ed007-41ba-4034-9470-0bd964cc1409.png">
  - Apple Login, RemotePush 이는 개발자 계정 등록을 아직 하지 않아 수행 못하였습니다. 이 과정으로 개발자 계정의 필요성과 개발자 계정이 있어야만 기능을
  알게 되었습니다.
  
- 적용 패턴
  - 
  - MVVM (Model-View-ViewModel) 나중에 생기는 데이터를 대비하기 위해 Dynamic 타입을 구현해 적용하였습니다.
  
    <img width="500" alt="스크린샷 2023-01-13 오후 3 36 38" src="https://user-images.githubusercontent.com/81068345/212253761-bd91a499-7fc2-4b27-a860-963b4981a66d.png">

- FireStore 구조
  - <img width="927" alt="스크린샷 2023-01-13 오후 3 43 45" src="https://user-images.githubusercontent.com/81068345/212254816-9c6a69aa-8768-4318-86cb-e133215f44d4.png">

- 앱 실행 영상
  - 
  - LoginView
  
    https://user-images.githubusercontent.com/81068345/212256164-5203bf4e-832b-46b0-ae69-e48312fde2a4.mov
    
  - ScheduleListView && Add
  
    https://user-images.githubusercontent.com/81068345/212257760-7a05b883-0e2a-414b-9d26-a2d97d9a5246.MP4

  - Edit && Delete
  
    https://user-images.githubusercontent.com/81068345/212256815-8072a285-b7e7-4ade-ba5f-99a23a53a765.MP4
  
  - SplashView
  
    https://user-images.githubusercontent.com/81068345/212256990-3ae8c531-c9dc-4d8a-b307-fb4f5aa9665e.mov



  
  
  
    


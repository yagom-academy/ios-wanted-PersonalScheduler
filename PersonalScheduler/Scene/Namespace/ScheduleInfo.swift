//
//  ScheduleInfo.swift
//  PersonalScheduler
//
//  Created by Judy on 2023/01/11.
//

enum ScheduleInfo {
    enum Notice {
        static let emptyScheduleList = "저장된 일정이 없습니다."
        static let startScheduleManagement = "일정 관리 시작하기"
        static let autoLogin = "한 번 로그인하면 이후 자동 로그인 됩니다."
    }
    
    enum NavigationTitle {
        static let newSchedule = "새로운 일정"
        static let scheduleList = "일정 목록"
    }

    enum Edit {
        static let modify = "편집"
        static let save = "저장"
        static let allDay = "하루종일"
        static let openDate = "시작"
        static let endDate = "종료"
        static let notification = "알림"
        static let titlePlaceholder = "제목을 입력해주세요."
    }
}

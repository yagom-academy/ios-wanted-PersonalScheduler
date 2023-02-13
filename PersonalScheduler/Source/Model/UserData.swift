//  PersonalScheduler - UserData.swift
//  Created by zhilly on 2023/02/11

import Foundation

struct UserData {
    var schedules: [Schedule]
    
    static let sample: [Schedule] = [
        Schedule(title: "마트가서 장보기",
                 startingDate: Calendar.current.date(from: DateComponents(year: 2023, month: 2, day: 12, hour: 18)),
                 deadline: Calendar.current.date(from: DateComponents(year: 2023, month: 2, day: 12, hour: 19)),
                 body: """
                    1. 국재료
                    2. 반찬거리
                    3. 음료수
                    """),
        Schedule(title: "프로젝트 진행",
                 startingDate: Calendar.current.date(from: DateComponents(year: 2023, month: 2, day: 6, hour: 00)),
                 deadline: Calendar.current.date(from: DateComponents(year: 2023, month: 2, day: 11, hour: 24)),
                 body: """
                    1. 카카오 로그인 만들기
                    2. 파이어베이스 연결하기
                    3. 스케쥴 관리 화면 만들기
                    """),
        Schedule(title: "여행계획 세우기",
                 startingDate: nil,
                 deadline: Calendar.current.date(from: DateComponents(year: 2023, month: 2, day: 20, hour: 24)),
                 body: """
                    국내 여행은 어디로 가보는게 좋을까?
                    강릉, 부산, 제주도 빼고 전주? 경주?
                    맛집이 많고 볼거리도 많은 곳으로 정해야겠다.
                    """),
        Schedule(title: "취뽀",
                 startingDate: Calendar.current.date(from: DateComponents(year: 2023, month: 2, day: 13, hour: 00)),
                 deadline: Calendar.current.date(from: DateComponents(year: 2023, month: 3, day: 30, hour: 24)),
                 body: """
                    취업 뽀개기 프로젝트 시작
                    """)
    ]
}

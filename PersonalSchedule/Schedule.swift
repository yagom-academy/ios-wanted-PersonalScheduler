//
//  Schedule.swift
//  PersonalSchedule
//
//  Created by seohyeon park on 2023/01/13.
//

import Foundation

struct Schedule: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let date: String
    let body: String
    let emoji: String
}

struct Dummy {
    var dummy = [
        Schedule(title: "제목", date: "2022.01.13", body: "할일이 들어가는 부분할일이 들어가는 부분할일이 들어가는 부분할일이 들어가는 부분할일이 들어가는 부분할일이 들어가는 부분", emoji: "🥳"),
        Schedule(title: "제목", date: "2022.01.13", body: "할일이 들어가는 부분", emoji: "📚"),
        Schedule(title: "제목", date: "2022.01.13", body: "할일이 들어가는 부분", emoji: "⭐️"),
        Schedule(title: "제목", date: "2022.01.13", body: "할일이 들어가는 부분", emoji: "💡"),
        Schedule(title: "제목", date: "2022.01.13", body: "할일이 들어가는 부분", emoji: "🎬"),
        Schedule(title: "제목", date: "2022.01.13", body: "할일이 들어가는 부분", emoji: "🐶"),
        Schedule(title: "제목", date: "2022.01.13", body: "할일이 들어가는 부분", emoji: "🐸"),
        Schedule(title: "제목", date: "2022.01.13", body: "할일이 들어가는 부분", emoji: "🐣"),
        Schedule(title: "제목", date: "2022.01.13", body: "할일이 들어가는 부분", emoji: "🙊"),
        Schedule(title: "제목", date: "2022.01.13", body: "할일이 들어가는 부분", emoji: "😈"),
        Schedule(title: "제목", date: "2022.01.13", body: "할일이 들어가는 부분", emoji: "👻"),
        Schedule(title: "제목", date: "2022.01.13", body: "할일이 들어가는 부분", emoji: "👾"),
        Schedule(title: "제목", date: "2022.01.13", body: "할일이 들어가는 부분", emoji: "💄"),
        Schedule(title: "제목", date: "2022.01.13", body: "할일이 들어가는 부분", emoji: "🍎"),
        Schedule(title: "제목", date: "2022.01.13", body: "할일이 들어가는 부분", emoji: "🥑")
    ]
}

//
//  ScheduleServiceable.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/08.
//

protocol ScheduleServiceable {
    func requestAllSchedule(from userID: String, completion: @escaping ((Result<[Schedule], RemoteDBError>) -> Void))
    func requestSchedule(
        from userID: String,
        at documentID: String,
        completion: @escaping ((Result<Schedule, RemoteDBError>) -> Void)
    )
    func requestScheduleUpdate(
        from userID: String,
        at schedule: Schedule,
        completion: @escaping ((Result<Void, RemoteDBError>) -> Void)
    )
    func requestScheduleCreate(
        from userID: String,
        at schedule: Schedule,
        completion: @escaping ((Result<Void, RemoteDBError>) -> Void)
    )
    func requestScheduleDelete(
        from userID: String,
        at schedule: Schedule,
        completion: @escaping ((Result<Void, RemoteDBError>) -> Void)
    )
}

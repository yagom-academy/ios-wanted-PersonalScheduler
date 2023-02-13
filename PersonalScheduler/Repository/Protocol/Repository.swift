//
//  Repository.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/07.
//

protocol Repository {
    func read(
        from userID: String,
        documentID: String,
        completion: @escaping ((Result<ScheduleEntity, RemoteDBError>) -> Void)
    )
    func readAll(
        from userID: String,
        completion: @escaping ((Result<[ScheduleEntity], RemoteDBError>) -> Void)
    )
    func create(
        from userID: String,
        at schedule: Schedule,
        completion: @escaping ((Result<Void, RemoteDBError>) -> Void)
    )
    func update(
        from userID: String,
        at schedule: Schedule,
        completion: @escaping ((Result<Void, RemoteDBError>) -> Void)
    )
    func delete(
        from userID: String,
        at schedule: Schedule,
        completion: @escaping ((Result<Void, RemoteDBError>) -> Void)
    )
}

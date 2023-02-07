//
//  Repository.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/07.
//

enum RepositoryError: Error {
    case notFound(Error)
    case wrongGettingDocument(Error)
    case failedUpdate
}

protocol Repository {
    func read(
        from userID: String,
        documentID: String,
        completion: @escaping ((Result<ScheduleEntity, RepositoryError>) -> Void)
    )
    func readAll(
        from userID: String,
        completion: @escaping ((Result<[ScheduleEntity], RepositoryError>) -> Void)
    )
    func create(
        from userID: String,
        at schedule: Schedule,
        completion: @escaping ((Result<Void, RepositoryError>) -> Void)
    )
    func update(
        from userID: String,
        at schedule: Schedule,
        completion: @escaping ((Result<Void, RepositoryError>) -> Void)
    )
    func delete(
        from userID: String,
        at schedule: Schedule,
        completion: @escaping ((Result<Void, RepositoryError>) -> Void)
    )
}

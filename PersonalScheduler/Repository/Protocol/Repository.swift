//
//  Repository.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/07.
//

enum RepositoryError: Error {
    case notFound(Error)
    case wrongGettingDocument(Error)
    case decoderError
    case failUpdate
}

protocol Repository {
    func read(with userID: String, id: String, completion: @escaping ((Result<ScheduleDTO, RepositoryError>) -> Void))
}

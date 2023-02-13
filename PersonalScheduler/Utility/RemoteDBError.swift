//
//  RemoteDBError.swift
//  PersonalScheduler
//
//  Created by Wonbi on 2023/02/08.
//

enum RemoteDBError: Error {
    case failedCreate(Error)
    case failedRead(Error)
    case failedUpdate(Error)
    case failedDelete(Error)
}

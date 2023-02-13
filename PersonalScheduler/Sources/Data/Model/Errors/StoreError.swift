//
//  StoreError.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

enum StoreError: Error {
    case writeError
    
    case notFoundUserid
    case decodeSnapshotError
}

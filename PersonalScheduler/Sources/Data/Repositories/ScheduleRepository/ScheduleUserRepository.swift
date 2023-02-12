//
//  ScheduleUserRepository.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import FirebaseFirestore
import FirebaseFirestoreSwift

final class ScheduleUserRepository {
    private let authService: LoginService
    private var dataBase: CollectionReference
    private var userId: String = ""
    
    init(authService: LoginService, dataBaseName: String) {
        self.authService = authService
        self.dataBase = Firestore.firestore().collection(dataBaseName)
    }
    
    func writeUserSchedule(documentId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        print("/\(documentId)/key:(\(documentId))")
        dataBase
            .document(authService.userId)
            .collection(documentId)
            .addDocument(data: ["key": documentId]) { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                completion(.success(()))
                return
            }
    }
}

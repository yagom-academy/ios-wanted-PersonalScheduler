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
        dataBase
            .document(authService.userId)
            .updateData([
                "schedules": FieldValue.arrayUnion([documentId])
            ])
    }
}

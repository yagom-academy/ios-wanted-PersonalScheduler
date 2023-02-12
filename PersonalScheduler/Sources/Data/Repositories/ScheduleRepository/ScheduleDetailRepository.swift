//
//  ScheduleDetailRepository.swift
//  PersonalScheduler
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ScheduleDetailRepository {
    var dataBase: CollectionReference
    
    init(dataBaseName: String) {
        self.dataBase = Firestore.firestore().collection(dataBaseName)
    }
    
    func readData(documentName: String) -> AnyPublisher<Schedule?, Error> {
        return dataBase.document(documentName).toAnyPublisher()
    }
}

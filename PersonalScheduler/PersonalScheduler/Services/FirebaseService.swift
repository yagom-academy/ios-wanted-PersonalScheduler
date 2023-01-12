//
//  FirebaseService.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

import Foundation
import FirebaseFirestore

final class FirebaseService {

    static let shared = FirebaseService()
    let database = Firestore.firestore()
    var isNewUser = false
    
    private init() { }
    
}

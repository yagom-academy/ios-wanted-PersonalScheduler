//
//  ScheduleFireStore.swift
//  PersonalScheduler
//
//  Created by bard on 2023/01/13.
//

import FirebaseFirestore
//import FirebaseFirestoreSwift

final class ScheduleFireStore {

    // MARK: Properties
    
    private var database = Firestore.firestore()
    
    // MARK: - Methods
    
    func create(with user: User) {
        let path =  database.collection(user.email).document("ScheduleList")
        path.setData(["Schdule": FieldValue.arrayUnion([])])

        user.scehdule.forEach {
            path.updateData(["Schdule": FieldValue.arrayUnion([$0.dictionary])])
        }
    }
    
    func deleteSchedule(accountUID: String, uuid: String) {
        let user = User(
            email: "1234@asdf",
            scehdule: [Schedule(title: "", body: "Af", createDate: "Asdf"),
                       Schedule(title: "asdfa", body: "ASfd", createDate: "asdfsd")]
        )
        user.scehdule.forEach {
            database.collection(user.email).addDocument(data: $0.dictionary)
        }
    }
}


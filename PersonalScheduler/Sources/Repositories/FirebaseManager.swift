//
//  FirebaseManager.swift
//  BoxOffice
//
//  Created by 이예은 on 2023/01/03.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirebaseManager {
    static let shared = FirebaseManager()
    
    private init() {}
    
    private let database = Firestore.firestore()
    
    func save(schedule: Schedule) throws {
        let scheduleDictionary = try schedule.asDictionary()
        database.collection("schedular").document(schedule.id).setData(scheduleDictionary)
    }
    
    func update(schedule: Schedule) {
        do {
            let scheduleDictionary = try schedule.asDictionary()
            
            database.collection("schedular").document(schedule.id).setData(scheduleDictionary, merge: true)
        } catch let error {
            print(error)
        }
    }
    
    func delete(schedule: Schedule, completion: @escaping () -> Void) {
        database.collection("schedular").document(schedule.id).delete()
        completion()
    }
    
    func fetchAll(completionHandler: @escaping ([Schedule]) -> Void) {
        database.collection("schedular").getDocuments { (querySnapshot, error) in
            var schedules: [Schedule] = []
            
            if error == nil && querySnapshot != nil {
                guard let documents = querySnapshot?.documents else {
                    return
                }
                
                let decoder = JSONDecoder()
                
                for document in documents {
                    do {
                        let data = document.data()
                        let jsonData = try JSONSerialization.data(withJSONObject: data)
                        let schedule = try decoder.decode(Schedule.self, from: jsonData)
                        schedules.append(schedule)
                    } catch let error {
                        print(error)
                    }
                }
                completionHandler(schedules)
            }
        }
    }
}

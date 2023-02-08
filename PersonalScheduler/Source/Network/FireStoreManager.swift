//
//  FireStoreManager.swift
//  PersonalScheduler
//
//  Created by Kyo on 2023/02/07.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

/*
컬렉션      도큐먼트     컬렉션(날짜)    도큐먼트   필드
Scedule - kakao  -   kyo_키값  -  uuid  - 데이터
                              -  uuid  - 데이터
                   - other_키값 - uuid  - 데이터
*/

final class FireStoreManager {
    private let userKey: String
    private let social: String
    private let fireStoreDB: CollectionReference
    
    init(user: String, email: String, social: Social) {
        userKey = user + email
        self.social = "\(social)"
        fireStoreDB = Firestore.firestore().collection("Scedule")
    }
    
    func load(completion: @escaping ([Schedule]) -> Void) {
        var scedules: [Schedule] = []
        
        fireStoreDB.document(social).collection(userKey).getDocuments { querySnapshot, error in
            guard error == nil else { return }
            guard let snapshot = querySnapshot else { return }
            
            for document in snapshot.documents {
                do {
                    let data = try self.convertScedule(from: document)
                    scedules.append(data)
                } catch {
                    print(error)
                }
            }
            
            completion(scedules)
        }
    }

    func add(data: Schedule) {
        print(userKey)
        fireStoreDB
            .document(social)
            .collection(userKey)
            .document(data.id.description)
            .setData([
                "startDate": Timestamp(date: data.startDate),
                "endDate": Timestamp(date: data.endDate),
                "title": data.title,
                "content": data.content
            ])
    }
    
    func delete(data: Schedule) {
        fireStoreDB
            .document(social)
            .collection(userKey)
            .document(data.id.description)
            .delete()
    }
    
    private func convertScedule(from document: QueryDocumentSnapshot) throws -> Schedule {
        guard let id = UUID(uuidString: document.documentID),
              let startStamp = document.data()["startDate"] as? Timestamp,
              let endStamp = document.data()["endDate"] as? Timestamp else {
            throw FireBaseError.dataError
        }
        
        let title = document.data()["title"] as? String ?? ""
        let content = document.data()["content"] as? String ?? ""

        let startDate = startStamp.dateValue()
        let endDate = endStamp.dateValue()
        
        let data = Schedule(
            id: id,
            startDate: startDate,
            endDate: endDate,
            title: title,
            content: content
        )
        
        return data
    }
}

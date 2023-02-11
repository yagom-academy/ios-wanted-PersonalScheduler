//
//  FirebaseManager.swift
//  PersonalScheduler
//
//  Created by 써니쿠키 on 2023/02/09.
//

import Foundation
import Firebase

struct FirebaseManager: CRUDable {

    private let fireStore = Firestore.firestore()
    private let collectionName: String

    init(collectionName: String) {
        self.collectionName = collectionName
    }

    func create(_ event: Event) {
        let eventUuid = event.uuid.uuidString
        fireStore.collection(collectionName).document(eventUuid).setData(changeToFields(from: event))
    }

    func read(completion: @escaping (Result<[Event], Error>) -> Void) {
        fireStore.collection(collectionName).order(by: "date").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            var events: [Event] = []

            snapshot?.documents.forEach { document in
                events.append(changeToEvent(document))
            }

            completion(.success(events))
        }
    }

    func update(_ event: Event) {
        let eventUuid = event.uuid.uuidString
        fireStore.collection(collectionName).document(eventUuid).updateData(changeToFields(from: event))
    }

    func delete(_ event: Event) {
        let eventUuid = event.uuid.uuidString
        fireStore.collection(collectionName).document(eventUuid).delete()
    }

    func deleteAll() {
        read { result in
            switch result {
            case .success(let events):
                events.forEach { event in
                    self.delete(event)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func changeToFields(from event: Event) -> [String: Any] {
        return ["title": event.title ?? "",
                "date": Timestamp(date: event.date),
                "startTime": Timestamp(date: event.startTime),
                "endTime": Timestamp(date: event.endTime),
                "description": event.description ?? ""]
    }

    private func changeToEvent(_ document: QueryDocumentSnapshot) -> Event {
        let fields = document.data()
        let title = fields["title"] as? String ?? ""
        let date = (fields["date"] as? Timestamp)?.dateValue() ?? Date()
        let startTime = (fields["startTime"] as? Timestamp)?.dateValue() ?? Date()
        let endTime = (fields["endTime"] as? Timestamp)?.dateValue() ?? Date()
        let description = fields["description"] as? String ?? ""
        let uuid = UUID(uuidString: document.documentID) ?? UUID()

        return Event(title: title,
                     date: date,
                     startTime: startTime,
                     endTime: endTime,
                     description: description,
                     uuid: uuid)
    }
}

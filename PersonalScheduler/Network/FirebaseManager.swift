//
//  FirebaseManager.swift
//  ProjectManager
//
//  Created by 우롱차 on 2023/01/10..
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

protocol FirebaseManagerable {
    func create<T: FirebaseDatable>(_ data: T) throws
    func readAll<T: FirebaseDatable> (completion: @escaping (Result<[T],Error>) -> Void)
    func readOne<T: FirebaseDatable>(_ data: T, completion: @escaping (Result<T,Error>) -> Void)
    func update<T: FirebaseDatable>(updatedData: T) throws
    func delete<T: FirebaseDatable>(_ data: T) throws
    func observe<T: FirebaseDatable>(_: T.Type)
    var networkConnectionDelegate: NetworkConnectionDelegate? { get set }
    var firebaseEventObserveDelegate: FirebaseEventObserveDelegate? { get set }
}

protocol NetworkConnectionDelegate: AnyObject {
    func offline()
    func online()
}

protocol FirebaseEventObserveDelegate: AnyObject {
    func added(snapshot: DataSnapshot)
    func changed(snapshot: DataSnapshot)
    func removed(snapshot: DataSnapshot)
}

//: DatabaseManagerable
final class FirebaseManager: FirebaseManagerable {
    private var database: DatabaseReference
    weak var networkConnectionDelegate: NetworkConnectionDelegate?
    weak var firebaseEventObserveDelegate: FirebaseEventObserveDelegate?
    static let shared: FirebaseManagerable = FirebaseManager()
    
    private init(firebaseReference: DatabaseReference = Database.database().reference()) {
        database = firebaseReference
    }
    
    func observe<T: FirebaseDatable>(_: T.Type) {
        let observeRef = T.path.reduce(database) { database, path in
            database.child(path)
        }
        
        observeRef.observe(DataEventType.childAdded) { snapshot in
            self.firebaseEventObserveDelegate?.added(snapshot: snapshot)
        }
        
        observeRef.observe(DataEventType.childChanged) { snapshot in
            self.firebaseEventObserveDelegate?.changed(snapshot: snapshot)
        }
        
        observeRef.observe(DataEventType.childRemoved) { snapshot in
            self.firebaseEventObserveDelegate?.removed(snapshot: snapshot)
        }
    }
    
    func create<T: FirebaseDatable>(_ data: T) throws {
        guard let encodedValues = data.toDictionary else {
            return
        }
        
        let taskItemRef = data.detailPath.reduce(database) { database, path in
            database.child(path)
        }
        
        taskItemRef.setValue(encodedValues)
    }
    
    func readAll<T: FirebaseDatable>(completion: @escaping ((Result<[T],Error>) -> Void)) {
        var result: Result<[T], Error> = .failure(FirebaseError.readError)
        let taskItemRef = T.path.reduce(database) { database, path in
            database.child(path)
        }
        
        taskItemRef.getData { error, dataSnapshot in
            guard error == nil, let dataSnapshot = dataSnapshot
            else {
                completion(result)
                return
            }
            
            guard let childArray = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                completion(result)
                return
            }
            
            let array = childArray.compactMap { child in
                try? child.data(as: T.self)
            }
            result = .success(array)
            completion(result)
        }
    }
    
    func readOne<T: FirebaseDatable>(_ data: T, completion: @escaping ((Result<T,Error>) -> Void)) {
        var result: Result<T, Error> = .failure(FirebaseError.readError)
        let taskItemRef = getDetailPath(data: data)
        
        taskItemRef.getData { error, dataSnapshot in
            guard error == nil,
                  let dataSnapshot = dataSnapshot,
                  let encodedData = try? dataSnapshot.data(as: T.self)
            else {
                completion(result)
                return
            }
            result = .success(encodedData)
            completion(result)
        }
    }
    
    func update<T: FirebaseDatable>(updatedData: T) throws {
        guard let encodedValues = updatedData.toDictionary else {
            return
        }
        
        let taskItemRef = getDetailPath(data: updatedData)
        
        taskItemRef.updateChildValues(encodedValues)
    }
    
    func delete<T: FirebaseDatable>(_ data: T) throws {
        
        let taskItemRef = getDetailPath(data: data)
        
        taskItemRef.removeValue()
    }
    
    private func getDetailPath(data: FirebaseDatable) -> DatabaseReference {
        let taskItemRef = data.detailPath.reduce(database) { database, path in
            database.child(path)
        }
        return taskItemRef
    }
}

//
//  OAuthProvider.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

protocol OAuthProvider {
    
    var companyName: ProviderName { get }
    var originalUserID: String { get }
    
    func retrieveUserID() async
    func executeLogout()
    
}

extension OAuthProvider {
    
    func toFirebaseID() -> String {
        let firebaseID = companyName.description + originalUserID
        return firebaseID
    }
    
}

enum ProviderName {
    
    case kakao
    case facebook
    
    var description: String {
        switch self {
        case .kakao:
            return "kk"
        case .facebook:
            return "fb"
        }
    }
    
}

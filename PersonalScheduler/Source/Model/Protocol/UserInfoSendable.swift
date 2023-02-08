//
//  UserInfoSendable.swift
//  PersonalScheduler
//
//  Created by Dragon on 2023/02/08.
//

protocol UserInfoSendable {
    func sendUserInfo(id: String, password: String)
    func presentCreateUserInfoView()
}

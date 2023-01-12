//
//  PersonalSchedulerApp.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/11.
//

import SwiftUI

@main
struct PersonalSchedulerApp: App {
    
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            LoginView(loginViewModel: LoginViewModel())
        }
    }
    
}

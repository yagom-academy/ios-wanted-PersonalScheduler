//
//  FBLogView.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/13.
//

import SwiftUI
import FBSDKLoginKit

struct FBLog: UIViewRepresentable {
    
    func makeUIView(context: Context) -> FBLoginButton {
        let button = FBLoginButton()
        
        return button
    }
    
    func updateUIView(_ uiView: FBLoginButton, context: Context) { }

}

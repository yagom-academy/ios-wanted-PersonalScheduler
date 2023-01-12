//
//  ContentView.swift
//  PersonalSchedule
//
//  Created by seohyeon park on 2023/01/12.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    let loginStatusInfo: (Bool) -> String = { isLoggedIn in
        return isLoggedIn ? "로그인 상태" : "로그아웃 상태"
    }
    
    var body: some View {
        VStack {
            Text(loginStatusInfo(viewModel.isLoggedIn))
            Button {
                viewModel.handleKakaoLogin()
            } label: {
                Image("kakaoLogin")
                    .resizable()
                    .frame(width: 300, height: 50)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

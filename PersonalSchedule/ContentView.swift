//
//  ContentView.swift
//  PersonalSchedule
//
//  Created by seohyeon park on 2023/01/12.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()

    var body: some View {
                VStack {
                    Button {
                        viewModel.handleKakaoLogin()
                    } label: {
                        Image("kakaoLogin")
                            .resizable()
                            .frame(width: 300, height: 50)
                    }
                    .alert(Text("로그인 실패😭"), isPresented: $viewModel.isLogin) {
                        Button("확인") { }
                    } message: {
                        Text("로그인에 실패했습니다.")
                    }
                    .fullScreenCover(isPresented: $viewModel.isLogin) {
                        //SecondView()
                    }
                }
                .padding()
    }
}

struct SecondView: View {
    var body: some View {
        Text("두번째 뷰")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

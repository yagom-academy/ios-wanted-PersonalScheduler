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
//                VStack {
//                    Button {
//                        viewModel.handleKakaoLogin()
//                    } label: {
//                        Image("kakaoLogin")
//                            .resizable()
//                            .frame(width: 300, height: 50)
//                    }
//                    .alert(Text("로그인 실패😭"), isPresented: $viewModel.isLogin) {
//                        Button("확인") { }
//                    } message: {
//                        Text("로그인에 실패했습니다.")
//                    }
//                    .fullScreenCover(isPresented: $viewModel.isLogin) {
//                        SecondView()
//                    }
//                }
//                .padding()
        SecondView()
    }
}

struct SecondView: View {
    var body: some View {
        let data = Dummy()
        
        VStack {
            Text("Hey Manager")
                .font(.largeTitle)
            
            List {
                ForEach(data.dummy, id: \.self) { d in
                    Section(header: Text(d.date)) {
                        ScheduleList(schedule: d)
                    }
                }
            }
            .padding([.bottom], 50)
                .overlay (
                    Button {
                        print("추가")
                    } label: {
                        ZStack {
                            Image(systemName: "plus")
                                .font(.largeTitle)
                                .padding()
                                .clipShape(Circle())
                        }
                        .background(Color.yellow)
                        .clipShape(Circle())
                    }
                        .padding([.trailing], 30)
                    ,alignment: .bottomTrailing
                )
        }
        
    }
}

struct ScheduleList: View {
    let schedule: Schedule
    var body: some View {
        HStack {
            VStack {
                Text(schedule.emoji)
                    .font(.largeTitle)
            }
            VStack(alignment: .leading) {
                Text(schedule.title)
                    .font(.title2)
                    .foregroundColor(.blue)
                Text(schedule.body)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

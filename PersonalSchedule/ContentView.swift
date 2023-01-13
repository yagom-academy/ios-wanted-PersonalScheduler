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
    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack {
            Text("Hey Manager")
                .font(.largeTitle)
            NavigationView {
                List {
                    ForEach(viewModel.schedule.dummy, id: \.self) { schedule in
                        Section(header: Text(schedule.date.description)) {
                            NavigationLink {
                                DetailList(schedule: schedule, textManager: TextManager(target: schedule.body))
                            } label: {
                                ScheduleList(schedule: schedule)
                            }
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

struct DetailList: View {
    @State var schedule: Schedule
    @StateObject var textManager: TextManager
    
    var body: some View {
        VStack {
            HStack() {
                Section {
                    TextField("❔", text: $schedule.emoji)
                }
                .frame(width: 25)
                .padding()
                .background(Color.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 2))
                
                Section {
                    TextField("스케줄명", text: $schedule.title)
                }
                .padding()
                .background(Color.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 2))
            }.padding([.leading, .trailing], 15)
            
            HStack() {
                Section {
                    DatePicker("📆 날짜", selection: $schedule.date, displayedComponents: [.date])
                }
                .padding()
                .background(Color.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 2))
            }.padding([.leading, .trailing], 15)
            
            VStack() {
                HStack(spacing: 265) {
                    Text("메모")
                        .foregroundColor(.gray)
                    Text("\(textManager.target.count)/500")
                        .foregroundColor(.gray)
                }
                
                TextEditor(text: $textManager.target)
                    .border(.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 2))
            }.padding([.leading, .trailing], 15)
            
            HStack() {
                Section {
                    Button {
                        // TODO: 내용 저장
                    } label: {
                        Text("저장하기")
                    }
                }
                .padding()
                .background(Color.yellow)
                .clipShape(Capsule())
            }.padding([.leading, .trailing], 15)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class TextManager: ObservableObject {
    @Published var target: String = "" {
        didSet {
            if target.count > 500 {
                let currentText = target.map { String($0) }
                let limitedText = Array(currentText[0..<500]).joined()
                target = limitedText
            }
        }
    }
    
    init(target: String) {
        self.target = target
    }
}

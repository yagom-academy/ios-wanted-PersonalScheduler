//
//  ScheduleAddView.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/11.
//

import SwiftUI

struct ScheduleAddView: View {
    
    var isEditMode: Bool = false
    var accountUID: String = ""
    var uuid: String = ""
    
    @Environment(\.presentationMode) var presentationMode

    @StateObject var scheduleAddViewModel = ScheduleAddViewModel()

    @State var isActiveAlert: Bool = false
    @State var title: String = ""
    @State var description: String = ""
    @State var startTimeStamp: Date = Date()
    @State var endTimeStamp: Date = Date()

    @State private var totalChars: Int = 0
    @State private var lastText: String = ""
    
    var body: some View {
        VStack {
            TextField("제목을 입력해주세요.", text: $title)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            DatePicker(selection: $startTimeStamp,
                       displayedComponents: [.date, .hourAndMinute]) {
                Text("시작 날짜")
            }
            DatePicker(selection: $endTimeStamp,
                       in: startTimeStamp...,
                       displayedComponents: [.date, .hourAndMinute]) {
                Text("종료 날짜")
            }
            
            ZStack {
                TextEditor(text: $description)
                    .frame(minHeight: 200, maxHeight: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.secondary, lineWidth: 1)
                    )
                    .onChange(of: description) { text in
                        totalChars = text.count
                        
                        if totalChars <= 500 {
                            lastText = description
                        } else {
                            description = lastText
                        }
                    }
                if description.isEmpty {
                    Text("내용을 작성해주세요. (500자 이내)")
                        .foregroundColor(Color.secondary)
                        .padding(.top, 5)
                        .padding(.leading, 5)
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .topLeading)
                }
            }
            Text("Chars: \(totalChars) / 500")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .navigationBarTitle(isEditMode == false ? "등록 화면" : "편집 화면")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                isActiveAlert.toggle()
            } label: {
                Text("저장")
            }
        }
        .alert(isPresented: $isActiveAlert) {
            switch scheduleAddViewModel.buttonAlert {
            case .postCheck:
                let alert = Alert(
                    title: Text("저장 하시겠습니까?"),
                    primaryButton: .default(Text("확인"), action: {
                        if isEditMode {
                            scheduleAddViewModel.editSchedule(
                                accountUID: accountUID,
                                uuid: uuid,
                                title: title,
                                description: description,
                                startTimeStamp: startTimeStamp,
                                endTimeStamp: endTimeStamp
                            )
                        } else {
                            scheduleAddViewModel.postSchedule(
                                accountUID: accountUID,
                                title: title,
                                description: description,
                                startTimeStamp: startTimeStamp,
                                endTimeStamp: endTimeStamp
                            )
                        }
                        presentationMode.wrappedValue.dismiss()
                    }),
                    secondaryButton: .cancel()
                )
                return alert
            }
        }
    }
}

struct ScheduleAddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScheduleAddView()
        }
    }
}

//
//  ScheduleAddingView.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

import SwiftUI

struct ScheduleAddingView: View {
    
    @Binding var shouldPresentAddingView: Bool
    @State private var newSchedule: Schedule = Schedule(
        id: UUID().uuidString,
        title: "",
        description: "",
        startTime: Date(),
        endTime: Date(timeInterval: 86400, since: Date()),
        status: .planned
    )
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    TextField("제목", text: $newSchedule.title)

                    Section {
                        TextEditor(text: $newSchedule.description)
                    }
                    
                    Section {
                        startDatePickerView(title: "시작", date: $newSchedule.startTime)
                        startDatePickerView(title: "종료", date: $newSchedule.endTime)
                    }
                }
            }
            .navigationTitle("새로운 일정")
            .navigationBarItems(leading: Button(action: {
                shouldPresentAddingView.toggle()
            }, label: {
                Text("취소")
            }))
            .navigationBarItems(trailing: Button(action: {
                shouldPresentAddingView.toggle()
            }, label: {
                //TODO: 저장 로직 구현
                Text("저장")
            }))
        }
    }
}

struct ScheduleAddingView_Previews: PreviewProvider {
    
    @State static var shouldPresentSheet = false
    
    static var previews: some View {
        ScheduleAddingView(shouldPresentAddingView: $shouldPresentSheet)
    }
    
}

extension ScheduleAddingView {
    
    func startDatePickerView(title: String, date: Binding<Date>) -> some View {
        HStack {
            Text(title)
            
            Spacer()
            
            Image(systemName: "calendar")
            
            DatePicker(
                "DatePicker",
                selection: date,
                displayedComponents: [.date, .hourAndMinute]
            )
            .environment(\.locale, Locale.init(identifier: "ko"))
            .labelsHidden()
        }
    }
    
}

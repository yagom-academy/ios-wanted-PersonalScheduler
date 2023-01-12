//
//  ScheduleAddingView.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/12.
//

import SwiftUI

struct ScheduleAddingView: View {
    
    @StateObject var scheduleListViewModel: ScheduleListViewModel
    @Binding var shouldPresentAddingView: Bool
    @State private var newSchedule: Schedule = Schedule(
        id: UUID().uuidString,
        title: "",
        description: "",
        startMoment: Date(),
        endMoment: Date(timeInterval: 86400, since: Date()),
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
                        startDatePickerView(title: "시작", date: $newSchedule.startMoment)
                        startDatePickerView(title: "종료", date: $newSchedule.endMoment)
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
                scheduleListViewModel.scheduleAddingSaveButtonTapped(schedule: newSchedule)
                scheduleListViewModel.fetchDataFromFirestore(firebaseID: scheduleListViewModel.firebaseID)
                shouldPresentAddingView.toggle()
            }, label: {
                Text("저장")
            }))
        }
    }
}

struct ScheduleAddingView_Previews: PreviewProvider {
    
    @State static var shouldPresentSheet = false
    
    static var previews: some View {
        ScheduleAddingView(scheduleListViewModel: ScheduleListViewModel(firebaseID: ""), shouldPresentAddingView: $shouldPresentSheet)
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

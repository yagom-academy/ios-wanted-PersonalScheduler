//
//  ScheduleEditingView.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/13.
//

import SwiftUI

struct ScheduleEditingView: View, ScheduleWritableView {
    
    @StateObject var scheduleListViewModel: ScheduleListViewModel
    @Binding var shouldPresentEditingView: Bool
    @Binding var selectedSchedule: Schedule
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    TextField("제목", text: $selectedSchedule.title)

                    Section {
                        TextEditor(text: $selectedSchedule.description)
                    }
                    
                    Section {
                        datePickerView(title: "시작", date: $selectedSchedule.startMoment)
                        datePickerView(title: "종료", date: $selectedSchedule.endMoment)
                    }
                }
            }
            .navigationTitle("일정 수정하기")
            .navigationBarItems(leading: Button(action: {
                shouldPresentEditingView.toggle()
            }, label: {
                Text("취소")
            }))
            .navigationBarItems(trailing: Button(action: {
                scheduleListViewModel.scheduleEditingSaveButtonTapped(schedule: selectedSchedule)
                scheduleListViewModel.fetchDataFromFirestore(firebaseID: scheduleListViewModel.firebaseID)
                shouldPresentEditingView.toggle()
            }, label: {
                Text("저장")
            }))
        }
    }
}

struct ScheduleEditingView_Previews: PreviewProvider {
    
    @State static var shouldPresentSheet = false
    
    static var previews: some View {
        ScheduleAddingView(scheduleListViewModel: ScheduleListViewModel(firebaseID: ""), shouldPresentAddingView: $shouldPresentSheet)
    }
    
}

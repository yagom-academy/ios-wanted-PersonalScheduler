//
//  ScheduleWritableView.swift
//  PersonalScheduler
//
//  Created by minsson on 2023/01/13.
//

import SwiftUI

protocol ScheduleWritableView { }

extension ScheduleWritableView {
        
        func datePickerView(title: String, date: Binding<Date>) -> some View {
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


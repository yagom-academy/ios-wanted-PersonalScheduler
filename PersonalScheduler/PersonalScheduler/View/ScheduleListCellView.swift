//
//  ScheduleListCellView.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/12.
//

import SwiftUI

struct ScheduleListCellView: View {
    
    var compareResult: ComparisonResult
    var title: String = ""
    var startTimeStamp: String = ""
    var endTimeStamp: String = ""
    var description: String = ""
    
    var body: some View {
        switch compareResult {
        case .orderedAscending:
            VStack(alignment: .leading) {
                Text(title)
                Text("시작 일시: \(startTimeStamp)")
                Text("종료 일시: \(endTimeStamp)")
                Text("내용: \(description)")
                    .lineLimit(1)
            }
            .foregroundColor(Color.secondary)

        case .orderedDescending:
            VStack(alignment: .leading) {
                Text(title)
                Text("시작 일시: \(startTimeStamp)")
                Text("종료 일시: \(endTimeStamp)")
                Text("내용: \(description)")
                    .lineLimit(1)
            }
            .foregroundColor(Color.green)
        case .orderedSame:
            VStack(alignment: .leading) {
                Text(title)
                Text("시작 일시: \(startTimeStamp)")
                Text("종료 일시: \(endTimeStamp)")
                Text("내용: \(description)")
                    .lineLimit(1)
            }
            .foregroundColor(Color.green)
        }
    }
}

struct ScheduleListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListCellView(compareResult: .orderedAscending)
    }
}

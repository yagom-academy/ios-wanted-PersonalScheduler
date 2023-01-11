//
//  ScheduleListView.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import SwiftUI

struct ScheduleListView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var scheduleListViewModel = ScheduleListViewModel()
    
    @State var isActiveAlert: Bool = false
    
    var uid: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("MySchedulList")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    NavigationLink {
                        ScheduleAddView(uid: uid)
                    } label: {
                        Image(uiImage: UIImage(systemName: "plus")!)
                    }
                }
                
                List {
                    ForEach(scheduleListViewModel.lists, id: \.startTimeStamp) { data in
                        NavigationLink {
                            ScheduleAddView(
                                title: data.title,
                                description: data.description,
                                startTimeStamp: data.startTimeStamp.translateToDate(),
                                endTimeStamp: data.endTimeStamp.translateToDate(),
                                isEditing: true,
                                uid: uid,
                                uuid: data.id
                            )
                        } label: {
                            VStack(alignment: .leading) {
                                Text("\(data.title)")
                                Text("시작 일시: \(data.startTimeStamp)")
                                    .foregroundColor(Color.secondary)
                                Text("종료 일시: \(data.endTimeStamp)")
                                    .foregroundColor(Color.secondary)
                                Text("내용: \(data.description)")
                                    .foregroundColor(Color.secondary)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            scheduleListViewModel.delete(
                                accountUID: uid,
                                uuid: scheduleListViewModel.lists[index].id
                            )
                        }
                    }
                }
                .listStyle(.plain)
                
            }
            .padding()
            .alert(isPresented: $isActiveAlert) {
                switch scheduleListViewModel.buttonAlert {
                case .logout:
                    let alert = Alert(
                        title: Text("로그아웃 하시겠습니까?"),
                        primaryButton: .default(Text("확인"), action: {
                            presentationMode.wrappedValue.dismiss()
                            scheduleListViewModel.logout()
                        }),
                        secondaryButton: .cancel()
                    )
                    return alert
                }
            }
            .onAppear {
                scheduleListViewModel.fetchFirebaseStore(uid: uid)
            }
        }
    }
}

struct ScheduleListView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListView(uid: "JzOwDyvtg7TUcOFvUNS3DBthbZD2")
    }
}

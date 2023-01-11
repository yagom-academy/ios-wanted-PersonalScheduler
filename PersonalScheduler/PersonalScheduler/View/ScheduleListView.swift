//
//  ScheduleListView.swift
//  PersonalScheduler
//
//  Created by brad on 2023/01/09.
//

import SwiftUI

struct ScheduleListView: View {
    
    var accountUID: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var scheduleListViewModel = ScheduleListViewModel()
    
    @State var isActiveAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("MySchedulList")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    NavigationLink {
                        ScheduleAddView(accountUID: accountUID)
                    } label: {
                        Image(uiImage: UIImage(systemName: "plus")!)
                    }
                }
                
                List {
                    ForEach(scheduleListViewModel.lists.sorted(by: {
                        $0.startTimeStamp.translateToDate() > $1.startTimeStamp.translateToDate()}), id: \.startTimeStamp) { data in
                            NavigationLink {
                                ScheduleAddView(
                                    isEditing: true,
                                    accountUID: accountUID,
                                    uuid: data.id,
                                    title: data.title,
                                    description: data.description,
                                    startTimeStamp: data.startTimeStamp.translateToDate(),
                                    endTimeStamp: data.endTimeStamp.translateToDate()
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
                                    accountUID: accountUID,
                                    uuid: scheduleListViewModel.scheduleListViewModel.lists.sorted(by: {
                                        $0.startTimeStamp.translateToDate() > $1.startTimeStamp.translateToDate()})[index].id
                                )
                            }
                        }
                }
                .listStyle(.plain)
                
                Button {
                    isActiveAlert.toggle()
                } label: {
                    Text("로그아웃")
                }
            }
            .padding()
            .alert(isPresented: $isActiveAlert) {
                switch scheduleListViewModel.buttonAlert {
                case .logout:
                    let alert = Alert(
                        title: Text("로그아웃 하시겠습니까?"),
                        primaryButton: .default(Text("확인"), action: {
                            scheduleListViewModel.logout()
                            presentationMode.wrappedValue.dismiss()
                        }),
                        secondaryButton: .cancel()
                    )
                    return alert
                }
            }
            .onAppear {
                scheduleListViewModel.fetchFirebaseStore(accountUID: accountUID)
            }
        }
    }
}

struct ScheduleListView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListView(accountUID: "JzOwDyvtg7TUcOFvUNS3DBthbZD2")
    }
}

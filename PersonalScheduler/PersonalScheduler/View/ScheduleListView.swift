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
                    
                    Button {
                        isActiveAlert.toggle()
                    } label: {
                        Text("로그아웃")
                    }
                }
                
                List {
                    ForEach(scheduleListViewModel.lists.sorted(by: {
                        $0.startTimeStamp.translateToDate() > $1.startTimeStamp.translateToDate()}), id: \.startTimeStamp) { data in
                            NavigationLink {
                                ScheduleAddView(
                                    isEditMode: true,
                                    accountUID: accountUID,
                                    uuid: data.id,
                                    title: data.title,
                                    description: data.description,
                                    startTimeStamp: data.startTimeStamp.translateToDate(),
                                    endTimeStamp: data.endTimeStamp.translateToDate(),
                                    totalChars: data.description.count
                                )
                            } label: {
                                let compareDate = data.endTimeStamp.translateToDate().compare(
                                    Date().translateToDateFormat()
                                )
                                
                                ScheduleListCellView(
                                    compareResult: compareDate,
                                    title: data.title,
                                    startTimeStamp: data.startTimeStamp,
                                    endTimeStamp: data.endTimeStamp,
                                    description: data.description
                                )
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                scheduleListViewModel.delete(
                                    accountUID: accountUID,
                                    uuid: scheduleListViewModel.lists.sorted(by: {
                                        $0.startTimeStamp.translateToDate() > $1.startTimeStamp.translateToDate()})[index].id
                                )
                            }
                        }
                }
                .listStyle(.plain)

                NavigationLink {
                    ScheduleAddView(accountUID: accountUID)
                } label: {
                    Image(uiImage: UIImage(systemName: "square.and.pencil")!)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
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

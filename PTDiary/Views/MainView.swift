//
//  MainView.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/17/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    // 모든 운동 일지
    @Query var diaries: [PTDiary]
    
    // 검색 텍스트
    @State private var searchText: String = ""
    
    // 검색 결과 표시
    var filteredDiaries: [PTDiary] {
        if searchText.isEmpty {
            return diaries
        } else {
            return diaries.filter { diary in
                diary.title.contains(searchText) ||
                diary.exercises.contains(searchText) ||
                diary.date.formatted().contains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                // 이번 주
                Section {
                    // TODO: 변수로 분리해서 if else 로 뿌리기 텍스트까지
                    ForEach(filteredDiaries.filter { Calendar.current.isDateInThisMonth($0.date)}) { diary in
                        PTDiaryRow(title: diary.title, date: diary.date)
                    }
                } header: {
                    Text("이번 달")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.black)
                        .padding(.leading, -16)
                        .padding(.bottom, 4)
                }
                
                // 나머지
                // TODO: 변수로 분리해서 if else 로 뿌리기 텍스트까지
                Section {
                    ForEach(filteredDiaries.filter { !Calendar.current.isDateInThisMonth($0.date)}) { diary in
                        PTDiaryRow(title: diary.title, date: diary.date)
                    }
                } header: {
                    Text("지난 기록")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.black)
                        .padding(.leading, -16)
                        .padding(.bottom, 4)
                }
            } // List
            .navigationTitle("운동 일지")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    
                    Text("10개의 운동 일지")
                        .font(.caption)
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    NavigationLink {
                        WriteView()
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 23, height: 25)
                    }
                    
                }
            } // toolbar
        } // NavigationStack
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .automatic),
            prompt: "검색"
        )
    }
}


#Preview {
    MainView()
}

//struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
//}


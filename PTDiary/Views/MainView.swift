//
//  MainView.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/17/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                // 이번 주
                Section {
                    PTDiaryRow(
                        title: "PT 1회차 운동일지", date: Date.now
                    )
                } header: {
                    Text("이번 주")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.black)
                        .padding(.leading, -16)
                }
                
                // 나머지
                Section {
                    PTDiaryRow(title: "PT 1회차 운동일지", date: Date.now)
                    PTDiaryRow(title: "PT 1회차 운동일지", date: Date.now)
                    PTDiaryRow(title: "PT 1회차 운동일지", date: Date.now)
                    PTDiaryRow(title: "PT 1회차 운동일지", date: Date.now)
                    PTDiaryRow(title: "PT 1회차 운동일지", date: Date.now)
                    PTDiaryRow(title: "PT 1회차 운동일지", date: Date.now)
                    PTDiaryRow(title: "PT 1회차 운동일지", date: Date.now)
                    PTDiaryRow(title: "PT 1회차 운동일지", date: Date.now)
                    PTDiaryRow(title: "PT 1회차 운동일지", date: Date.now)
                } header: {
                    Text("지난 기록")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.black)
                        .padding(.leading, -16)
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


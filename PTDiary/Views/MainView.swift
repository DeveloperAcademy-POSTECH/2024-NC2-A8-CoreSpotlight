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
    @Query(sort: \PTDiary.round, order: .reverse) var diaries: [PTDiary]
    
    // 네비게이션 관리하는 매니저
    @ObservedObject var navigationManager: NavigationManager = NavigationManager()
    
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
                diary.date.formatted().contains(searchText) ||
                diary.round.description == searchText ||
                searchText.contains(diary.round.description)
            }
        }
    }
    
    // 회차 정보; 일지 개수
    private var round: Int {
        diaries.count
    }
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            List {
                // 이번 달
                Section {
                    // TODO: 변수로 분리해서 if else 로 뿌리기 텍스트까지
                    ForEach(filteredDiaries.filter {
                        Calendar.current.isDateInThisMonth($0.date)
                    }) { diary in
                        NavigationLink(value: diary) {
                            PTDiaryRow(title: diary.title, date: diary.date)
                        }
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
                    ForEach(filteredDiaries.filter {
                        !Calendar.current.isDateInThisMonth($0.date)
                    }) { diary in
                        NavigationLink(value: diary) {
                            PTDiaryRow(title: diary.title, date: diary.date)
                        }
                        
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
            .navigationDestination(for: PTDiary.self, destination: { ptDiary in
                DetailView(ptDiary: ptDiary)
                    .environmentObject(navigationManager)
            })
            .navigationDestination(for: String.self, destination: { string in
                InformationView()
                    .environmentObject(navigationManager)
            })
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    
                    Text("\(round)개의 운동 일지")
                        .font(.caption)
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    
                    NavigationLink(
                        value: PTDiary(
                            title: "PT \(round+1)회차 운동 일지",
                            round: round+1,
                            date: Date.now,
                            exercises: []
                        )
                    ) {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .foregroundColor(.accent)
                            .frame(width: 24, height: 24)
                    }
                } // toolbar
                ToolbarItemGroup(placement: .topBarTrailing) {
                    NavigationLink(
                        value: "Information"
                    ) {
                        Image(systemName: "info.circle")
                            .resizable()
                            .foregroundColor(.accent)
                            .frame(width: 24, height: 24)
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
    
}

#Preview {
    MainView()
}

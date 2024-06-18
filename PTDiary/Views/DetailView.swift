//
//  DetailView.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/17/24.
//

import SwiftUI
import SwiftData
import CoreSpotlight

struct DetailView: View {
    // SwiftData에서 사용할 ModelContext
    @Environment(\.modelContext) private var modelContext
    
    // 네비게이션 관리하는 매니저
    @EnvironmentObject var navigationManager: NavigationManager
    
    // SwiftData를 관리하는 매니저
    private var swiftDataManger: SwiftDataManager {
        SwiftDataManager(modelContext: modelContext)
    }
    
    var ptDiary: PTDiary
    
    var round: Int = 10
    
    @State private var exercisesInput: String = ""
    @State private var learned: String = ""
    @State private var improvements: String = ""
    @State private var keyPoints: String = ""
    @State private var impressions: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                Form {
                    Section(header: Text("제목")) {
                        Text(ptDiary.title)
                    }
                    Section(header: Text("날짜")) {
                        Text(ptDiary.date.dateFormat)
                    }
                    
                    Section(header: Text("오늘 한 운동")) {
                        TextField("운동 종류를 쉼표로 구분해서 입력", text: $exercisesInput)
                    }
                    
                    Section(header: Text("오늘 배운 점")) {
                        TextEditor(text: $learned)
                            .frame(height: 100)
                    }
                    
                    Section(header: Text("개선해야 할 점")) {
                        TextEditor(text: $improvements)
                            .frame(height: 100)
                    }
                    
                    Section(header: Text("꼭 기억해야 할 포인트")) {
                        TextEditor(text: $keyPoints)
                            .frame(height: 100)
                    }
                    
                    
                    Section(header: Text("느낀 점")) {
                        TextEditor(text: $impressions)
                            .frame(height: 100)
                    }
                    
                    Button {
                        processTags()
                        saveData()
                        navigationManager.path.removeLast()
                    } label: {
                        Text("저장")
                    }
                }
                .formStyle(.columns)
                .onAppear {
                    // 초기 값 설정
                    exercisesInput = ptDiary.exercises.joined(separator: ", ")
                    learned = ptDiary.learned ?? ""
                    improvements = ptDiary.improvements ?? ""
                    keyPoints = ptDiary.keyPoints ?? ""
                    impressions = ptDiary.impressions ?? ""
                }
            } // VStack
            .padding(.horizontal)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        saveData()
                        navigationManager.path.removeLast()
                    } label: {
                        Text("저장")
                    }
                }
            } // toolbar
        } // ScrollView
        
    }
}

extension DetailView {
    /// 운동 종류를 구분합니다.
    private func processTags() {
        ptDiary.exercises = exercisesInput.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
    }
    
    /// Core Spotlight를 통해 데이터를 색인합니다.
    private func indexData(diary: PTDiary) {
        var searchableItems = [CSSearchableItem]()
        
        let attributeSet = CSSearchableItemAttributeSet(contentType: .text)
        attributeSet.title = diary.title
        attributeSet.displayName = diary.title
        attributeSet.alternateNames = diary.exercises
        attributeSet.contentDescription = diary.date.dateFormat
        attributeSet.keywords = diary.exercises
        
        let searchableItem = CSSearchableItem(uniqueIdentifier: diary.id.uuidString, domainIdentifier: "exerciseDiary", attributeSet: attributeSet)
        searchableItems.append(searchableItem)
        
//        // Get the default index.
//        let defaultIndex = CSSearchableIndex.default()
        
        // Create an encrypted index.
        let secureIndex = CSSearchableIndex(name: "운동 일지", protectionClass:.complete)
        
        secureIndex.indexSearchableItems(searchableItems) { error in
            if let error = error {
                print("Spotlight 색인 시도: \(error.localizedDescription)")
            } else {
                print("Spotlight 색인 성공")
            }
        }
    }

    /// SwiftData 를 통해 데이터를 저장합니다.
    private func saveData() {
        // 데이터 갱신
        processTags() // 운동 종류 갱신
        ptDiary.learned = learned
        ptDiary.improvements = improvements
        ptDiary.keyPoints = keyPoints
        ptDiary.impressions = impressions
        
        // 데이터 저장
        swiftDataManger.updateDiary(newDiary: ptDiary)
        
        // 데이터 색인
        indexData(diary: ptDiary)
    }
    
}

#Preview {
    DetailView(ptDiary: PTDiary(
        title: "PT 13회차 운동 일지",
        round: 13,
        date: Date.now,
        exercises: [])
    )
    .modelContainer(for: PTDiary.self, inMemory: true)
}

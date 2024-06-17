//
//  DetailView.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/17/24.
//

import SwiftUI
import SwiftData
import CoreSpotlight
import UniformTypeIdentifiers

struct DetailView: View {
    
    // SwiftData에서 사용할 ModelContext
    @Environment(\.modelContext) private var modelContext
    
    // 네비게이션 관리하는 매니저
    @ObservedObject var navigationManager: NavigationManager = NavigationManager()
    
    // SwiftData를 관리하는 매니저
    private var swiftDataManger: SwiftDataManager {
        SwiftDataManager(modelContext: modelContext)
    }
    
    var round: Int
    
    private var title: String {
        "PT \(round)회차 운동 일지"
    }
    
    private var date: Date {
        Date.now
    }
    
    
    @State private var exercisesInput: String = ""
    @State private var exercises: [String] = []
    
    
    @State private var learned: String = ""
    @State private var improvements: String = ""
    @State private var keyPoints: String = ""
    @State private var impressions: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                Form {
                    Section(header: Text("제목")) {
                        Text(title)
                    }
                    Section(header: Text("날짜")) {
                        Text(date.dateFormat)
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
                        saveData()
                        if !navigationManager.path.isEmpty {
                            navigationManager.path.removeLast()
                        }
                    } label: {
                        Text("저장")
                    }
                }
                .formStyle(.columns)
            }
            .padding(.horizontal)
        }
        
    }
    
    private func processTags() {
        exercises = exercisesInput.split(separator: " ").map { String($0) }
    }
    
    private func saveData() {
        exercises = exercisesInput.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        
        let newDiary: PTDiary = PTDiary(
            title: title,
            round: round,
            date: date,
            exercises: exercises,
            learned: learned,
            improvements: improvements,
            keyPoints: keyPoints,
            impressions: impressions
        )

        swiftDataManger.insertDiary(newDiary:  newDiary)
        
        indexData(diary: newDiary)
    }
    
    private func indexData(diary: PTDiary) {
        var searchableItems = [CSSearchableItem]()
        
        let attributeSet = CSSearchableItemAttributeSet(contentType: .content)
        attributeSet.title = diary.title
        attributeSet.contentDescription = diary.date.dateFormat
        attributeSet.keywords = diary.exercises
        
        let searchableItem = CSSearchableItem(uniqueIdentifier: diary.round.description, domainIdentifier: "exerciseDiary", attributeSet: attributeSet)
        searchableItems.append(searchableItem)
        
        // Get the default index.
        let defaultIndex = CSSearchableIndex.default()


        // Create an encrypted index.
        let secureIndex = CSSearchableIndex(name: "운동 일지", protectionClass:.complete)

        
        secureIndex.indexSearchableItems(searchableItems) { error in
            if let error = error {
                print("Spotlight 색인 오류: \(error.localizedDescription)")
            } else {
                print("운동 일지가 Spotlight에 성공적으로 색인되었습니다.")
            }
        }
    }
    
}

#Preview {
    DetailView(round: 13)
        .modelContainer(for: PTDiary.self, inMemory: true)
}

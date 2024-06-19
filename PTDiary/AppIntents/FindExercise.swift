//
//  CreatePTDiary.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/18/24.
//

import AppIntents
import SwiftData
import SwiftUI

struct FindExercise: AppIntent {
    static var title = LocalizedStringResource("운동 찾기")
    static var description =  IntentDescription("이전에 배운 운동을 찾아보아요")
    
    // SwiftData에서 사용할 ModelContext
    @Environment(\.modelContext) private var modelContext
    
    // SwiftData를 관리하는 매니저
    private var swiftDataManger: SwiftDataManager {
        SwiftDataManager(modelContext: modelContext)
    }
    
    @Parameter(title: "Exercise")
    var exercise: String
    
    func perform() async throws -> some IntentResult {
        let diaries = swiftDataManger.fetchDiaryOfExercise(for: exercise)
        
        return .result(dialog: "\(exercise) 운동을 기록한 운동 일지를 찾았습니다")
    }
    
}

//struct DiaryEntity: AppEntity {
//    static var defaultQuery = DiaryQuery()
//    static var typeDisplayRepresentation: TypeDisplayRepresentation = "List"
//    
//    var id: UUID
//    var displayRepresentation: DisplayRepresentation {
//        DisplayRepresentation(title: "\(title)", image: .init(named: thumbnailName))
//    }
//
//    var title: String
//    var thumbnailName: String
//    var excercise: [String]
//}
//
//struct DiaryQuery: EntityQuery {
//    
//    // SwiftData에서 사용할 ModelContext
//    @Environment(\.modelContext) private var modelContext
//    
//    // SwiftData를 관리하는 매니저
//    private var swiftDataManger: SwiftDataManager {
//        SwiftDataManager(modelContext: modelContext)
//    }
//    
//    
//    func entities(for exercise: String) async throws -> [DiaryEntity] {
//        var diaryEntityList: [DiaryEntity] = []
//        
//        let diaries = swiftDataManger.fetchDiaryOfExercise(for: exercise)
//        
//        for diary in diaries {
//            diaryEntityList.append(DiaryEntity(id: diary.id, title: diary.title, thumbnailName: "dumbbell.fill", excercise: diary.exercises))
//        }
//        
//        return diaryEntityList
//    }
//    
//    func suggestedEntities() async throws -> some ResultsCollection {
//        
//    }
//}

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

    
    @Parameter(title: "Exercise")
    var exercise: String
    
    func perform() async throws -> some IntentResult {
        let swiftDataManager = SwiftDataManager(modelContext: modelContext)
        
        let diaries = swiftDataManager.fetchDiaryOfExercise(for: exercise)
        
        if diaries.isEmpty {
            return .result(dialog: "\(exercise) 운동을 기록한 운동 일지가 없습니다.", view: ExerciseListView(diaries: diaries))
        }
        return .result(dialog: "\(exercise) 운동을 기록한 운동 일지를 찾았습니다", view: ExerciseListView(diaries: diaries))
    }
    
}



struct DiaryEntity: AppEntity {
    static var defaultQuery = DiaryQuery()
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        TypeDisplayRepresentation(
            name: LocalizedStringResource("Exercise", table: "AppIntents"),
            numericFormat: LocalizedStringResource("\(placeholder: .int) Exercises", table: "AppIntents")
        )
    }
    var id: UUID
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(title)", image: .init(named: thumbnailName))
    }
    @Property(title: "Exercise Name")
    var exercise: String
    

    var title: String
    var thumbnailName: String
    var excercise: [String]
}



struct DiaryQuery: EntityQuery {
    // SwiftData에서 사용할 ModelContext
    @Environment(\.modelContext) var modelContext
    
    // SwiftData를 관리하는 매니저
    var swiftDataManger: SwiftDataManager {
        SwiftDataManager(modelContext: modelContext)
    }
    
    func entities(for identifiers: [UUID]) async throws -> [DiaryEntity] {
        var diaryEntityList: [DiaryEntity] = []
        
        
        for identifier in identifiers {
            do {
                let diary = try swiftDataManger.fetchDiaryOfId(for: identifier)
                diaryEntityList.append(DiaryEntity(id: diary.id, title: diary.title, thumbnailName: "dumbell.fill", excercise: diary.exercises))
            }
            catch {
                continue
            }
        }
        return diaryEntityList
    }
    
    func suggestedEntities() async throws -> [DiaryEntity] {
        var diaries: [PTDiary] = swiftDataManger.fetchList()
        
        var diaryEntityList: [DiaryEntity] = []
        
        for diary in diaries {
            diaryEntityList.append(DiaryEntity(id: diary.id, title: diary.title, thumbnailName: "dumbbell.fill", excercise: diary.exercises))
        }
        
        return diaryEntityList
    }
}

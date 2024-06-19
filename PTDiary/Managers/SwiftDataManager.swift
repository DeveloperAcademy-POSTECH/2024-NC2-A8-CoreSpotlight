//
//  SwiftDataManager.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/17/24.
//

import SwiftUI
import SwiftData

final class SwiftDataManager: ObservableObject {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}

extension SwiftDataManager {
    // MARK: - 저장하기
    /// PTDiary 를 저장합니다.
    private func saveData() throws {
        do {
            print("저장 시도")
            try modelContext.save()
            print("저장 완료")
        } catch {
            throw DiaryDataError.cannotSave
        }
    }
    
    // MARK: - 불러오기
    /// 해당하는 운동 일지를 불러옵니다.
    func fetchDiary(diary: PTDiary) throws -> PTDiary {
        // 1.검색 조건 변수 설정
        let round: Int = diary.round
        
        // 2. 동일한 날짜 및 식사 시간을 가진 식사 검색 조건 생성
        let predicate = #Predicate<PTDiary> { $0.round == round }
        
        // 3. FetchDescriptor 설정
        let descriptor = FetchDescriptor(predicate: predicate)
        
        // 4. ModelContext를 이용해 PTDiary 받아옴
        do {
            let possibleDiary = try modelContext.fetch(descriptor)
            if let targetDiary = possibleDiary.first {
                return targetDiary
            }
        } catch {
            print("\(DiaryDataError.notFound)")
        }
        
        throw DiaryDataError.notFound
    }
    
    // MARK: - 불러오기
    /// 해당하는 운동을 포함하는 운동 일지를 불러옵니다.
    func fetchDiaryOfExercise(for exercise: String) -> [PTDiary] {
        // 0. 결과 배열
        var diaries: [PTDiary] = []
        
        // 1.검색 조건 변수 설정
        let exercise: String = exercise
        
        // 2. 동일한 날짜 및 식사 시간을 가진 식사 검색 조건 생성
        let predicate = #Predicate<PTDiary> { $0.exercises.contains(exercise) }
        
        // 3. FetchDescriptor 설정
        let descriptor = FetchDescriptor(predicate: predicate)
        
        // 4. ModelContext를 이용해 PTDiary 받아옴
        do {
            let possibleDiary = try modelContext.fetch(descriptor)
            diaries = possibleDiary
            
        } catch {
            print("\(DiaryDataError.notFound)")
        }
        
        return diaries
    }
    
//    // MARK: - 추가 및 업데이트
//    func insertDiary(newDiary: PTDiary) {
//        print("추가 시도")
//        modelContext.insert(newDiary)
//        
//        print("추가 완료")
//        try? saveData()
//    }
    
    // MARK: - 추가 및 업데이트
    func updateDiary(newDiary: PTDiary) {
        print("업데이트 시도")
        do {
            // 1. 이전 일기 불러오기
            let oldDiary = try fetchDiary(diary: newDiary)
            
            // 2. 새로운 일기 내용 덮어 씌우기
            oldDiary.exercises = newDiary.exercises
            oldDiary.learned = newDiary.learned
            oldDiary.improvements = newDiary.improvements
            oldDiary.keyPoints = newDiary.keyPoints
            oldDiary.impressions = newDiary.impressions
        } catch {
            print("업데이트 실패, 새롭게 추가 시도")
            modelContext.insert(newDiary)
            
            // 최신 회차 갱신
            @AppStorage("round") var round: Int = newDiary.round
            print(round)
            
            print("새롭게 추가 완료")
            try? saveData()
        }
        
        print("업데이트 완료")
        try? saveData()
    }
    // MARK: - 삭제
    func delete(diary: PTDiary) {
        print("삭제 시도")
        modelContext.delete(diary)
        
        print("삭제 완료")
        try? saveData()
    }
}

/// SwiftDataManger 가 발생시킬 수 있는 에러
enum DiaryDataError: Error {
    case notFound // 데이터 찾을 수 없음
    case noData // 데이터 없음
    case cannotSave // 저장할 수 없음
    case cannotUpdate // 업데이트 할 수 없음
    case cannotDelete // 삭제할 수 없음
}

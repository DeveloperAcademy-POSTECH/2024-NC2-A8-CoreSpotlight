//
//  CreatePTDiary.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/18/24.
//

import AppIntents

struct CreatePTDiary: AppIntent {
    static var title: LocalizedStringResource = "새로운 운동일지 작성"
    
//    @Parameter(title: "Excercises")
//    var excercises: String
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}

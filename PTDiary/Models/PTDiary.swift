//
//  PTDiary.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/17/24.
//

import Foundation
import SwiftData

@Model
class PTDiary {
    /// 제목; PT 13회차 운동 일지
    var title: String
    
    /// 회차; 13
    var round: Int
    
    /// 날짜; 2024.06.10
    var date: Date
    
    /// 오늘 배운 운동들
    var exercises: [String]
    
    /// 새로 배운 점
    var learned: String?
    
    /// 개선해야 할 점
    var improvements: String?
    
    /// 꼭 기억해야 할 점
    var keyPoints: String?
    
    /// 느낀 점
    var impression: String?
    
    init(title: String, round: Int, date: Date, exercises: [String], learned: String? = nil, improvements: String? = nil, keyPoints: String? = nil, impression: String? = nil) {
        self.title = title
        self.round = round
        self.date = date
        self.exercises = exercises
        self.learned = learned
        self.improvements = improvements
        self.keyPoints = keyPoints
        self.impression = impression
    }
}

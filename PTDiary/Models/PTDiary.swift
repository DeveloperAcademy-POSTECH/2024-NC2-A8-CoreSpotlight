//
//  PTDiary.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/17/24.
//

import Foundation

struct PTDiary {
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
}

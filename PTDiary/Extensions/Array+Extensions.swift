//
//  Array+Extensions.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/20/24.
//

import Foundation

extension Array where Element == String {
    // 운동 배열을 String으로 반환합니다.
        func getExerciseString() -> String {
            return self.joined(separator: ", ")
        }
}


//
//  Date+Extension.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/17/24.
//

import Foundation

extension Date {
    /// Date 타입을 "2024.02.10" 형식의 문자열로 반환합니다.
    var dateFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}

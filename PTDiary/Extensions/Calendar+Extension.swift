//
//  Calendar+Extension.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/17/24.
//

import Foundation

extension Calendar {
    func isDateInThisMonth(_ date: Date) -> Bool {
        let now = Date()
        return self.isDate(date, equalTo: now, toGranularity: .month)
    }
}

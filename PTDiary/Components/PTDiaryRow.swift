//
//  PTDiaryRow.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/17/24.
//

import SwiftUI

struct PTDiaryRow: View {
    let title: String
    let date: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .lineLimit(1)
                .font(.headline)
                .foregroundStyle(.primary)
            
            Text(date.dateFormat)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
        }
    }
}

#Preview {
    PTDiaryRow(title: "PT 1회차 운동 일지", date: Date.now)
}

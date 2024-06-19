//
//  ExerciseListView.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/19/24.
//

import SwiftUI

struct ExerciseListView: View {
    let diaries: [PTDiary]
    
    var body: some View {
        List(diaries, id: \.id) { diary in
            VStack(alignment: .leading) {
                Text(diary.title)
                    .font(.headline)
                Text(diary.date, style: .date)
                    .font(.subheadline)
            }
        }
        .navigationTitle("운동 일지 리스트")
    }
}


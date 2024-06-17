//
//  WriteView.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/17/24.
//

import SwiftUI

struct WriteView: View {
    @State private var title: String = ""
    @State private var learned: String = ""
    @State private var improvements: String = ""
    @State private var keyPoints: String = ""
    @State private var exercises: String = ""
    @State private var tags: [String] = []
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("제목")) {
                    TextField("제목", text: $title)
                }
                
                Section(header: Text("오늘 배운 점")) {
                    TextEditor(text: $learned)
                        .frame(height: 100)
                }
                
                Section(header: Text("개선해야 할 점")) {
                    TextEditor(text: $improvements)
                        .frame(height: 100)
                }
                
                Section(header: Text("꼭 기억해야 할 포인트")) {
                    TextEditor(text: $keyPoints)
                        .frame(height: 100)
                }
                
                Section(header: Text("오늘 한 운동")) {
                    TextField("운동 종류를 쉼표로 구분해서 입력", text: $exercises)
                }
                
                Button {
                    print("저장")
                } label: {
                    Text("저장")
                }
            }
            .formStyle(.columns)
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    WriteView()
}

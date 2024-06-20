//
//  ExerciseModalView.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/20/24.
//

import SwiftUI

struct ExerciseModalView: View {
    @Binding var isMenuModalPresented: Bool
    @Binding var exercises: [String]
    
    @State var everyExercise: [String]
    
    // 검색된 운동
    var searchedExercises: [String] {
        if searchText.isEmpty {
            return everyExercise
        } else {
            return everyExercise.filter { $0.localizedStandardContains(searchText)}
        }
    }
    
    // 검색 텍스트
    @State private var searchText = ""
    
    @State private var selectedExercises: [String] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchedExercises, id: \.self) { exercise in
                    HStack {
                        Text("\(exercise)")
                        Spacer()
                        
                        if selectedExercises.contains(exercise) {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if !selectedExercises.contains(exercise) {
                            selectedExercises.append(exercise)
                        }
                        else {
                            selectedExercises.remove(at: selectedExercises.firstIndex(of: exercise)!)
                        }
                        
                    }
                }
                
                if searchText != "" {
                    Button(action: {
                        everyExercise.append(searchText)
                    }, label: {
                        Text("+ 새로운 운동 추가하기")
                    })
                }
            }
            .navigationTitle("운동 선택")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        exercises = selectedExercises
                        isMenuModalPresented = false
                    } label: {
                        Text("선택")
                    }
                }
            } // List
        } // NavigationStack
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "운동을 선택해주세요."
        )
        .presentationDetents([.large])
        .onAppear(
            perform: {
                selectedExercises.append(contentsOf: exercises)
            }
        )
    }
}

//
//#Preview {
//    ExerciseModalView()
//}

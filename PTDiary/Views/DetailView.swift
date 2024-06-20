//
//  DetailView.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/17/24.
//

import SwiftUI
import SwiftData
import CoreSpotlight

struct DetailView: View {
    // SwiftData에서 사용할 ModelContext
    @Environment(\.modelContext) private var modelContext
    
    // 네비게이션 관리하는 매니저
    @EnvironmentObject var navigationManager: NavigationManager
    
    // SwiftData를 관리하는 매니저
    private var swiftDataManger: SwiftDataManager {
        SwiftDataManager(modelContext: modelContext)
    }
    
    var ptDiary: PTDiary
    
    var round: Int = 10
    
    @State private var exercises: [String] = []
    @State private var learned: String = ""
    @State private var improvements: String = ""
    @State private var keyPoints: String = ""
    @State private var impressions: String = ""
    
    @State private var isExerciseModalPresented: Bool = false
    
    var body: some View {
        ZStack {
            Color(red: 0.95, green: 0.95, blue: 0.96).ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading) {
                    Form {
                        // 날짜
                        Text(ptDiary.date.dateFormat)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer().frame(height: 10)
                        
                        // 제목
                        Text(ptDiary.title)
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer().frame(height: 38)
                        
                        // 오늘 배운 운동
                        Section {
                            ScrollView(.horizontal){
                                HStack {
                                    ZStack(alignment: .center){
                                        Circle()
                                            .frame(width:38, height:38)
                                            .colorInvert()
                                        
                                        Image(systemName: "plus")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.accent)
                                    }
                                    .onTapGesture {
                                        isExerciseModalPresented = true
                                    }
                                    
                                    ForEach(exercises, id: \.self) { exercise in
                                        exerciseTag(for: exercise)
                                    }
                                }
                            }
                        } header: {
                            sectionHeader(title: "오늘 배운 운동")
                        }
                        Spacer().frame(height: 38)
                        
                        // 오늘 배운 점
                        Section {
                            sectionTextEditor(for: $learned)
                        } header: {
                            sectionHeader(title: "새로 배운 점")
                        }
                        Spacer().frame(height: 38)
                        
                        // 개선해야 할 점
                        Section {
                            sectionTextEditor(for: $improvements)
                        } header: {
                            sectionHeader(title: "개선해야 할 점")
                        }
                        Spacer().frame(height: 38)
                        
                        // 키 포인트
                        Section {
                            sectionTextEditor(for: $keyPoints)
                        } header: {
                            sectionHeader(title: "꼭 기억해야 할 포인트")
                        }
                        Spacer().frame(height: 38)
                        
                        // 느낀 점
                        Section {
                            sectionTextEditor(for: $impressions)
                        } header: {
                            sectionHeader(title: "느낀 점")
                        }
                        Spacer().frame(height: 38)
                    }
                    .formStyle(.columns)
                    .onAppear {
                        // 초기 값 설정
                        exercises = ptDiary.exercises
                        learned = ptDiary.learned ?? ""
                        improvements = ptDiary.improvements ?? ""
                        keyPoints = ptDiary.keyPoints ?? ""
                        impressions = ptDiary.impressions ?? ""
                    }
                } // VStack
                .padding(.horizontal)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            saveData()
                            navigationManager.path.removeLast()
                        } label: {
                            Text("저장")
                        }
                    }
                } // toolbar
            } // ScrollView
        }
        .sheet(isPresented: $isExerciseModalPresented, content: {
            ExerciseModalView(isMenuModalPresented: $isExerciseModalPresented, exercises: $exercises, everyExercise: swiftDataManger.fetchExerciseList())
        })
    }
    
    @ViewBuilder
    func sectionTextEditor(for data: Binding<String>) -> some View {
        ZStack(alignment: .topLeading) {
            let placeholder: String = "내용을 입력해주세요"
            
            TextEditor(text: data)
                .font(.body)
                .fontWeight(.medium)
                .cornerRadius(22)
                .frame(height: 200)
                .onAppear {
                    UITextView.appearance().textContainerInset = UIEdgeInsets(top: 24, left: 20, bottom: 24, right: 20)
                }
            if data.wrappedValue == "" {
                Text(placeholder)
                    .padding(.horizontal, 24)
                    .font(.body)
                    .fontWeight(.medium)
                    .padding(.vertical, 24)
                    .foregroundColor(.gray)
            }
        }
    }
    
    @ViewBuilder
    func sectionHeader(title: String) -> some View {
        Text("\(title)")
            .font(.title2)
            .fontWeight(.semibold)
    }
    
}



extension DetailView {
//    /// 운동 종류를 구분합니다.
//    private func processTags() {
//        ptDiary.exercises = exercisesInput.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
//    }
    
    /// Core Spotlight를 통해 데이터를 색인합니다.
    private func indexData(diary: PTDiary) {
           // 1. Core Spotlight에 색인시킬 아이템을 저장할 배열을 정의합니다.
       var searchableItems = [CSSearchableItem]()
       
       // 2. 어떻게 색인시킬지 정합니다. 추후에 Spotlight에 나타납니다.
       let attributeSet = CSSearchableItemAttributeSet(contentType: .text) // Tip: ContentType을 정확히 설정하면 검색 정확도가 올라갑니다!
       attributeSet.title = diary.title // 제목
       attributeSet.displayName = diary.title // 나타나는 값(제목) cf) ios 17에서 색인 동작이 잘 되지 않아, 추가된 Property 입니다.
       attributeSet.contentDescription = diary.date.dateFormat // 내용 설명; 제목 텍스트 밑에 나타납니다.
       attributeSet.alternateNames = diary.exercises // 대체 텍스트; 설명 텍스트 밑에 나타납니다.
       attributeSet.keywords = diary.exercises // 검색 키워드; 사용자가 해당 키워드를 Spotlight에 입력하면 해당 데이터가 나타납니다. cf) ios 17에서 해당 기능이 동작하지 않습니다. 하단에 링크 첨부.
       
       // 3.색인시킬 아이템을 초기화합니다.
       let searchableItem = CSSearchableItem(uniqueIdentifier: diary.id.uuidString, domainIdentifier: "exerciseDiary", attributeSet: attributeSet)
       searchableItems.append(searchableItem)
       
       
       // 4. 인덱스 범위를 정합니다. 민감 정보인 경우 default를 사용하지 않고 보호화된 인덱스를 사용합니다.
           //        let defaultIndex = CSSearchableIndex.default() // 기본 인덱스
           let secureIndex = CSSearchableIndex(name: "운동 일지", protectionClass:.complete)
       
       // 5. 색인시킬 아이템을 인덱스에 포함시킵니다.
       secureIndex.indexSearchableItems(searchableItems) { error in
           if let error = error {
               print("Spotlight 색인 시도: \(error.localizedDescription)")
           } else {
               print("Spotlight 색인 성공")
           }
       }
    }
    
    /// SwiftData 를 통해 데이터를 저장합니다.
    private func saveData() {
        // 데이터 갱신
        ptDiary.learned = learned
        ptDiary.improvements = improvements
        ptDiary.keyPoints = keyPoints
        ptDiary.impressions = impressions
        
        // 데이터 저장
        swiftDataManger.updateDiary(newDiary: ptDiary)
        
        // 데이터 색인
        indexData(diary: ptDiary)
    }
    
    @ViewBuilder
    func exerciseTag(for exercise: String) -> some View {
        Text("\(exercise)")
            .padding()
            .font(.body)
            .fontWeight(.medium)
            .foregroundStyle(.accent)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.white)
            )
    }
}

#Preview {
    DetailView(ptDiary: PTDiary(
        title: "PT 13회차 운동 일지",
        round: 13,
        date: Date.now,
        exercises: ["랫풀다운", "벤치 프레스"])
    )
    .modelContainer(for: PTDiary.self, inMemory: true)
}

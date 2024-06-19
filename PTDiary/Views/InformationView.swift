//
//  InformationView.swift
//  PTDiary
//
//  Created by sseungwonnn, 이주현 on 6/19/24.
//

import SwiftUI

struct InformationView: View {
    var body: some View{
        VStack(alignment: .leading, spacing: 10){
            // 제목
            Text("찾고 싶은 키워드를 \nSpotlight에 검색해보세요.")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.accent)
            Spacer().frame(height: 40)
            
            // 본문 1
            Text("Core spotlight이 무엇인가요?")
                .font(.title2)
                .fontWeight(.semibold)
            Text("아이폰에 내장된 검색 기능이에요. 홈 화면에서 중간 부분을 쓸어 내리면 나타나요.\n\n검색창에 원하는 키워드를 입력하면 빠르게 정보를 찾고 앱에 접근할 수 있어요.")
                .font(.body)
                .lineSpacing(8)
                .frame(width: .infinity)
            Spacer().frame(height: 60)
            
            
            // 본문 2
            Text("어떻게 활용할 수 있나요?")
                .font(.title2)
                .fontWeight(.semibold)
            Text("운동 일지에 기록한 내용 중 찾고 싶은 키워드를 검색해 보세요. 빠르게 원하는 정보를 찾을 수 있어요.\n\n예를 들어, \"스쿼트\"에 대해 기록한 내용을 찾아보고 싶다면 홈 화면의 중간 부분을 쓸어 내린 뒤 \"스쿼트\"라고 입력하기만 하면 접근할 수 있어요.")
                .font(.body)
                .lineSpacing(8)
                .frame(width: .infinity)
            
        }
        .padding()
    }
    
}

#Preview {
    InformationView()
}

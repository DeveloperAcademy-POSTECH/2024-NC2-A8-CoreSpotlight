# 2024-NC2-A8-CoreSpotlight
## 🎥 Youtube Link
(추후 만들어진 유튜브 링크 추가)

## 💡 About Core Spotlight
***앱을 열지 않고도 색인된 정보를 빠르게 확인하고 접근할 수 있는 기술***
> **Indexing** <br/> Core Spotlight를 활용하여, 사용자가 작성한 정보를 색인시킬 수 있다. 사용자는 이를 활용하여 앱을 열지 않고도 필요한 정보에 빠르게 접근할 수 있다.

> **앱 단축어** <br/> App Intents를 사용하여, 사용자는 앱을 열지 않고도 앱의 일부 기능을 빠르게 사용할 수 있다.

## 🎯 What we focus on?
> **Indexing** <br/> 색인을 통해 사용자가 기록한 정보에 빠르게 접근할 수 있도록 한다.

## 💼 Use Case
> **운동일지** <br/> 운동일지를 쓴 뒤 Spotlight을 통해 앱을 열지 않고도 원하는 기록에 빠르게 접근할 수 있게 하자!

## 🖼️ Prototype
![image](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A8-CoreSpotlight/assets/74140181/bf11399f-47d8-4143-8014-064b7e0dd507)
![image](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A8-CoreSpotlight/assets/74140181/8e63db2c-8041-4dc6-8228-508cc1f56f0c)
![image](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A8-CoreSpotlight/assets/74140181/415c2694-d312-4402-a2de-b7d205d35e45)
![image](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A8-CoreSpotlight/assets/74140181/874a3fca-96f3-423e-8dd8-c71f1b49b603)
![image](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A8-CoreSpotlight/assets/74140181/a32ed42b-ff12-400f-ae7c-b938a1559efd)


## 🛠️ About Code
```

    /// Core Spotlight를 통해 데이터를 색인합니다.
    private func indexData(diary: PTDiary) {
        // 1. Core Spotlight에 색인시킬 아이템을 저장할 배열을 정의합니다.
        var searchableItems = [CSSearchableItem]()
        
        // 2. 어떻게 색인시킬지 정합니다. Spotlight에 직접적으로 나타나는 항목입니다.
        let attributeSet = CSSearchableItemAttributeSet(contentType: .text) // Tip: ContentType을 정확히 설정하면 검색 정확도가 올라갑니다!
        attributeSet.title = diary.title // 제목
        attributeSet.displayName = diary.title // 나타나는 값(제목) cf) ios 17에서 색인 동작이 잘 되지 않아, 추가된 Property 입니다.
        attributeSet.contentDescription = diary.date.dateFormat // 내용 설명; 제목 텍스트 밑에 나타납니다.
        attributeSet.alternateNames = diary.exercises // 대체 텍스트; 설명 텍스트 밑에 나타납니다.
        attributeSet.keywords = diary.exercises // 검색 키워드; 사용자가 해당 키워드를 Spotlight에 입력하면 해당 데이터가 나타납니다. cf) ios 17에서 해당 기능이 동작하지 않습니다. 하단에 링크 첨부.
        // 키워드가 동작하지 않는 문제: https://forums.developer.apple.com/forums/thread/734996
        
        // 3.색인시킬 아이템을 초기화합니다.
        let searchableItem = CSSearchableItem(
	        uniqueIdentifier: diary.id.uuidString, d
	        omainIdentifier: "exerciseDiary", 
	        attributeSet: attributeSet
        )
        searchableItems.append(searchableItem)
        
        
        // 4. 인덱스 범위를 정합니다. cf) 민감 정보인 경우 default를 사용하지 않고 보호화된 인덱스를 사용합니다.
        // let secureIndex = CSSearchableIndex(name: "운동 일지", protectionClass:.complete)

        let defaultIndex = CSSearchableIndex.default() // 기본 인덱스
		    
        // 5. 색인시킬 아이템을 인덱스에 포함시킵니다; 색인 완료
        defaultIndex.indexSearchableItems(searchableItems) { error in
            if let error = error {
                print("Spotlight 색인 시도: \(error.localizedDescription)")
            } else {
                print("Spotlight 색인 성공")
            }
        }
    }
```

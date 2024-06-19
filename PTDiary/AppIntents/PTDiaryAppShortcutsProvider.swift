//
//  PTDiaryAppShortcutsProvider.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/18/24.
//

import AppIntents

struct PTDiaryAppShortcutsProvider: AppShortcutsProvider {
    static var shortcutTileColor: ShortcutTileColor = .blue
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: FindExercise(),
            phrases: ["운동 찾아줘"],
            shortTitle: "운동 찾기",
            systemImageName: "dumbbell"
        )
    }
}

func didCreateOrDeletePTDiary() {
    print("단축어 업데이트 시도")
    PTDiaryAppShortcutsProvider.updateAppShortcutParameters()
    print("단축어 업데이트 완료")
}

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
            intent: CreatePTDiary(), 
            phrases: ["새로운 운동 일지 작성해줘"],
            shortTitle: "새로운 운동 일지 작성",
            systemImageName: "square.and.pencil"
        )
    }
}

func didCreateOrDeletePTDiary() {
    PTDiaryAppShortcutsProvider.updateAppShortcutParameters()
}

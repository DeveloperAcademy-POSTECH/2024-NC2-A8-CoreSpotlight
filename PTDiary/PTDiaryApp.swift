//
//  PTDiaryApp.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/17/24.
//

import SwiftUI
import SwiftData

@main
struct PTDiaryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PTDiary.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        PTDiaryAppShortcutsProvider.updateAppShortcutParameters()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(sharedModelContainer)
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 앱 시작 시 호출
        didCreateOrDeletePTDiary()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        handleURL(url)
        return true
    }
    
    private func handleURL(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let host = components.host else {
            return
        }
        
        if host == "createPTDiary" {
            if let exercises = components.queryItems?.first(where: { $0.name == "exercises" })?.value {
                let ptDiary = PTDiary(
                    title: "새로운 PT 회차 운동 일지",
                    round: 1, // 실제 로직에 맞게 설정
                    date: Date(),
                    exercises: exercises.split(separator: ",").map { String($0) }
                )
                
                // 여기에 네비게이션 로직을 추가하여 DetailView로 이동합니다.
                // 예시:
                if let navigationController = window?.rootViewController as? UINavigationController {
                    let detailView = DetailView(ptDiary: ptDiary)
                    navigationController.pushViewController(UIHostingController(rootView: detailView), animated: true)
                }
            }
        }
    }
}

//
//  AchievementsApp.swift
//  Achievements
//
//  Created by Brent Mifsud on 2021-05-15.
//

import SwiftUI

@main
struct AchievementsApp: App {
	@StateObject private var achievementManager: AchievementManager = AchievementManager()
	
	var body: some Scene {
		WindowGroup {
			RootPage()
				.edgesIgnoringSafeArea(.all)
				.onAppear {
					do {
						try achievementManager.syncAchievements()
					} catch  {
						print("Unable to sync achievements")
					}
					
					UINavigationBar.appearance().tintColor = .white
					UINavigationBar.appearance().barTintColor = .navBarColor
					UINavigationBar.appearance().backgroundColor = .navBarColor
					UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
					UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
				}
				.environmentObject(achievementManager)
		}
	}
}

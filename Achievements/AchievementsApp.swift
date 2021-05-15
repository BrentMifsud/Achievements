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
				.onAppear {
					do {
						try achievementManager.syncAchievements()
					} catch  {
						print("Unable to sync achievements")
					}
				}
				.environmentObject(achievementManager)
		}
	}
}

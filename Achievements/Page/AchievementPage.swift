//
//  AchievementPage.swift
//  Achievements
//
//  Created by Brent Mifsud on 2021-05-15.
//

import SwiftUI

struct AchievementPage: View {
	var body: some View {
		NavigationView {
			Text("Achievement Page")
				.navigationBarTitle(Text(LocalizedStringKey("Achievements"), comment: "Achievements Title"), displayMode: .inline)
				.tabItem {
					Image.awardBadge
					Text(LocalizedStringKey("Achievements"), comment: "Achievements Tab")
				}
		}
	}
}

struct AchievementPage_Previews: PreviewProvider {
	static var previews: some View {
		AchievementPage()
	}
}

//
//  RootPage.swift
//  Achievements
//
//  Created by Brent Mifsud on 2021-05-15.
//

import SwiftUI

struct RootPage: View {
	var body: some View {
		TabView {
			AchievementPage()
		}
		.tabViewStyle(DefaultTabViewStyle())
	}
}

struct RootPage_Previews: PreviewProvider {
	static var previews: some View {
		RootPage()
	}
}

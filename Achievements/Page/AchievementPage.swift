//
//  AchievementPage.swift
//  Achievements
//
//  Created by Brent Mifsud on 2021-05-15.
//

import SwiftUI

struct AchievementPage: View {
	@EnvironmentObject private var achievementManager: AchievementManager
	
	var body: some View {
		NavigationView {
			List {
				personalRecordSection
				
				raceSection
			}
			.navigationBarTitle(Text(LocalizedStringKey("Achievements"), comment: "Achievements Title"), displayMode: .inline)
			.tabItem {
				Image.awardBadge
				Text(LocalizedStringKey("Achievements"), comment: "Achievements Tab")
			}
		}
	}
	
	private var personalRecordSection: some View {
		Section(header: recordSectionHeader) {
			Text("Personal Record Section")
		}
		.textCase(nil)
	}
	
	private var raceSection: some View {
		Section(header: raceSectionHeader) {
			Text("Virtual Race Section")
		}
		.textCase(nil)
	}
	
	private var recordSectionHeader: some View {
		Rectangle()
			.fill(Color.sectionHeaderColor)
			.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
			.overlay(
				HStack {
					Text(LocalizedStringKey("Personal Records"), comment: "record section title")
						.foregroundColor(.sectionTitleColor)
					Spacer()
					Text(LocalizedStringKey("\(1) of \(6)"), comment: "record secton count")
						.foregroundColor(.sectionCountColor)
				}
				.padding(.horizontal)
			)
	}
	
	private var raceSectionHeader: some View {
		Rectangle()
			.fill(Color.sectionHeaderColor)
			.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
			.overlay(
				Text(LocalizedStringKey("Virtual Races"), comment: "race section title")
					.foregroundColor(.sectionTitleColor)
					.padding(.horizontal),
				alignment: .leading
			)
	}
}

struct AchievementPage_Previews: PreviewProvider {
	static var previews: some View {
		AchievementPage()
			.environmentObject(AchievementManager())
	}
}

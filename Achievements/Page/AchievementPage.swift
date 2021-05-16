//
//  AchievementPage.swift
//  Achievements
//
//  Created by Brent Mifsud on 2021-05-15.
//

import SwiftUI

struct AchievementPage: View {
	@EnvironmentObject private var achievementManager: AchievementManager
	
	private let gridColumns = [
		GridItem(.flexible()),
		GridItem(.flexible())
	]
	
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
		.tabItem {
			VStack {
				Image.awardBadge
				Text(
					LocalizedStringKey("Achievements"),
					comment: "achievements tab"
				)
			}
		}
	}
	
	private var personalRecordSection: some View {
		Section(header: recordSectionHeader) {
			if achievementManager.achievements.isEmpty {
				Rectangle()
					.fill(Color.white)
					.frame(height: 250)
					.overlay(
						Text(
							LocalizedStringKey("There are no completed achievements."),
							comment: "Personal record empty list message."
						)
					)
			} else {
				LazyVGrid(columns: gridColumns, spacing: 16) {
					ForEach(Array(achievementManager.achievements.values), id: \.id) { achievement in
						AchievementView(achievement: achievement)
					}
				}
			}
		}
		.textCase(nil)
	}
	
	private var raceSection: some View {
		Section(header: raceSectionHeader) {
			if achievementManager.achievements.isEmpty {
				Rectangle()
					.fill(Color.white)
					.frame(height: 250)
					.overlay(
						Text(
							LocalizedStringKey("There are no completed virtual races."),
							comment: "Virtual races empty list message"
						)
					)
			} else {
				LazyVGrid(columns: gridColumns, spacing: 16) {
					ForEach(Array(achievementManager.achievements.values), id: \.id) { achievement in
						AchievementView(achievement: achievement)
					}
				}
			}
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

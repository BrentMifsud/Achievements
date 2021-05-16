//
//  AchievementPage.swift
//  Achievements
//
//  Created by Brent Mifsud on 2021-05-15.
//

import SwiftUI

struct AchievementPage: View {
	@EnvironmentObject private var achievementManager: AchievementManager
	@State private var alertType: AlertType? = nil
	
	private enum AlertType: String, Identifiable {
		var id: Self {
			return self
		}
		
		case back = "This button does nothing, but would go back to a previous page in a real app."
		case ellipsis = "This button does nothing. But probably opens a share sheet or context menu in real life"
	}
	
	private let gridColumns = [
		GridItem(.flexible()),
		GridItem(.flexible())
	]
	
	private var shouldShowList: Bool {
		if achievementManager.error != nil {
			return false
		}
		
		if achievementManager.isLoading {
			return true
		}
		
		if !achievementManager.personalRecords.isEmpty || !achievementManager.virtualRaces.isEmpty {
			return true
		}
		
		return false
	}
	
	@ViewBuilder private var achievementPage: some View {
		if let error = achievementManager.error {
			VStack {
				Spacer()
				
				Text(String(describing: error))
					.multilineTextAlignment(.leading)
				
				Spacer()
			}
		} else {
			ZStack {
				List {
					personalRecordSection
					raceSection
				}
				.listStyle(PlainListStyle())
				.zIndex(0)
				
				if achievementManager.isLoading {
					ProgressView()
						.progressViewStyle(CircularProgressViewStyle())
						.scaleEffect(2.0)
						.zIndex(1)
				}
			}
		}
	}
	
	var body: some View {
		NavigationView {
			achievementPage
				.alert(item: $alertType) { type in
					Alert(
						title: Text("\(type.rawValue)"),
						message: nil,
						dismissButton: .cancel(Text(LocalizedStringKey("OK"), comment: "ok button"))
					)
				}
				.navigationBarTitle(Text(LocalizedStringKey("Achievements"), comment: "Achievements Title"), displayMode: .inline)
				.navigationBarItems(
					leading: Button{
						alertType = .back
					} label: {
						Image.chevronLeft
					}
					.foregroundColor(.white),
					trailing: Button {
						alertType = .ellipsis
					} label: {
						Image.ellipsis
					}
					.foregroundColor(.white)
				)
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
			if shouldShowList {
				LazyVGrid(columns: gridColumns, spacing: 16) {
					ForEach(
						achievementManager.isLoading
							? dummyAchievements
							: achievementManager.personalRecords,
						id: \.id
					) { achievement in
						AchievementView(achievement: achievement)
					}
					
					Spacer()
				}
				.shouldRedact(achievementManager.isLoading)
			} else if achievementManager.personalRecords.isEmpty {
				Rectangle()
					.fill(Color.white)
					.frame(height: 250)
					.overlay(
						Text(
							LocalizedStringKey("There are no completed achievements."),
							comment: "Personal record empty list message."
						)
					)
			}
		}
		.textCase(nil)
	}
	
	@ViewBuilder private var raceSection: some View {
		if achievementManager.isLoading {
			EmptyView()
		} else {
			Section(header: raceSectionHeader) {
				if achievementManager.isLoading {
					EmptyView()
				} else if achievementManager.virtualRaces.isEmpty {
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
						ForEach(achievementManager.virtualRaces, id: \.id) { achievement in
							AchievementView(achievement: achievement)
						}
						
						Spacer()
					}
				}
			}
			.textCase(nil)
		}
	}
	
	private var recordSectionHeader: some View {
		Rectangle()
			.fill(Color.sectionHeaderColor)
			.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
			.overlay(
				HStack {
					Text(LocalizedStringKey("Personal Records"), comment: "record section title")
						.foregroundColor(.sectionTitleColor)
						.shouldRedact(achievementManager.isLoading)
					
					Spacer()
					
					Text(LocalizedStringKey("\(achievementManager.completedCount) of \(achievementManager.personalRecords.count)"), comment: "record secton count")
						.foregroundColor(.sectionCountColor)
						.shouldRedact(achievementManager.isLoading)
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

extension View {
	@ViewBuilder func shouldRedact(_ redacted: Bool) -> some View {
		if redacted {
			self.redacted(reason: .placeholder)
		} else {
			self
		}
	}
}

//
//  AchievementManager.swift
//  Achievements
//
//  Created by Brent Mifsud on 2021-05-15.
//

import Foundation
import SwiftUI

class AchievementManager: ObservableObject {
	private var fileManager = FileManager.default
	private var bundle = Bundle.main
	
	@Published var personalRecords = [AchievementViewModel]()
	@Published var virtualRaces = [AchievementViewModel]()
	@Published var isLoading: Bool = false
	@Published var error: Error? = nil
	
	// This is for the purposes of showing a loading animation.
	var dummyAchievements: [AchievementViewModel] = [
		AchievementViewModel(title: "Achievement 1", type: .personal, imageName: PersonalRecords.fastest10k.rawValue, unit: .duration),
		AchievementViewModel(title: "Achievement 2", type: .personal, imageName: PersonalRecords.fastest10k.rawValue, unit: .duration),
		AchievementViewModel(title: "Achievement 3", type: .personal, imageName: PersonalRecords.fastest10k.rawValue, unit: .duration),
		AchievementViewModel(title: "Achievement 4", type: .personal, imageName: PersonalRecords.fastest10k.rawValue, unit: .duration),
		AchievementViewModel(title: "Achievement 5", type: .personal, imageName: PersonalRecords.fastest10k.rawValue, unit: .duration),
		AchievementViewModel(title: "Achievement 6", type: .personal, imageName: PersonalRecords.fastest10k.rawValue, unit: .duration)
	]
	
	var fileURL: URL {
		// This should never happen, as the file is included part of the project.
		guard let url = bundle.url(forResource: "achievements-store", withExtension: "json") else {
			fatalError("Unable find json file!")
		}
		
		return url
	}
	
	var completedCount: Int {
		personalRecords.reduce(into: 0) { count, next in
			if next.isComplete {
				count += 1
			}
		}
	}
	
	init() {
		populateAchievements()
	}
	
	// To simulate an api call, I will run this on another thread and make it take 0.5 seconds to complete.
	private func populateAchievements() {
		isLoading = true
		
		// Since this class should never be deinitialized, it is safe to capture self.
		let dispatchTime = DispatchTime.now().advanced(by: .milliseconds(500))
		
		DispatchQueue.global(qos: .background).asyncAfter(deadline: dispatchTime) { [self] in
			let jsonDecoder = JSONDecoder()
			jsonDecoder.dateDecodingStrategy = .iso8601
			
			// This should never happen, as the file is part of the project.
			guard let data = fileManager.contents(atPath: fileURL.path) else {
				fatalError("Unable to read json file!")
			}
			
			do {
				let achievements = try jsonDecoder.decode([AchievementViewModel].self, from: data)
				
				// Publish on the main thread as it will impact the UI.
				DispatchQueue.main.async {
					self.personalRecords = achievements
						.filter(by: .personal)
						.sorted()
					
					self.virtualRaces = achievements
						.filter(by: .race)
						.sorted()
					
					self.isLoading = false
				}
			} catch {
				// Publish on the main thread as it will impact the UI.
				DispatchQueue.main.async {
					self.error = error
					self.isLoading = false
				}
			}
		}
	}
	
}

extension Collection where Element == AchievementViewModel {
	func filter(by type: AchievementViewModel.AchievementType) -> [AchievementViewModel] {
		self.filter { achievement in
			achievement.type == type
		}
	}
	
	func sorted() -> [AchievementViewModel] {
		self.sorted { lhs, rhs in
			guard let lhs = lhs.completedDate, let rhs = rhs.completedDate else { return false }
			return lhs > rhs
		}
	}
}

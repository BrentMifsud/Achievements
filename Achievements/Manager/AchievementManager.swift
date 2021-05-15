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
	
	@Published var achievements = [String: AchievementViewModel]()
	
	private let fileName: String
	private let fileExtension = "json"
	
	/// Initialize an achievement maneger with file location to save achievements to.
	/// - Parameter fileName: the file name to persist achievements
	/// - Note: It is recommended that you use the default here. Changing the filename is meant for testing purposes.
	init(fileName: String = "Achievements"){
		self.fileName = fileName
	}
	
	/// Sync the achievement manager with the achivements saved to the device.
	/// - Throws: File manager or decoding errors
	func syncAchievements() throws {
		let url = try getFileUrl()
		
		guard fileManager.fileExists(atPath: url.path) else {
			#if DEBUG
			print("AchievementManager -- No achievements file to read.")
			#endif
			return
		}
		
		let data = try Data(contentsOf: url)
		let jsonDecoder = JSONDecoder()
		
		do {
			let achievements = try jsonDecoder.decode([AchievementViewModel].self, from: data)
				.reduce(into: [String: AchievementViewModel](), { dict, next in
					dict[next.title] = next
				})
			self.achievements = achievements
		} catch {
			// Normally some sort of data migration would need to occur here.
			// But for the purposes of this test, we will toss away the achievements file if there are decoding errors.
			try clearAchievements()
		}
	}
	
	/// Updates the specified achievement.
	/// - Parameter achievement: The updated achievement.
	/// - Throws: Filemanager or encoding errors
	func updateAchievement(achievement: AchievementViewModel, isComplete: Bool) throws {
		guard var existing = achievements[achievement.id] else { return }
		guard existing.isComplete != isComplete else { return }
		
		existing.isComplete = isComplete
		
		if isComplete {
			existing.completedDate = Date()
		} else {
			existing.completedDate = nil
		}

		try saveAchievements()
	}
	
	/// Persist current achievement manager state
	/// - Throws: Encoding Errors or FileManager errors
	func saveAchievements() throws {
		guard !achievements.isEmpty else {
			#if DEBUG
			print("AchievementManager -- No achievements to save.")
			#endif
			return
		}
		
		let url = try getFileUrl()
		let jsonEncoder = JSONEncoder()
		let arrayToEncode = Array(achievements.values)
		let data = try jsonEncoder.encode(arrayToEncode)
		
		if fileManager.fileExists(atPath: url.path) {
			try fileManager.removeItem(at: url)
		}
		
		try data.write(to: url, options: .atomic)
	}
	
	/// Delete the achievement file from your device. Resetting all achievements.
	/// - Throws: FileManager Errors
	func clearAchievements() throws {
		self.achievements = [:]
		
		let url = try getFileUrl()
		
		if fileManager.fileExists(atPath: url.path) {
			try fileManager.removeItem(at: url)
		}
	}
	
	private func getFileUrl() throws -> URL{
		try fileManager
			.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
			.appendingPathComponent(fileName)
			.appendingPathExtension(fileExtension)
	}
}

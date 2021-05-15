//
//  AchievementManagerTest.swift
//  AchievementsTests
//
//  Created by Brent Mifsud on 2021-05-15.
//

@testable import Achievements
import UIKit
import XCTest

class AchievementManagerTest: XCTestCase {
	
	var sut: AchievementManager = AchievementManager(test: true)
	
	func clearFile() throws {
		let url = try FileManager.default
			.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
			.appendingPathComponent("Achievements-Test")
			.appendingPathExtension("json")
		
		if FileManager.default.fileExists(atPath: url.path) {
			try FileManager.default.removeItem(atPath: url.path)
		}
		
		sut.achievements = [:]
	}
	
	override func setUpWithError() throws {
		try clearFile()
	}
	
	override func tearDownWithError() throws {
		try clearFile()
	}
	
	func testSaveAchievements() throws {
		let achievements = UIImage.personalRecords.enumerated().reduce(into: [String: AchievementViewModel]()) { dict, next in
			let viewModel = AchievementViewModel(title: "Title \(next.0)", image: next.1, unit: .elevation, measurement: 10)
			dict[viewModel.id] = viewModel
		}
		
		sut.achievements = achievements
		XCTAssertNoThrow(try sut.saveAchievements())
		
		let url = try! FileManager.default
			.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
			.appendingPathComponent("Achievements-Test")
			.appendingPathExtension("json")
		
		
		let data = FileManager.default.contents(atPath: url.path)
		XCTAssertNotNil(data)
		let dataString = String(data: data!, encoding: .utf8)
		XCTAssertNotNil(dataString)
		XCTAssert(dataString!.contains("Title 2"))
	}
	
	func testSyncAchievements() throws {
		let achievements = UIImage.personalRecords.enumerated().reduce(into: [String: AchievementViewModel]()) { dict, next in
			let viewModel = AchievementViewModel(title: "Title \(next.0)", image: next.1, unit: .elevation, measurement: 10)
			dict[viewModel.id] = viewModel
		}
		
		sut.achievements = achievements
		try? sut.saveAchievements()
		
		XCTAssertNoThrow(try sut.syncAchievements())
		
		XCTAssert(!sut.achievements.isEmpty)
	}
	
	func testClearAchievements() throws {
		let achievements = UIImage.personalRecords.enumerated().reduce(into: [String: AchievementViewModel]()) { dict, next in
			let viewModel = AchievementViewModel(title: "Title \(next.0)", image: next.1, unit: .elevation, measurement: 10)
			dict[viewModel.id] = viewModel
		}
		
		sut.achievements = achievements
		try? sut.saveAchievements()
		try? sut.syncAchievements()
		
		XCTAssert(!sut.achievements.isEmpty)
		XCTAssertNoThrow(try sut.clearAchievements())
		XCTAssert(sut.achievements.isEmpty)
	}
	
	func testCompleteAchievement() {
		let achievement = AchievementViewModel(
			title: "Achievement 1",
			image: .fastest5k,
			unit: .duration,
			isComplete: false,
			completedDate: Date()
		)
		
		sut.achievements[achievement.id] = achievement
		
		try? sut.saveAchievements()
		
		// Ensure the acheivement was added propertly
		XCTAssertNotNil(sut.achievements[achievement.id])
		XCTAssert(!sut.achievements[achievement.id]!.isComplete)
		
		// Update the achievement
		XCTAssertNoThrow(try sut.updateAchievement(achievement: achievement, isComplete: true))
		
		// Ensure the achievement still exists
		XCTAssertNotNil(sut.achievements[achievement.id])
		XCTAssert(!sut.achievements[achievement.id]!.isComplete)
	}

}

extension AchievementManager {
	convenience init(test: Bool) {
		if test {
			self.init(fileName: "Achievements-Test")
		} else {
			self.init(fileName: "Achievements")
		}
	}
}

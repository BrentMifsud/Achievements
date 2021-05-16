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
	
	var sut: AchievementManager = AchievementManager()
	
	func testAchievementManager() {
		XCTAssert(!sut.personalRecords.isEmpty)
		XCTAssert(!sut.virtualRaces.isEmpty)
	}
}

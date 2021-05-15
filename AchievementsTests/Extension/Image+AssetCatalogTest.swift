//
//  Image+AssetCatalogTest.swift
//  AchievementsTests
//
//  Created by Brent Mifsud on 2021-05-15.
//

@testable import Achievements
import UIKit
import XCTest

class Image_AssetCatalogTest: XCTestCase {

	func testUIImageExtensionCanBeLoaded() {
		XCTAssertEqual(UIImage.personalRecords.count, 6)
		XCTAssertEqual(UIImage.virtualRaces.count, 7)
	}

}

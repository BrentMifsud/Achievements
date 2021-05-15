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

	func testAssetCatalogArrayCount() {
		XCTAssertEqual(UIImage.personalRecords.count, 6)
		XCTAssertEqual(UIImage.virtualRaces.count, 7)
	}
	
	func testAssetCatalogForceUnwrap() {
		_ = [
			UIImage.fastest5k,
			UIImage.fastest10k,
			UIImage.fastestHalfMarathon,
			UIImage.fastestMarathon,
			UIImage.highestElevation,
			UIImage.longestRun,
			UIImage.hakoneEkiden,
			UIImage.mizunoSingaporeEkiden,
			UIImage.tokyoHakoneEkiden2020,
			UIImage.virtual5kRace,
			UIImage.virtual10kRace,
			UIImage.virtualHalfMarathonRace,
			UIImage.virtualMarathonRace
		]
		
		// If the test makes it to this point, its safe to assume none of the force unwraps failed.
		XCTAssert(true)
	}

}

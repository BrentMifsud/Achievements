//
//  Double+TimeConverterTest.swift
//  AchievementsTests
//
//  Created by Brent Mifsud on 2021-05-15.
//

import Foundation
import XCTest
@testable import Achievements

class DoubleTimeConverterTest: XCTestCase {
	let time: Double = 3661
	let longTime: Double = 36615
	
	func testTimeConverterForHours() {
		let components = time.asTimeComponents
		
		XCTAssertEqual(1, components.hours)
		XCTAssertEqual(1, components.minutes)
		XCTAssertEqual(1, components.seconds)
	}
	
	func testTimeString() {
		let timeString = time.asTimeString
		let longTimeString = longTime.asTimeString
		
		XCTAssertEqual("01:01:01", timeString)
		XCTAssertEqual("10:10:15", longTimeString)
	}
}


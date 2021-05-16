//
//  AchievementViewModel.swift
//  Achievements
//
//  Created by Brent Mifsud on 2021-05-15.
//

import Foundation
import UIKit
import SwiftUI

struct AchievementViewModel: Identifiable, Hashable, Codable {
	enum AchievementUnit: String, Codable {
		case duration
		case elevation
		
		var measurementUnit: Unit {
			switch self {
			case .duration:
				return UnitDuration.seconds
			case .elevation:
				return UnitLength.meters
			}
		}
	}
	
	enum AchievementType: String, Codable {
		case personal
		case race
	}
	
	var id: String { title }
	let type: AchievementType
	let title: String
	let imageName: String
	var unit: AchievementUnit
	var measurement: Double?
	var isComplete: Bool
	var completedDate: Date?
	
	init(
		title: String,
		type: AchievementType,
		imageName: String,
		unit: AchievementUnit,
		measurement: Double? = nil,
		isComplete: Bool = false,
		completedDate: Date? = nil
	) {
		self.title = title
		self.type = type
		self.imageName = imageName
		self.unit = unit
		self.measurement = measurement
		self.isComplete = isComplete
		self.completedDate = completedDate
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		self.init(
			title: try container.decode(String.self, forKey: .title),
			type: try container.decode(AchievementType.self, forKey: .type),
			imageName: try container.decode(String.self, forKey: .image),
			unit: try container.decode(AchievementUnit.self, forKey: .unit),
			measurement: try container.decodeIfPresent(Double.self, forKey: .measurement),
			isComplete: try container.decode(Bool.self, forKey: .isComplete),
			completedDate: try container.decodeIfPresent(Date.self, forKey: .completedDate)
		)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		try container.encode(title, forKey: .title)
		try container.encode(type, forKey: .type)
		try container.encode(imageName, forKey: .image)
		try container.encode(unit, forKey: .unit)
		try container.encodeIfPresent(measurement, forKey: .measurement)
		try container.encode(isComplete, forKey: .isComplete)
		try container.encodeIfPresent(completedDate, forKey: .completedDate)
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	
	private enum CodingKeys: String, CodingKey {
		case title
		case type
		case image
		case unit
		case measurement
		case isComplete
		case completedDate
	}
}

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
	
	var id: String { title }
	let title: String
	let image: UIImage
	var unit: AchievementUnit
	var measurement: Double?
	var isComplete: Bool
	var completedDate: Date?
	
	init(
		title: String,
		image: UIImage,
		unit: AchievementUnit,
		measurement: Double? = nil,
		isComplete: Bool = false,
		completedDate: Date? = nil
	) {
		self.title = title
		self.image = image
		self.unit = unit
		self.measurement = measurement
		self.isComplete = isComplete
		self.completedDate = completedDate
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		let imageData = try container.decode(Data.self, forKey: .image)
		
		guard let image = UIImage(data: imageData) else {
			throw DecodingError.dataCorruptedError(
				forKey: .image,
				in: container,
				debugDescription: "Unable to produce image from image data."
			)
		}
		
		self.init(
			title: try container.decode(String.self, forKey: .title),
			image: image,
			unit: try container.decode(AchievementUnit.self, forKey: .unit),
			measurement: try container.decodeIfPresent(Double.self, forKey: .measurement),
			isComplete: try container.decode(Bool.self, forKey: .isComplete),
			completedDate: try container.decodeIfPresent(Date.self, forKey: .completedDate)
		)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		guard let imageData = image.pngData() else {
			throw EncodingError.invalidValue(
				image,
				EncodingError.Context(
					codingPath: encoder.codingPath,
					debugDescription: "Unable to convert image to image data for encoding."
				)
			)
		}
		
		try container.encode(title, forKey: .title)
		try container.encode(imageData, forKey: .image)
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
		case image
		case unit
		case measurement
		case isComplete
		case completedDate
	}
}

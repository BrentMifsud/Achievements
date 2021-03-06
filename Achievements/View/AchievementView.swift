//
//  AchievementView.swift
//  Achievements
//
//  Created by Brent Mifsud on 2021-05-15.
//

import SwiftUI

struct AchievementView: View {
	let achievement: AchievementViewModel
	
	var body: some View {
		VStack {
			Image(achievement.imageName)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.shadow(color: .black.opacity(0.6), radius: 4, x: 0, y: 5)
				.frame(width: 100)
			
			Text(achievement.title)
				.foregroundColor(.black)
				.font(.system(size: 12))
				.fontWeight(.bold)
				.multilineTextAlignment(.center)
				.lineLimit(2)
				.frame(width: 120)
			
			if let measurement = achievement.measurement {
				getText(for: measurement)
					.font(.system(size: 12))
					.foregroundColor(.black.opacity(0.8))
					.lineLimit(1)
			}
			
			Spacer()
		}
		.opacity(achievement.isComplete ? 1.0 : 0.2)
	}
	
	// If an achievement has not yet been completed, return nil.
	private func getText(for measurement: Double) -> Text {
		let measurementFormatter = MeasurementFormatter()
		
		var measurementString: String
		
		if achievement.unit == .elevation {
			let measurement = Measurement(value: measurement, unit: UnitLength.meters)
			measurementFormatter.locale = Locale.current
			measurementFormatter.unitOptions = .naturalScale
			measurementFormatter.numberFormatter.maximumFractionDigits = 0
			measurementString = measurementFormatter.string(from: measurement)
		} else {
			let measurement = Measurement(value: measurement, unit: UnitDuration.seconds)
			measurementString = measurement.value.asTimeString
		}
		
		return Text(measurementString)
	}
}

struct AchievementView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			AchievementView(
				achievement: AchievementViewModel(
					title: "Test Achievement",
					type: .personal,
					imageName: "fastest_5k",
					unit: .duration,
					measurement: 123
				)
			)
			.previewLayout(.sizeThatFits)
			
			AchievementView(
				achievement: AchievementViewModel(
					title: "Test Achievement",
					type: .personal,
					imageName: "fastest_5k",
					unit: .elevation,
					measurement: 123
				)
			)
			.previewLayout(.sizeThatFits)
			
			AchievementView(
				achievement: AchievementViewModel(
					title: "Test Achievement",
					type: .personal,
					imageName: "fastest_5k",
					unit: .elevation,
					measurement: 123
				)
			)
			.environment(\.locale, Locale(identifier: "en_CA"))
			.previewLayout(.sizeThatFits)
		}
	}
}

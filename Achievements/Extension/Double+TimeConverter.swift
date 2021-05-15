//
//  Double+TimeConverter.swift
//  Achievements
//
//  Created by Brent Mifsud on 2021-05-15.
//

import Foundation

extension Double {
	/// Returns the double (in seconds) to time components.
	var asTimeComponents: (hours: Int, minutes: Int, seconds: Int) {
		let selfAsInt = Int(self)
		
		let hourCoefficient = 3600
		let minuteCoefficient = 60
		
		let hours = selfAsInt / hourCoefficient
		let minutes = selfAsInt / minuteCoefficient - hours * minuteCoefficient
		let seconds = selfAsInt - (selfAsInt / minuteCoefficient) * minuteCoefficient
		return (hours: hours, minutes: minutes, seconds: seconds)
	}
	
	var asTimeString: String {
		let components = self.asTimeComponents
		
		let hours = components.hours < 10 ? "0\(components.hours)" : "\(components.hours)"
		let minutes = components.minutes < 10 ? "0\(components.minutes)" : "\(components.minutes)"
		let seconds = components.seconds < 10 ? "0\(components.seconds)" : "\(components.seconds)"
		
		return "\(hours):\(minutes):\(seconds)"
	}
}

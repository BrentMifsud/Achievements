//
//  Image+AssetCatalog.swift
//  Achievements
//
//  Created by Brent Mifsud on 2021-05-15.
//

import Foundation
import struct SwiftUI.Image
import class UIKit.UIImage

// Add the asset catalog images statically to SwiftUI's Image struct
extension Image {
	// Static properties for personal record images
	static let fastest5k: Self = Image(PersonalRecords.fastest5k.rawValue)
	static let fastest10k: Self = Image(PersonalRecords.fastest10k.rawValue)
	static let fastestHalfMarathon: Self = Image(PersonalRecords.fastestHalfMarathon.rawValue)
	static let fastestMarathon: Self = Image(PersonalRecords.fastestMarathon.rawValue)
	static let highestElevation: Self = Image(PersonalRecords.highestElevation.rawValue)
	static let longestRun: Self = Image(PersonalRecords.longestRun.rawValue)
	
	// Static properties for virtual race images
	static let hakoneEkiden: Self = Image(VirtualRaces.hakoneEkiden.rawValue)
	static let mizunoSingaporeEkiden: Self = Image(VirtualRaces.mizunoSingaporeEkiden.rawValue)
	static let tokyoHakoneEkiden2020: Self = Image(VirtualRaces.tokyoHakoneEkiden2020.rawValue)
	static let virtual5kRace: Self = Image(VirtualRaces.virtual5kRace.rawValue)
	static let virtual10kRace: Self = Image(VirtualRaces.virtual10kRace.rawValue)
	static let virtualHalfMarathonRace: Self = Image(VirtualRaces.virtualHalfMarathonRace.rawValue)
	static let virtualMarathonRace: Self = Image(VirtualRaces.virtualMarathonRace.rawValue)
	
	static var personalRecords: [Self] {
		PersonalRecords.allCases.map { personalRecord in
			Image(personalRecord.rawValue)
		}
	}
	
	static var virtualRaces: [Self] {
		VirtualRaces.allCases.map { virtualRace in
			Image(virtualRace.rawValue)
		}
	}
}

// Add the asset catalog images statically to UIKit's UIImage class
extension UIImage {
	// Safe to force unwrap these. I have added a test case to ensure that these images can be loaded.
	// Static properties for personal record images
	static let fastest5k = UIImage(named: PersonalRecords.fastest5k.rawValue)!
	static let fastest10k = UIImage(named: PersonalRecords.fastest10k.rawValue)!
	static let fastestHalfMarathon = UIImage(named: PersonalRecords.fastestHalfMarathon.rawValue)!
	static let fastestMarathon = UIImage(named: PersonalRecords.fastestMarathon.rawValue)!
	static let highestElevation = UIImage(named: PersonalRecords.highestElevation.rawValue)!
	static let longestRun = UIImage(named: PersonalRecords.longestRun.rawValue)!
	
	// Static properties for virtual race UIImage
	static let hakoneEkiden = UIImage(named: VirtualRaces.hakoneEkiden.rawValue)!
	static let mizunoSingaporeEkiden = UIImage(named: VirtualRaces.mizunoSingaporeEkiden.rawValue)!
	static let tokyoHakoneEkiden2020 = UIImage(named: VirtualRaces.tokyoHakoneEkiden2020.rawValue)!
	static let virtual5kRace = UIImage(named: VirtualRaces.virtual5kRace.rawValue)!
	static let virtual10kRace = UIImage(named: VirtualRaces.virtual10kRace.rawValue)!
	static let virtualHalfMarathonRace = UIImage(named: VirtualRaces.virtualHalfMarathonRace.rawValue)!
	static let virtualMarathonRace = UIImage(named: VirtualRaces.virtualMarathonRace.rawValue)!
	
	static var personalRecords: [UIImage] {
		PersonalRecords.allCases.compactMap { personalRecord in
			UIImage(named: personalRecord.rawValue)
		}
	}
	
	static var virtualRaces: [UIImage] {
		VirtualRaces.allCases.compactMap { virtualRace in
			UIImage(named: virtualRace.rawValue)
		}
	}
}

fileprivate enum PersonalRecords: String, CaseIterable {
	case fastest5k = "fastest_5k"
	case fastest10k = "fastest_10k"
	case fastestHalfMarathon = "fastest_half_marathon"
	case fastestMarathon = "fastest_marathon"
	case highestElevation = "highest_elevation"
	case longestRun = "longest_run"
}

fileprivate enum VirtualRaces: String, CaseIterable {
	case hakoneEkiden = "hakone_ekiden"
	case mizunoSingaporeEkiden = "mizuno_singapore_ekiden"
	case tokyoHakoneEkiden2020 = "tokyo-hakone-ekiden-2020"
	case virtual5kRace = "virtual_5k_race"
	case virtual10kRace = "virtual_10k_race"
	case virtualHalfMarathonRace = "virtual_half_marathon_race"
	case virtualMarathonRace = "virtual_marathon_race"
}

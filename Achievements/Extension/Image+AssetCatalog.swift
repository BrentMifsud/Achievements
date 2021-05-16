//
//  Image+AssetCatalog.swift
//  Achievements
//
//  Created by Brent Mifsud on 2021-05-15.
//

import Foundation
import struct SwiftUI.Image
import class UIKit.UIImage

/*
Manually typing the name of image assets is error prone, and subject to failures due to typos.
Its best to make an extension so all of your potential errors are isolated to one spot.
*/

// Add the asset catalog images statically to SwiftUI's Image struct
extension Image {
	// Static properties for personal record images
	static let fastest5k = Image(PersonalRecords.fastest5k.rawValue)
	static let fastest10k = Image(PersonalRecords.fastest10k.rawValue)
	static let fastestHalfMarathon = Image(PersonalRecords.fastestHalfMarathon.rawValue)
	static let fastestMarathon = Image(PersonalRecords.fastestMarathon.rawValue)
	static let highestElevation = Image(PersonalRecords.highestElevation.rawValue)
	static let longestRun = Image(PersonalRecords.longestRun.rawValue)
	
	// Static properties for virtual race images
	static let hakoneEkiden = Image(VirtualRaces.hakoneEkiden.rawValue)
	static let mizunoSingaporeEkiden = Image(VirtualRaces.mizunoSingaporeEkiden.rawValue)
	static let tokyoHakoneEkiden2020 = Image(VirtualRaces.tokyoHakoneEkiden2020.rawValue)
	static let virtual5kRace = Image(VirtualRaces.virtual5kRace.rawValue)
	static let virtual10kRace = Image(VirtualRaces.virtual10kRace.rawValue)
	static let virtualHalfMarathonRace = Image(VirtualRaces.virtualHalfMarathonRace.rawValue)
	static let virtualMarathonRace = Image(VirtualRaces.virtualMarathonRace.rawValue)
	
	// Static property for tab bar icons
	static let awardBadge = Image(TabBarIcons.awardBadge.rawValue)
	static let settings = Image(systemName: TabBarIcons.settings.rawValue)
	
	// Static property for nav bar items
	static let chevronLeft = Image(systemName: NavBarIcons.chevronLeft.rawValue)
	static let ellipsis = Image(systemName: NavBarIcons.ellipsis.rawValue)
	
	static var personalRecords: [Image] {
		PersonalRecords.allCases.map { personalRecord in
			Image(personalRecord.rawValue)
		}
	}
	
	static var virtualRaces: [Image] {
		VirtualRaces.allCases.map { virtualRace in
			Image(virtualRace.rawValue)
		}
	}
	
	static var tabBarImages: [Image] {
		TabBarIcons.allCases.map { tabBarIcon in
			tabBarIcon.isSfSymbol ? Image(systemName: tabBarIcon.rawValue) : Image(tabBarIcon.rawValue)
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
	
	// Static property for tab bar icons
	static let awardBadge = UIImage(named: TabBarIcons.awardBadge.rawValue)!
	static let settings = UIImage(systemName: TabBarIcons.settings.rawValue)!
	
	// Static property for nav bar items
	static let chevronLeft = UIImage(systemName: NavBarIcons.chevronLeft.rawValue)!
	static let ellipsis = UIImage(systemName: NavBarIcons.ellipsis.rawValue)!
	
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
	
	static var tabBarImages: [UIImage] {
		TabBarIcons.allCases.compactMap { tabBarIcon in
			tabBarIcon.isSfSymbol ? UIImage(systemName: tabBarIcon.rawValue) : UIImage(named: tabBarIcon.rawValue)
		}
	}
}

enum PersonalRecords: String, CaseIterable {
	case fastest5k = "fastest_5k"
	case fastest10k = "fastest_10k"
	case fastestHalfMarathon = "fastest_half_marathon"
	case fastestMarathon = "fastest_marathon"
	case highestElevation = "highest_elevation"
	case longestRun = "longest_run"
	
	var name: String {
		switch self {
		case .fastest5k:
			return "Fastest 5k"
		case .fastest10k:
			return "Fastest 10k"
		case .fastestHalfMarathon:
			return "Fastest Half-Marathon"
		case .fastestMarathon:
			return "Fastest Marathon"
		case .highestElevation:
			return "Highest Elevation"
		case .longestRun:
			return "Longest Run"
		}
	}
	
	var unit: AchievementViewModel.AchievementUnit {
		switch self {
		case .fastest5k,
			 .fastest10k,
			 .fastestHalfMarathon,
			 .fastestMarathon,
			 .longestRun:
			return .duration
		case .highestElevation:
			return .elevation
		}
	}
}

enum VirtualRaces: String, CaseIterable {
	case hakoneEkiden = "hakone_ekiden"
	case mizunoSingaporeEkiden = "mizuno_singapore_ekiden"
	case tokyoHakoneEkiden2020 = "tokyo-hakone-ekiden-2020"
	case virtual5kRace = "virtual_5k_race"
	case virtual10kRace = "virtual_10k_race"
	case virtualHalfMarathonRace = "virtual_half_marathon_race"
	case virtualMarathonRace = "virtual_marathon_race"
	
	var name: String {
		switch self {
		case .hakoneEkiden:
			return "Hakone Ekiden"
		case .mizunoSingaporeEkiden:
			return "Mizuno-Singapore Ekiden"
		case .tokyoHakoneEkiden2020:
			return "Tokyo-Hakone Ekiden 2020"
		case .virtual5kRace:
			return "Virtual 5k Race"
		case .virtual10kRace:
			return "Virtual 10k Race"
		case .virtualHalfMarathonRace:
			return "Virtual Half-Marathon Race"
		case .virtualMarathonRace:
			return "Virtual Marathon Race"
		}
	}
	
	var unit: AchievementViewModel.AchievementUnit {
		return .duration
	}
}

fileprivate enum NavBarIcons: String, CaseIterable {
	case chevronLeft = "chevron.left"
	case ellipsis = "ellipsis"
}

fileprivate enum TabBarIcons: String, CaseIterable {
	case awardBadge = "award_badge"
	case settings = "gearshape"
	
	var isSfSymbol: Bool {
		switch self {
		case .awardBadge:
			return false
		case .settings:
			return true
		}
	}
}

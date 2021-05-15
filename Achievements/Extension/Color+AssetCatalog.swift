//
//  Color+AssetCatalog.swift
//  Achievements
//
//  Created by Brent Mifsud on 2021-05-15.
//

import Foundation
import struct SwiftUI.Color
import class UIKit.UIColor

extension Color {
	static let navBarColor = Color(ColorNames.navBarColor.rawValue)
	static let sectionCountColor = Color(ColorNames.sectionCountColor.rawValue)
	static let sectionHeaderColor = Color(ColorNames.sectionHeaderColor.rawValue)
	static let sectionTitleColor = Color(ColorNames.sectionTitleColor.rawValue)
}

extension UIColor {
	static let navBarColor = UIColor(named: ColorNames.navBarColor.rawValue)!
	static let sectionCountColor = UIColor(named: ColorNames.sectionCountColor.rawValue)!
	static let sectionHeaderColor = UIColor(named: ColorNames.sectionHeaderColor.rawValue)!
	static let sectionTitleColor = UIColor(named: ColorNames.sectionTitleColor.rawValue)!
}

fileprivate enum ColorNames: String {
	case navBarColor = "nav_bar_color"
	case sectionCountColor = "section_count_color"
	case sectionHeaderColor = "section_header_color"
	case sectionTitleColor = "section_title_color"
}


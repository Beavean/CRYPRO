//
//  SystemImage.swift
//  Crypro
//
//  Created by Antomated on 06.05.2024.
//

import SwiftUI

enum SystemImage: String {
    case linkIcon = "arrow.up.right.square"
    case statisticChangeArrow = "triangle.fill"
    case plus
    case info
    case chevronRight = "chevron.right"
    case magnifyingGlass = "magnifyingglass"
    case xMarkCircleFill = "xmark.circle.fill"
    case questionMark = "questionmark"
    case chevronDown = "chevron.down"
    case goForward = "goforward"
    case xMark = "xmark"
    case thrash = "trash.circle.fill"
    case filledPlus = "plus.circle.fill"

    var image: Image {
        Image(systemName: rawValue)
    }
}

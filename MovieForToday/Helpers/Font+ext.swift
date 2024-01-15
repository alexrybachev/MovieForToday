//
//  Font+ext.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 24.12.2023.
//

import SwiftUI

enum CustomFont: String {
    case montMedium = "Montserrat-Medium"
    case montRegular = "Montserrat-Regular"
    case montSemiBold = "Montserrat-SemiBold"
}

extension Font {
    static func custom(_ nameFont: CustomFont, size: CGFloat) -> SwiftUI.Font {
        SwiftUI.Font.custom(nameFont.rawValue, size: size)
    }
    
    static func montMedium(_ size: CGFloat) -> Font {
        custom(.montMedium, size: size)
    }
    
    static let montMedium14 = Font.montMedium(14)
}

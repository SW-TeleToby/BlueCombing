//
//  Colors.swift
//  BlueCombing
//
//  Created by Jun.Mac on 2022/09/16.
//

import SwiftUI

extension Color {
    static let combingBlue1 = Color("combingBlue1")
    static let combingBlue2 = Color("combingBlue2")
    static let combingBlue3 = Color("combingBlue3")
    static let combingBlue4 = Color("combingBlue4")
    static let combingBlue5 = Color("combingBlue5")
    static let combingGray1 = Color("combingGray1")
    static let combingGray2 = Color("combingGray2")
    static let combingGray3 = Color("combingGray3")
    static let combingGray4 = Color("combingGray4")
    static let combingGray5 = Color("combingGray5")
    static let combingGray6 = Color("combingGray6")
    static let combingGradient1 = LinearGradient(gradient: Gradient(colors: [Color("combingBlue4"), Color("gradient1")]), startPoint: .leading, endPoint: .trailing)
    static let combingGradient2 = LinearGradient(gradient: Gradient(colors: [Color("combingBlue4"), Color("gradient2")]), startPoint: .leading, endPoint: .trailing)
    static let combingGradient3 = LinearGradient(gradient: Gradient(colors: [Color("combingGray1"), Color("gradient3")]), startPoint: .leading, endPoint: .trailing)
    static let combingBlue5_2 = Color("combingBlue5").opacity(0.6)
}

//
//  AppData.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/09/16.
//

import Foundation
import SwiftUI

enum Tab: String, CaseIterable {
    case label1 = "Label1"
    case label2 = "Label2"
    case label3 = "Label3"

    var title: String {
        rawValue
    }

    var systemImageName: String {
        switch self {
        case .label1: return "banknote"
        case .label2: return "banknote"
        case .label3: return "banknote"
        }
    }

    @ViewBuilder
    var view: some View {
        switch self {
        case .label1: TotalMapView()
        case .label2: Text("Hello World")
        case .label3: Text("Hello World")
        }
    }
}

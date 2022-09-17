//
//  AppData.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/09/16.
//

import Foundation
import SwiftUI

enum Tab: String, CaseIterable {
    case beachCombing = "비치코밍"
    case tour = "관광"
    case myInfo = "나의 활동"

    var title: String {
        rawValue
    }

    var ImageName: String {
        switch self {
        case .beachCombing: return "icn_beach"
        case .tour: return "icn_myact"
        case .myInfo: return "icn_tour"
        }
    }

    @ViewBuilder
    var view: some View {
        switch self {
        case .beachCombing: TotalMapView()
        case .tour: AtractionView()
        case .myInfo: Text("Hello World")
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }
    }
}

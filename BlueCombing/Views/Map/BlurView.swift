//
//  BlurView.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/10/13.
//

import Foundation
import UIKit
import SwiftUI

struct BlurView: UIViewRepresentable {
    var effect: UIVisualEffect = UIBlurEffect(style: .init(rawValue: 3)!)
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }
}

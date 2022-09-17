//
//  Lottie.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/17.
//

import Foundation
import SwiftUI
import Lottie
import UIKit

struct LottieView: UIViewRepresentable {
    var name : String
    var loopMode: LottieLoopMode
    
    init(jsonName: String = "", loopMode : LottieLoopMode = .loop){
        self.name = jsonName
        self.loopMode = loopMode
    }
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)

        let animationView = AnimationView()
        let animation = Animation.named(name)
        animationView.animationSpeed = 0.1
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

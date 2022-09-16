//
//  CustomModalView.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/09/16.
//

import SwiftUI

struct CustomModalView<Content: View>: View {
    @Binding var isShown: Bool
    var height: CGFloat
    var isreverse: Bool = false
    @ViewBuilder var label: Content
    @State var moveheight = CGFloat.zero
    
    var body: some View {
        VStack {
            Spacer()
            
            label
                .frame(height: height, alignment: .bottomTrailing)
                .offset(y: moveheight)
                .onChange(of: isShown) { value in
                    withAnimation {
                        if isreverse {
                            if value {
                                moveheight = 0
                            } else {
                                moveheight = height * 2
                            }
                        } else {
                            if value {
                                moveheight = height * 2
                            } else {
                                moveheight = 0
                            }
                        }
                    }
            } // onChange
        }
    }
}


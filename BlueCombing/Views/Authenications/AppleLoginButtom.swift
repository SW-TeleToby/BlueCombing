//
//  AppleLoginButton.swift
//  BlueCombing
//
//  Created by Wonhyuk Choi on 2022/09/16.
//

import SwiftUI

struct AppleLoginButtom: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            self.action()
        } label: {
            Text("Apple 로그인")
                .frame(minWidth: 0, maxWidth: .infinity)
                .font(.custom("Pretendard-Bold", size: 16))
                .padding(.vertical, 19)
                .foregroundColor(.white)
        }
        .background(Color(hex: 0x131313)) // If you have this
        .cornerRadius(16)
    }
}

struct AppleLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AppleLoginButtom(action: {
            print("Apple Login Button Tapped")
        })
        .previewLayout(.sizeThatFits)
    }
}

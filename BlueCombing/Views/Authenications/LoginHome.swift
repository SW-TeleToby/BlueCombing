//
//  LoginHome.swift
//  BlueCombing
//
//  Created by Wonhyuk Choi on 2022/09/11.
//

import SwiftUI

struct LoginHome: View {
    @Environment(\.window) var window: UIWindow?
    @Environment(\.presentationMode) var presentationMode
    @State private var appleLoginCoordinator: AppleAuthCoordinator?
    @Binding var isSignIn: Bool
    
    var body: some View {
        VStack {
            Button {
                appleLogin()
            } label: {
                Text("애플 로그인")
            }
            FaceBookLoginView {
                presentationMode.wrappedValue.dismiss()
                isSignIn = true
            }
            .frame(width: 180, height: 50,alignment: .center).padding(10)
        }
    }
    
    func appleLogin() {
        appleLoginCoordinator = AppleAuthCoordinator(window: window) {
            presentationMode.wrappedValue.dismiss()
            isSignIn = true
        }
        appleLoginCoordinator?.startSignInWithAppleFlow()
    }
}

struct LoginHome_Previews: PreviewProvider {
    static var previews: some View {
        LoginHome(isSignIn: .constant(false))
    }
}

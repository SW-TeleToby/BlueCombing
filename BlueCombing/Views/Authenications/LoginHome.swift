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
    
    let loginMode: LoginMode
    let dismissAction: () -> Void
    
    var guide: String = ""
    
    init(isSignIn: Binding<Bool>, loginMode: LoginMode, dismissAction: @escaping () -> Void) {
        self._isSignIn = isSignIn
        self.loginMode = loginMode
        self.dismissAction = dismissAction
        
        switch loginMode {
        case .beachCombing:
            guide = "카드를 만들기 위해선\n로그인이 필요해요!"
        case .myActivity:
            guide = "나의 활동을 기록하기 위해선\n로그인이 필요해요!"
        }
    }
    
    var body: some View {
        ZStack {
            Color.combingBlue1
                .ignoresSafeArea()
            VStack(spacing: 8) {
                Spacer()
                Image("img_login")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 30)
                Text(guide)
                    .font(.custom("Pretendard-SemiBold", size: 24))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                Spacer()
                AppleLoginButtom {
                    appleLogin()
                }
                .padding(.horizontal)
                FaceBookLoginButton {
                    presentationMode.wrappedValue.dismiss()
                    isSignIn = true
                }
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 56)
                .padding(.horizontal)
                .padding(.bottom, 8)
                if loginMode == .beachCombing {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        isSignIn = false
                    } label: {
                        Text("로그인하지 않을래요")
                            .font(.custom("Pretendard-SemiBold", size: 16))
                            .foregroundColor(.combingGray4)
                    }
                    .padding(.bottom, 21)
                }
            }
        }
        .onDisappear {
            self.dismissAction()
        }
    }
    
    func appleLogin() {
        appleLoginCoordinator = AppleAuthCoordinator(window: window) {
            isSignIn = true
            presentationMode.wrappedValue.dismiss()
        }
        appleLoginCoordinator?.startSignInWithAppleFlow()
    }
}

enum LoginMode {
    case beachCombing
    case myActivity
}

struct LoginHome_Previews: PreviewProvider {
    static var previews: some View {
        LoginHome(isSignIn: .constant(false), loginMode: .beachCombing) {
            
        }
    }
}

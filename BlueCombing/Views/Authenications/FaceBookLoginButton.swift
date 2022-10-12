//
//  FaceBookLoginButton.swift
//  BlueCombing
//
//  Created by Wonhyuk Choi on 2022/09/11.
//

import SwiftUI
import FBSDKLoginKit
import Firebase

struct FaceBookLoginButton: UIViewRepresentable {
    let action: () -> Void
    
    func makeCoordinator() -> Coordinator { return Coordinator(self) }
    
    class Coordinator: NSObject {
        var parent: FaceBookLoginButton
        
        init(_ parent: FaceBookLoginButton) {
            self.parent = parent
            super.init()
        }
        
        // Once the button is clicked, show the login dialog
        @objc func loginButtonClicked(_ sender: Any) {
            print("heelo")
            let loginManager = LoginManager()
            loginManager.logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
                if let error = error {
                    print("Encountered Erorr: \(error)")
                } else if let result = result, result.isCancelled {
                    print("Cancelled")
                } else {
                    let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                    Auth.auth().signIn(with: credential) { (authResult, error) in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        
                        self.parent.action()
                    }
                    print("Logged In")
                }
            }
        }
    }
    
    func makeUIView(context: Context) -> UIButton {
        // Add a custom login button to your app
        let loginButton = UIButton(type: .system)
        loginButton.backgroundColor = UIColor(hex: 0x0037C0)
        loginButton.tintColor = .white
        loginButton.setTitle("Facebook 로그인", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 16)
        loginButton.layer.cornerRadius = 16
        
        loginButton.addTarget(context.coordinator, action: #selector(Coordinator.loginButtonClicked(_ :)), for: .touchUpInside)
        
        return loginButton
    }
    
    func updateUIView(_ uiView: UIButton, context: Context) { }
}

struct FaceBookLoginView_Previews: PreviewProvider {
    static var previews: some View {
        FaceBookLoginButton {
            print("FaceBook Login Button Tapped")
        }
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 56)
        .previewLayout(.sizeThatFits)
    }
}

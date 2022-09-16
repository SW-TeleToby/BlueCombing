  //
//  ContentView.swift
//  BlueCombing
//
//  Created by Wonhyuk Choi on 2022/09/11.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    let firebaseAuth = Auth.auth()
    @State var isSignIn = false
    @ObservedObject var userVM = UserViewModel()
    
    var body: some View {
        NavigationView {
            if isSignIn {
                VStack {
                    Text("안녕하세요 \(firebaseAuth.currentUser?.email ?? "")")
                    Button {
                        do {
                            try firebaseAuth.signOut()
                            self.isSignIn = false
                        } catch let signOutError as NSError {
                            print("Error: signout \(signOutError.localizedDescription)")
                        }
                    } label: {
                        Text("로그아웃")
                    }
                }
            } else {
                NavigationLink {
                    LoginHome(isSignIn: $isSignIn)
                } label: {
                    Text("로그인하러 가기")
                }
            }
        }
        .onAppear {
            if firebaseAuth.currentUser != nil {
                isSignIn = true
                userVM.getUserData(uid: firebaseAuth.currentUser!.uid)
            } else {
                isSignIn = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  SessionStore.swift
//  BlueCombing
//
//  Created by Wonhyuk Choi on 2022/10/17.
//

import FirebaseAuth

class SessionStore: ObservableObject {
    var uid : String? {
        Auth.auth().currentUser?.uid
    }
    
    var isSignIn: Bool {
        Auth.auth().currentUser?.uid != nil
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
    }
}

//
//  UserViewModel.swift
//  BlueCombing
//
//  Created by Wonhyuk Choi on 2022/09/11.
//

import Foundation
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var user: User?
    
    private var db = Firestore.firestore()
    
    // MARK: - 유저 정보 Create
    func addUserData(uid: String) {
        db.collection("users").document(uid).setData([
            "total_distance": 0,
            "total_time": 0,
            "my_badge": ["산호초","조개","해마","해파리"],
            "my_cards": [],
            "represent_badge": "해파리"
        ]) { error in
            if error == nil {
                self.getUserData(uid: uid)
            }
        }
    }
    
    // MARK: - 유저 정보 Read
    func getUserData(uid: String) {
        db.collection("users").document(uid).addSnapshotListener { snapshot, error in
            if error == nil {
                if let snapshot = snapshot, snapshot.exists {
                    DispatchQueue.main.async {
                        let data = snapshot.data()
                        self.user = User(
                            id: uid,
                            totalDistance: data!["total_distance"] as? Int ?? 0,
                            totalTime: data!["total_time"] as? Int ?? 0,
                            myBadges: data!["my_badge"] as? [String] ?? [],
                            myCards: data!["my_cards"] as? [String] ?? [],
                            representBadge: data!["represent_badge"] as? String ?? ""
                        )
                    }
                } else {
                    self.addUserData(uid: uid)
                }
            }
        }
    }
    
    // MARK: - 유저 정보 Update
    func updateUser(uid: String, info: [AnyHashable : Any]) {
        db.collection("users").document(uid).updateData(info) { error in
            if error == nil {
                self.getUserData(uid: uid)
            }
        }
    }
    
    // MARK: - 유저 정보 Delete
    func deleteData(userToDelete: User) {
        db.collection("users").document(userToDelete.id).delete { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed!")
            }
        }
        
    }
}

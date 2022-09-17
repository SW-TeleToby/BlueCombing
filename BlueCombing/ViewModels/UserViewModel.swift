//
//  UserViewModel.swift
//  BlueCombing
//
//  Created by Wonhyuk Choi on 2022/09/11.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var user: User?
    @Published var combingImages: [UIImage] = []
    public static var cardList: Set<String> = []
    private var db = Firestore.firestore()
    
    // MARK: - 유저 정보 Create
    func addUserData(uid: String) {
        db.collection("users").document(uid).setData([
            "total_distance": 0,
            "total_time": 0,
            "my_badge": ["산호초"],
            "my_cards": [],
            "represent_badge": "산호초"
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
    
    //MARK: - 이미지 파이어 스토어 저장 로직
    func uploadPicture(image: UIImage) {
        //        guard selectedImage != nil else {
        //            return
        //        }
        
        
        // 스토리지 레퍼런스 생성
        let storageRef = Storage.storage().reference()
        
        // 이미지 -> 데이터로 변경
        let imageData = image.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else {
            return
        }
        
        // 파일 이름과 경로 특정짓기.
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        // 데이터 업로드
        var past_list = self.user!.myCards
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { meta, error in
            // 에러 체크
            if error == nil && meta != nil {
                // 파일의 레퍼런스를 파이어스토어에 저장.
                past_list.append(path)
                self.updateUser(uid: self.user!.id, info: ["my_cards": past_list])
                
            }
        }
    }
    
    // MARK: - 유저 정보 Read
    func getUserImages(uid: String) {
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
                        self.retrievePhotos(user: self.user!)
                    }
                } else {
                    self.addUserData(uid: uid)
                }
            }
        }
    }
    
    //MARK: - 이미지 파이어 스토어에서 불러오기 로직
    func retrievePhotos(user: User) {
        // 임시로 저장할 사진. 그냥 변수에 갖다박자
        // 데이터베이스에서 데이터 겟
        
        // 스토리지에서 이미지 데이터 얻기
        let storageRef = Storage.storage().reference()
        for path in user.myCards {
            if UserViewModel.cardList.contains(path) {
                continue
            }
            UserViewModel.cardList.insert(path)
            let fileRef = storageRef.child(path)
            fileRef.getData(maxSize: 5 * 1024 * 1024) {data, error in
                if error == nil && data != nil {
                    if let image = UIImage(data: data!) {
                        DispatchQueue.main.async {
                            self.combingImages.append(image)
                        }
                    }
                }
            }
        }
        // 이미지 디스플레이하기.
    }
    
    
}

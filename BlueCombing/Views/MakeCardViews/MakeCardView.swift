//
//  MakeCardView.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/16.
//

import SwiftUI
import Photos
import FirebaseAuth

struct MakeCardView: View {
    @StateObject var cardViewModel = CardViewModel()
    @ObservedObject var userViewModel = UserViewModel()
    @Environment(\.dismiss) var dismiss
    @State var showingOption = false
    @State var isPresentedCamera = false
    @State var isPresentedAllImage = false
    @State var isPresentedLimitedImage = false
    @State var isPresentedPermissionCheck = false
    @State var isPresentShareView = false
    @State var cameraDenyAlert = false
    @State var isSignin = false
    @State var presentBadge = ""
    var isCustom: Bool
    var movingDistance : Double
    var movingTime : Int
    var routeImage: Image
    
    let firebaseAuth = Auth.auth()
    
    var SaveImageView: some View {
        VStack(spacing:0){
            ZStack{
                CardView(card: $cardViewModel.newCard)
                routeImage
                    .resizable()
                    .frame(width: containerWidth/2, height: containerWidth/2)
            }.frame(width: containerWidth, height: imageHeight)
            
        // .edgesIgnoringSafeArea(.all) 얘를 넣어줘야 위에 여백 안생긴다.
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    
    var body: some View {
        VStack(spacing:0) {
            MakeCardViewNavbar().padding(.vertical,20)
            ZStack{
                CardView(card: $cardViewModel.newCard)
                    .frame(width: containerWidth, height: imageHeight)
                routeImage
                    .resizable()
                    .frame(width: containerWidth/2, height: containerWidth/2)
            }
            if isCustom {
                Button(action: {
                    // 여기서 먼저 action sheet 띄우기
                    showingOption = true
                }){
                    ZStack {
                        Rectangle()
                            .fill(Color.combingGray5)
                        Text("이미지 변경하기")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                    }.frame(width: containerWidth, height:45)
                }.confirmationDialog("카드 이미지 변경", isPresented: $showingOption, titleVisibility: .visible) {
                    Button("카메라 촬영"){
                        // 카메라 촬영 로직. 굳.
                        takePicture()
                    }
                    
                    Button("앨범에서 사진 선택"){
                        // 이미지 피커 로직. 굳.
                        selectImage()
                    }
                    
                    Button("취소", role: .cancel){
                    }
                    
                }
                
                Spacer()
                Text("직접 찍은 관광지 사진을 넣어서\n나만의 비치코밍 카드를 만들어보세요!")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16, weight: .medium))
                    .lineSpacing(3)
                    .foregroundColor(Color.combingGray4)
            }
            
            Spacer() 
            Button(action: {
                let saveImage = SaveImageView.snapshot()
                presentBadge = userViewModel.user!.representBadge
                isPresentShareView.toggle()
                userViewModel.uploadPicture(image: saveImage)
                userViewModel.updateUser(uid: userViewModel.user!.id, info: ["total_time": userViewModel.user!.totalTime + movingTime, "total_distance":userViewModel.user!.totalDistance+Int(movingDistance)])
            }){
                ZStack {
                    Rectangle()
                        .fill(Color.combingGradient1)
                        .frame(width: containerWidth, height: 56)
                        .cornerRadius(16)
                    Text("완료")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $isPresentedAllImage){
            AllImagePicker(cardViewModel: cardViewModel, card: $cardViewModel.newCard)
        }
        .sheet(isPresented: $isPresentedLimitedImage){
            LimitedImagePicker(cardViewModel: cardViewModel, card: $cardViewModel.newCard)
        }
        .sheet(isPresented: $isPresentedCamera) {
            Camera(cardViewModel: cardViewModel, card: $cardViewModel.newCard)
        }
        .alert("이 기능을 사용하려면 카메라 엑세스 권한이 필요합니다", isPresented: $cameraDenyAlert) {
            Button("나중에 하기") {
                
            }
            Button("설정 열기") {
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }
        }.sheet(isPresented: $isPresentShareView){
            ShareView(card: $cardViewModel.newCard, presentBadge: $presentBadge, routeImage: routeImage) {
                dismiss()
            }
        }.onAppear {
            if firebaseAuth.currentUser != nil {
                isSignin = true
                userViewModel.getUserData(uid: firebaseAuth.currentUser!.uid)
            } else {
                isSignin = false
            }
            print("체크!")
            cardViewModel.checkLocation()
            cardViewModel.newCard.distance = movingDistance
            cardViewModel.newCard.time = movingTime
        }
        
    }
    
    
    func selectImage() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { (status) in
            switch status {
            case .authorized:
                isPresentedAllImage.toggle()
                return
            case .limited:
                isPresentedLimitedImage.toggle()
                return
            default:
                isPresentedPermissionCheck.toggle()
                return
            }
            
        }
    }
    
    func takePicture() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            isPresentedCamera.toggle()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status {
                    isPresentedCamera.toggle()
                }
                else {
                    cameraDenyAlert = true
                }
            }
            return
        case .denied:
            cameraDenyAlert = true
            return
        case .restricted:
            return
        default:
            return
            
        }
    }
    
    
}

struct MakeCardView_Previews: PreviewProvider {
    static var previews: some View {
        MakeCardView(isCustom: false, movingDistance: 0.0, movingTime: 1, routeImage: Image("img_tour"))
    }
}

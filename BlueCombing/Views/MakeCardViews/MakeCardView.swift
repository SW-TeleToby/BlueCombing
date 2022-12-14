//
//  MakeCardView.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/16.
//

import SwiftUI
import Photos

struct MakeCardView: View {
    @EnvironmentObject var authSession: SessionStore
    
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
    @State var presentBadge:BadgeDescription = BadgeDescription.coral
    let isCustom: Bool
    let movingDistance : Double
    let movingTime : Int
    let routeImage: Image
    
    var makeCardViewNavbar: some View {
        HStack{
            Image(systemName: "chevron.backward")
                .font(.system(size: 20, weight: .semibold))
                .onTapGesture {
                    dismiss()
                }
            Spacer()
            Text("비치코밍 카드 만들기")
                .font(.system(size: 17, weight: .bold))
                .padding(.leading, -20)
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.bottom, 10)
    }
    
    var saveImageView: some View {
        ZStack{
            CardView(card: $cardViewModel.card, routeImage: routeImage)
                .frame(height: imageHeight)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var changeImageButton: some View {
        Button(action: {
            showingOption = true
        }){
            ZStack {
                Rectangle()
                    .fill(Color.combingGray5)
                Text("이미지 변경하기")
                    .font(.Button1)
                    .foregroundColor(.white)
            }.frame(height:45)
        }.confirmationDialog("카드 이미지 변경", isPresented: $showingOption, titleVisibility: .visible) {
            Button("카메라 촬영"){
                takePicture()
            }
            
            Button("앨범에서 사진 선택"){
                selectImage()
            }
            
            Button("취소", role: .cancel){}
            
        }
    }
    
    var completeButton: some View {
        Button(action: {
            let saveImage = saveImageView.snapshot()
            if let user = userViewModel.user {
                presentBadge = user.representBadge.translateBadge()
                isPresentShareView.toggle()
                userViewModel.uploadPicture(image: saveImage)
                userViewModel.updateUser(uid: user.id, info: ["total_time": user.totalTime + movingTime, "total_distance": user.totalDistance + Int(movingDistance)])
            }
        }){
            ZStack {
                Rectangle()
                    .fill(Color.combingGradient1)
                    .frame(height: 56)
                    .cornerRadius(16)
                Text("완료")
                    .font(.Button1)
                    .foregroundColor(.white)
            }
        }
    }
    
    var body: some View {
        VStack {
            VStack(spacing:0) {
                
                makeCardViewNavbar
                
                saveImageView
                
                if isCustom {
                    changeImageButton
                    
                    Spacer()
                    Text("직접 찍은 관광지 사진을 넣어서\n나만의 비치코밍 카드를 만들어보세요!")
                        .multilineTextAlignment(.center)
                        .font(.Body4)
                        .lineSpacing(3)
                        .foregroundColor(.combingGray4)
                }
                
                Spacer()
                completeButton
                
            }
            .frame(width: containerWidth)
            .navigationTitle("")
            .navigationBarHidden(true)
            .sheet(isPresented: $isPresentedAllImage){
                AllImagePicker(cardViewModel: cardViewModel, card: $cardViewModel.card)
            }
            .sheet(isPresented: $isPresentedLimitedImage){
                LimitedImagePicker(cardViewModel: cardViewModel, card: $cardViewModel.card)
            }
            .sheet(isPresented: $isPresentedCamera) {
                Camera(cardViewModel: cardViewModel, card: $cardViewModel.card)
            }
            .alert("이 기능을 사용하려면 카메라 엑세스 권한이 필요합니다", isPresented: $cameraDenyAlert) {
                Button("나중에 하기") {}
                Button("설정 열기") {
                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                    }
                }
            }.sheet(isPresented: $isPresentShareView){
                ShareView(card: $cardViewModel.card, presentBadge: $presentBadge, routeImage: routeImage) {
                    dismiss()
                }
            }.onAppear {
                if let uid = authSession.uid {
                    userViewModel.getUserData(uid: uid)
                }
                cardViewModel.checkLocation()
                cardViewModel.card.distance = movingDistance
                cardViewModel.card.time = movingTime
                cardViewModel.card.badgeImage = presentBadge.badgeImage
            }
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


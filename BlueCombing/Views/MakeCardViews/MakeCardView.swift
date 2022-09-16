//
//  MakeCardView.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/16.
//

import SwiftUI
import Photos

struct MakeCardView: View {
    @StateObject var cardViewModel = CardViewModel()
    @Binding var page: Int
    @State var showingOption = false
    @State var isPresentedCamera = false
    @State var isPresentedAllImage = false
    @State var isPresentedLimitedImage = false
    @State var isPresentedPermissionCheck = false
    @State var cameraDenyAlert = false
    
    var body: some View {
        VStack(spacing:0) {
            MakeCardViewNavbar(page: $page).padding(.vertical,20)
            CardView(card: $cardViewModel.newCard)
                .frame(width: containerWidth, height: imageHeight)
            Button(action: {
                // 여기서 먼저 action sheet 띄우기
                showingOption = true
                
            }){
                ZStack {
                    Rectangle()
                        .fill(Color(red: 0.219, green: 0.219, blue: 0.219))
                    Text("이미지 변경하기")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                }.frame(width: containerWidth,height:45)
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
                .foregroundColor(Color(red: 0.436, green: 0.436, blue: 0.44))
            Spacer()
            Button(action: {
                // 뱃지 찍는 뷰로 넘어가기.
                page = 1
            }){
                ZStack {
                    Rectangle()
                        .fill(Color(red: 0.046, green: 0.128, blue: 0.446))
                        .frame(width: containerWidth, height: 56)
                        .cornerRadius(16)
                    Text("다음")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $isPresentedAllImage){
            AllImagePicker(card: $cardViewModel.newCard)
        }
        .sheet(isPresented: $isPresentedLimitedImage){
            LimitedImagePicker(card: $cardViewModel.newCard)
        }
        .sheet(isPresented: $isPresentedCamera) {
            Camera(card: $cardViewModel.newCard)
        }
        .alert("이 기능을 사용하려면 카메라 엑세스 권한이 필요합니다", isPresented: $cameraDenyAlert) {
            Button("나중에 하기") {
                
            }
            Button("설정 열기") {
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
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

struct MakeCardView_Previews: PreviewProvider {
    static var previews: some View {
        MakeCardView(page: .constant(0))
    }
}
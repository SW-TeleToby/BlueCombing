//
//  ShareView.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/16.
//

import SwiftUI

struct ShareView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var card: CardData
    @Binding var presentBadge: BadgeDescription
    @State var shareImage:UIImage?
    @State var isPresentShareSheet = false
    @State var isPresentSaveAlert = false
    let routeImage: Image
    var dismissAction: () -> Void
    
    var shareViewNavbar: some View {
        HStack{
            Image(systemName: "xmark")
                .font(.system(size: 16, weight: .semibold))
                .onTapGesture {
                    dismiss()
                }
            Spacer()
            Text("비치코밍 인증하기")
                .font(.system(size: 17, weight: .bold))
            Spacer()
            Button(action: {
                let shareImage = shareImageView.snapshot()
                UIImageWriteToSavedPhotosAlbum(shareImage,nil,nil,nil)
                isPresentSaveAlert.toggle()
            }){
                Text("저장")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(Color(red: 0.006, green: 0.127, blue: 0.449))
            }
        }.padding(.top, 20)
    }
    
    var shareImageView: some View {
        VStack(spacing:0){
            ZStack {
                CardView(card: $card, routeImage: routeImage)
                    .frame(height: imageHeight)
            }
            ZStack{
                Rectangle()
                    .fill(.white)
                Text(presentBadge.badgeDescription)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 19, weight: .medium))
                    .lineSpacing(3)
                    .foregroundColor(.combingBlue5)
            }.frame(height: 126)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var shareButton: some View {
        Button(action: {
            isPresentShareSheet.toggle()
        }){
            ZStack {
                Rectangle()
                    .fill(Color.combingGradient1)
                    .frame(height: 56)
                    .cornerRadius(16)
                Text("카드 공유하기")
                    .font(.Button1)
                    .foregroundColor(.white)
            }
        }.padding(.bottom)
    }
    
    var moveHomeButton: some View {
        Button(action: {
            //TODO: 메인 화면으로 돌아가는 로직 작성해야합니다.
            dismiss()
            self.dismissAction()
        }){
            Text("홈으로 가기")
                .font(.Button1)
                .foregroundColor(.combingGray4)
        }
    }
    
    var body: some View {
        VStack{
            VStack {
                shareViewNavbar
                
                shareImageView
                    .cornerRadius(16)
                    .shadow(radius: 20)
                    .scaleEffect(0.9)
                
                shareButton
                
                moveHomeButton
            }
            .frame(width: containerWidth)
            
        }
        .onAppear {
            shareImage = shareImageView.snapshot()
        }.sheet(isPresented: $isPresentShareSheet){
            ShareSheet(activityItems: [shareImage!])
        }.alert("저장되었습니다.", isPresented: $isPresentSaveAlert) {
            Button("확인") {
                
            }
        }
    }
    
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
}

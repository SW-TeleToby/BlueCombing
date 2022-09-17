//
//  ShareView.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/16.
//

import SwiftUI

struct ShareView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var card: Card
    @State var shareImage:UIImage?
    @State var isPresentShareSheet = false
    
    var dismissAction: () -> Void
    
    var ShareImageView: some View {
        VStack(spacing:0){
            CardView(card: $card)
                .frame(width: containerWidth, height: imageHeight)
            ZStack{
                Rectangle()
                    .fill(.white)
                Text(card.badge.longExplanation)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 19, weight: .medium))
                    .foregroundColor(Color(red: 0.003, green: 0.124, blue: 0.437))
            }.frame(width: containerWidth, height: 126)
        // .edgesIgnoringSafeArea(.all) 얘를 넣어줘야 위에 여백 안생긴다.
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var body: some View {
        VStack{
            HStack(spacing: 90){
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .semibold))
                    .onTapGesture {
                        dismiss()
                    }
                Text("비치코밍 인증하기")
                    .font(.system(size: 17, weight: .bold))
                Button(action: {
                    print(ShareImageView)
                    let shareImage = ShareImageView.snapshot()
                    UIImageWriteToSavedPhotosAlbum(shareImage,nil,nil,nil)
                }){
                    Text("저장")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color(red: 0.006, green: 0.127, blue: 0.449))
                }
            }.padding(.top)
            
            VStack(spacing:0){
                ShareImageView
                    .cornerRadius(16)
                    .shadow(radius: 20)
            }
                .scaleEffect(0.9)
                .padding(.top, -10)
            
            
            Button(action: {
                // 공유 로직 작성
                isPresentShareSheet.toggle()
            }){
                ZStack {
                    Rectangle()
                        .fill(Color.combingGradient1)
                        .frame(width: containerWidth, height: 56)
                        .cornerRadius(16)
                    Text("카드 공유하기")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom)
            Button(action: {
                // 메인 지도 화면으로 돌아가는 로직 작성. 일단 디스미스만
                dismiss()
                self.dismissAction()
            }){
                Text("홈으로 가기")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(red: 0.435, green: 0.435, blue: 0.44))
            }
        }
        .onAppear {
            shareImage = ShareImageView.snapshot()
        }.sheet(isPresented: $isPresentShareSheet){
            ShareSheet(activityItems: [shareImage!])
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

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView(card: .constant(Card(id: 0, distance: 2.0, time: 2000, location: "경상북도 포항시", backgroundImage: UIImage(systemName: "xmark")!, badge:Badge(id: 0, badgeImage: UIImage(named: "testBadge1")!, longExplanation: "1번째 뱃지 설명입니다.\n1번째 뱃지 설명은 이러이러합니다.")))) {
            
        }
    }
}

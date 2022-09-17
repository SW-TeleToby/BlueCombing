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
    @Binding var presentBadge: String
    @State var shareImage:UIImage?
    @State var isPresentShareSheet = false
    @State var saveAlert = false
    @State var badgeDescription = ""
    var routeImage: Image
    var dismissAction: () -> Void
    
    var ShareImageView: some View {
        VStack(spacing:0){
            ZStack {
                CardView(card: $card)
                    .frame(width: containerWidth, height: imageHeight)
                routeImage
                    .resizable()
                    .frame(width: containerWidth/2, height: containerWidth/2)
            }
            
            ZStack{
                Rectangle()
                    .fill(.white)
                Text(badgeDescription)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 19, weight: .medium))
                    .lineSpacing(3)
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
                    saveAlert.toggle()
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
            badgeDescription = makeDescription(badge: presentBadge)
            shareImage = ShareImageView.snapshot()
        }.sheet(isPresented: $isPresentShareSheet){
            ShareSheet(activityItems: [shareImage!])
        }.alert("저장되었습니다.", isPresented: $saveAlert) {
            Button("확인") {
                
            }
        }
    }
    
    func makeDescription(badge:String) -> String {
        let description:String
        
        switch badge {
        case "산호초":
            description = "당신은 산호초처럼\n파릇파릇한 바다지킴이네요"
        case "조개":
            description = "오늘도 바다를 꾸준히 지킨\n당신은 바다의 조개같은 존재예요!"
        case "해마":
            description = "이젠 바다를 지키는게\n익숙한 당신은 바다의 해마에요"
        case "해파리":
            description = "바다 주변을 끊임없이 둘러보는\n당신은 바다의 해파리 같아요"
        case "돌고래":
            description = "멋진 돌고래 같은 당신!\n덕분에 오늘도 바다가 깨끗해요"
        case "거북이":
            description = "오늘도 장로 거북이처럼\n노련하게 바다를 지키고 계시는군요!"
        case "물고기 떼":
            description = "작은 노력을 모아 바다를 돌보는\n당신은 거대한 물고기 떼 같아요"
        case "고래":
            description = "항상 변함없이 바다를 지키는\n당신은 바다의 주인인 고래 같아요"
        default:
            description = "멋진 돌고래 같은 당신!\n덕분에 오늘도 바다가 깨끗해요"
        }
        return description
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

//struct ShareView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShareView(card: .constant(Card(id: 0, distance: 2.0, time: 2000, location: "경상북도 포항시", backgroundImage: UIImage(systemName: "xmark")!, badge:Badge(id: 0, badgeImage: UIImage(named: "testBadge1")!, longExplanation: "1번째 뱃지 설명입니다.\n1번째 뱃지 설명은 이러이러합니다.")))) {
//
//        }
//    }
//}

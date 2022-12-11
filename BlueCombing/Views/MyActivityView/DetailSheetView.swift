//
//  DetailSheetView.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/17.
//

import SwiftUI

struct DetailSheetView: View {
    
    @Binding var image: UIImage?
    @State var shareImage:UIImage?
    @Environment(\.dismiss) var dismiss
    @State var isPresentShareSheet = false
    @State var randomScript : String?
    @State var saveAlert = false
    var shareImageView: some View {
        VStack(spacing:0){
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: containerWidth, height: imageHeight)
                ZStack{
                    Rectangle()
                        .fill(.white)
                    //TODO: 이미지 자체를 저장하고 불러오는 것이기 때문에, 뱃지에 대한 정보를 현재 단계에서 불러올 수 없습니다.
                    //TODO: 문구를 랜덤으로 처리했지만, 추후 수정하겠습니다.
                    if randomScript != nil {
                        Text(randomScript!)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 19, weight: .medium))
                            .lineSpacing(3)
                            .foregroundColor(Color(red: 0.003, green: 0.124, blue: 0.437))
                    }
                }.frame(width: containerWidth, height: 126)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 90){
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .semibold))
                    .onTapGesture {
                        dismiss()
                    }
                Text("비치코밍 인증하기")
                    .font(.system(size: 17, weight: .bold))
                Button(action: {
                    let shareImage = shareImageView.snapshot()
                    UIImageWriteToSavedPhotosAlbum(shareImage,nil,nil,nil)
                    saveAlert.toggle()
                }){
                    Text("저장")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color(red: 0.006, green: 0.127, blue: 0.449))
                }
            }.padding(.top)
            
            VStack(spacing:0){
                shareImageView
                    .cornerRadius(16)
                    .shadow(radius: 20)
            }
            .scaleEffect(0.9)
            .padding(.top, -10)
            
            
            Button(action: {
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
                dismiss()
            }){
                Text("홈으로 가기")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(red: 0.435, green: 0.435, blue: 0.44))
            }
        }
        .onAppear {
            shareImage = shareImageView.snapshot()
            randomScript = randomDescription.randomElement()
        }.sheet(isPresented: $isPresentShareSheet){
            ShareSheet(activityItems: [shareImage!])
        }.alert("저장되었습니다.", isPresented: $saveAlert) {
            Button("확인") {
                
            }
        }
        
        
    }
}

var randomDescription: [String] = [
    "당신은 산호초처럼\n파릇파릇한 바다지킴이네요",
    "오늘도 바다를 꾸준히 지킨\n당신은 바다의 조개같은 존재예요!",
    "이젠 바다를 지키는게\n익숙한 당신은 바다의 해마에요",
    "바다 주변을 끊임없이 둘러보는\n당신은 바다의 해파리 같아요",
    "멋진 돌고래 같은 당신!\n덕분에 오늘도 바다가 깨끗해요",
    "오늘도 장로 거북이처럼\n노련하게 바다를 지키고 계시는군요!",
    "작은 노력을 모아 바다를 돌보는\n당신은 거대한 물고기 떼 같아요",
    "항상 변함없이 바다를 지키는\n당신은 바다의 주인인 고래 같아요"
]


struct DetailSheetView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSheetView(image: .constant(UIImage(systemName:  "xmark")!))
    }
}

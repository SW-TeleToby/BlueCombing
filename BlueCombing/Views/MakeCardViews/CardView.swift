//
//  CardView.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/16.
//

import SwiftUI


var containerWidth:CGFloat = UIScreen.main.bounds.width - 32.0
var imageHeight: CGFloat = UIScreen.main.bounds.height - 366.67

struct CardView: View {
    @Binding var card: Card
    let routeImage: Image
    
    var imageView: some View {
        
        ZStack {
            Image(uiImage:card.backgroundImage)
                .resizable()
                .scaledToFill()
                .frame(width: containerWidth, height: imageHeight)
                .clipped()
            // 그레디언트
            VStack{
                Spacer()
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.black.opacity(0), .black.opacity(0.6)]), startPoint: .top, endPoint: .bottom))
                    .frame(height: imageHeight/3)
            }
        }
    }
    
    var badgeView: some View {
        VStack {
            HStack{
                Spacer()
                Image(uiImage: card.badge.badgeImage)
                    .resizable()
                    .frame(width: 76, height: 76)
            }
            .padding(.trailing,12)
            .padding(.top, 12)
            Spacer()
        }
    }
    
    var infoView: some View {
        VStack {
            Spacer()
            HStack{
                Text(card.distance.distanceToString())
                    .font(.Heading2)
                    .foregroundColor(.white)
                Text(card.time.timeToString())
                    .font(.Heading2)
                    .foregroundColor(.white)
                Spacer()
            }.padding(.bottom, 0.1)
            HStack {
                Text(card.location)
                    .font(.Body4)
                    .foregroundColor(.white)
                Spacer()
            }
        }.padding(.leading, 30)
            .padding(.bottom, 30)
    }
    
    
    var body: some View {
        ZStack{
            // 이미지
            imageView
            // 뱃지 공간
            badgeView
            // 텍스트 공간
            infoView
            
            routeImage
                .resizable()
                .scaledToFit()
                .frame(width: containerWidth/2, height: containerWidth/2)
            
        }
    }
}

extension Double {
    func distanceToString() -> String {
        let distance = String(format: "%.1f", self/1000)
        return distance + "km,"
    }
}

extension Int {
    func timeToString() -> String {
        let minute = (self % 3600) / 60
        let hour = self / 3600
        if self < 60 {
            return "1분 이내"
        }
        if hour == 0 {
            return String(format: "%d분", minute)
        } else {
            return String(format: "%d시간 %d분", hour, minute)
        }
    }
}



struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .constant(Card(id: 0, distance: 2.0, time: 2000, location: "경상북도 포항시", backgroundImage: UIImage(systemName: "xmark")!, badge:Badge(id: 0, badgeImage: UIImage(named: "testBadge1")!, longExplanation: "1번째 뱃지 설명입니다.\n1번째 뱃지 설명은 이러이러합니다."))),routeImage: Image(""))
    }
}

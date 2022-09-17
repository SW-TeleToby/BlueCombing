//
//  AtractionView.swift
//  BlueCombing
//
//  Created by Jun.Mac on 2022/09/16.
//

import SwiftUI

struct AtractionView : View {
    
    @State var index = 1
    @State var offset : CGFloat = 0
    var width = UIScreen.main.bounds.width
    
    var body: some View{
        
        VStack(alignment: .leading){
            
            CustomSegment(index: self.$index, offset: self.$offset)
            
            GeometryReader{g in
                
                HStack(spacing: 0){
                    
                    First()
                        .frame(width: g.frame(in : .global).width)
                    
                    Second()
                        .frame(width: g.frame(in : .global).width)
                    
                    Third()
                        .frame(width: g.frame(in : .global).width)
                }
                .offset(x: self.offset)
            }
        }
        .padding(.top, 56.0)
        .padding(.leading, 21.0)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}


struct CustomSegment : View {
    
    @Binding var index : Int
    @Binding var offset : CGFloat
    var width = UIScreen.main.bounds.width
    
    var body: some View{
        
        
        HStack{
            
            Button(action: {
                
                self.index = 1
                self.offset = 0
                
            }) {
                VStack(spacing: 8) {
                    Text("이벤트")
                        .font(.custom("Pretendard-Bold", size: 20))
                        .foregroundColor(self.index == 1 ? .black : Color.combingGray3)
                    
                    Capsule()
                        .fill(self.index == 1 ? Color.combingBlue4 : Color.clear)
                        .frame(width: 52, height: 4)
                }
                .padding(.trailing, 18.0)
            }
            
            Button(action: {
                
                self.index = 2
                self.offset = -self.width + 21
                
            }) {
                VStack(spacing: 8) {
                    Text("관광")
                        .font(.custom("Pretendard-Bold", size: 20))
                        .foregroundColor(self.index == 2 ? .black : Color.combingGray3)
                    
                    Capsule()
                        .fill(self.index == 2 ? Color.combingBlue4 : Color.clear)
                        .frame(width: 52, height: 4)
                }
                .padding(.trailing, 18.0)
            }
            
            Button(action: {
                
                self.index = 3
                self.offset = -(self.width * 2) + 42
            }) {
                VStack(spacing: 8) {
                    Text("레저")
                        .font(.custom("Pretendard-Bold", size: 20))
                        .foregroundColor(self.index == 3 ? .black : Color.combingGray3)
                    
                    Capsule()
                        .fill(self.index == 3 ? Color.combingBlue4 : Color.clear)
                        .frame(width: 52, height: 4)
                }
            }
        }
        
    }
}

struct First : View {
    
    var body: some View{
        GeometryReader{_ in
            
            VStack{
                
                Text("First")
            }
        }
        .background(Color.white)
    }
    
}

struct Second : View {
    
    var body: some View{
        GeometryReader{_ in
            
            VStack{
                
                Text("Second")
            }
        }
        .background(Color.white)
    }
    
}

struct Third : View {
    
    var body: some View{
        GeometryReader{_ in
            
            VStack{
                
                Text("Third")
            }
        }
        .background(Color.white)
    }
    
}

struct AtractionView_Previews: PreviewProvider {
    static var previews: some View {
        AtractionView()
    }
}

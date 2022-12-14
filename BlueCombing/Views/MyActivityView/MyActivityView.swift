//
//  MyActivityView.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/17.
//

import SwiftUI

var deviceHeight = UIScreen.main.bounds.size.height
var deviceWidth = UIScreen.main.bounds.size.width

struct MyActivityView: View {
    @EnvironmentObject var authSession : SessionStore
    
    @StateObject var userViewModel = UserViewModel()
    @State var isPresentedDetail = false
    @State var selectedImage: UIImage?
    var image: UIImage?
    var description: String?
    
    let column = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var backgroundView: some View {
        VStack {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.779, green: 0.998, blue: 0.999), Color(red: 0.187, green: 0.704, blue: 0.868)]), startPoint: .top, endPoint: .bottom))
                .frame(width: deviceWidth, height: deviceHeight/2)
            Rectangle()
                .fill(.white)
        }.frame(width: deviceWidth)
    }
    
    var lottieView: some View {
        VStack(alignment:.center) {
            LottieView(jsonName: "wave")
        }.frame(width: deviceWidth, height: deviceHeight)
    }
    
    var moveToMyGradeButton: some View {
        HStack {
            Spacer()
            NavigationLink(destination: BadgeGradeView(user: userViewModel.user)){
                
                HStack {
                    Text("내 등급 보기")
                        .font(.Button1)
                        .foregroundColor(.white)
                    Image(systemName: "chevron.right")
                        .font(.Button1)
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.top,15)
        .padding(.bottom,60)
        .padding(.trailing,20)
    }
    
    var myCardListView: some View {
        LazyVGrid(columns:column, spacing: 20) {
            ForEach(userViewModel.combingImages, id:\.self) { image in
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 172, height: 230)
                    .cornerRadius(12)
                    .onTapGesture {
                        selectedImage = image
                        isPresentedDetail.toggle()
                    }
            }
        }.padding()
    }
    var body: some View {
        VStack {
            if !authSession.isSignIn {
                LoginHome(loginMode: .myActivity) {}
            } else {
                ScrollView {
                    ZStack(alignment:.top) {
                        
                        backgroundView
                        
                        lottieView
                        
                        VStack {
                            if let user = userViewModel.user {
                                HStack (spacing:0){
                                    Text("바다의 ")
                                        .font(.Heading2)
                                    Text(user.representBadge)
                                        .font(.Heading2)
                                }.padding(.top,15.0)
                                HStack (alignment: .bottom){
                                    Text("총 활동시간")
                                        .font(.Body5)
                                    Text(user.totalTime.timeToString())
                                        .font(.Body3)
                                }.padding(.top,3)
                                presentBadgeView(presentBadge: user.representBadge)
                                VStack {
                                    moveToMyGradeButton
                                    
                                    myCardListView
                                }
                            }
                        }
                    }
                }
                .background(Color(red: 0.779, green: 0.998, blue: 0.999))
            }
        }.sheet(isPresented: $isPresentedDetail){
            DetailSheetView(image: $selectedImage)
        }
        .onAppear{
            if let uid = authSession.uid {
                userViewModel.getUserImages(uid: uid)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct presentBadgeView : View{
    @StateObject var badgeVM = BadgeViewModel()
    var presentBadge: String
    
    var body: some View {
        VStack{
            Image(uiImage: badgeVM.badgeImage)
                .resizable()
                .frame(width: 142, height: 142)
            Text(badgeVM.description)
                .font(.Body4)
                .multilineTextAlignment(.center)
                .lineSpacing(3)
                .foregroundColor(.combingBlue5_2)
                .padding(.top,3)
        }.onAppear {
            badgeVM.changeDescription(presentBadge: presentBadge)
        }
    }
}

//
//  MyActivityView.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/17.
//

import SwiftUI
import FirebaseAuth

var deviceHeight = UIScreen.main.bounds.size.height
var deviceWidth = UIScreen.main.bounds.size.width
struct MyActivityView: View {
    @EnvironmentObject var authSession : SessionStore
    
    @StateObject var userViewModel = UserViewModel()
    @State var isPresentedDetail = false
    let firebaseAuth = Auth.auth()
    var image: UIImage?
    var description: String?
    @State var selectedImage: UIImage?
    
    let column = [
        /// define number of caullum here
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            if !authSession.isSignIn {
                LoginHome(loginMode: .myActivity) {}
            } else {
                ScrollView {
                    ZStack(alignment:.top) {
                        
                        VStack {
                            Rectangle()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color(red: 0.779, green: 0.998, blue: 0.999), Color(red: 0.187, green: 0.704, blue: 0.868)]), startPoint: .top, endPoint: .bottom))
                                .frame(width: deviceWidth, height: deviceHeight/2)
                            Rectangle()
                                .fill(.white)
                        }.frame(width: deviceWidth)
                        
                        VStack(alignment:.center) {
                            LottieView(jsonName: "wave")
                        }.frame(width: deviceWidth, height: deviceHeight)
                        
                        VStack {
                            if let user = userViewModel.user {
                                HStack (spacing:0){
                                    Text("바다의 ")
                                        .font(.Heading2)
                                        .foregroundColor(.combingBlue5)
                                    Text(user.representBadge)
                                        .font(.Heading2)
                                        .foregroundColor(.combingBlue5)
                                }.padding(.top,15.0)
                                HStack (alignment: .bottom){
                                    Text("총 활동시간")
                                        .font(.Body5)
                                        .foregroundColor(.combingGray4)
                                    Text(user.totalTime.timeToString())
                                        .font(.Body3)
                                        .foregroundColor(.combingBlue5)
                                }.padding(.top,0.1)
                                
                                representBadgeView(representBadge: user.representBadge)
                                
                                VStack {
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
                                    }.padding(.top,15)
                                        .padding(.bottom,60)
                                        .padding(.trailing,20)
                                    //                                    .background(.yellow)
                                    //                                Spacer()
                                    //                                    .background(.green)
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
                                        .padding(.bottom)
                                    //                                    .background(.red)
                                    //                                Spacer()
                                }
                            }
                        }
                    }
                }
                .background(Color(red: 0.779, green: 0.998, blue: 0.999))
                //                .edgesIgnoringSafeArea(.bottom)
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


struct representBadgeView : View {
    var representBadge: String
    @State var description: String = "산호초"
    @State var BadgeTitle: String = "img_badge_coral"
    
    var body: some View {
        VStack{
            Image(BadgeTitle)
                .resizable()
                .frame(width: 142, height: 142)
            Text(description)
                .font(.Body4)
                .multilineTextAlignment(.center)
                .lineSpacing(3)
                .foregroundColor(.combingBlue5)
                .padding(.top,3)
        }.onAppear {
            switch representBadge {
            case "산호초":
                description = "당신은 산호초처럼\n파릇파릇한 바다지킴이네요"
                BadgeTitle = "img_badge_coral"
            case "조개":
                description = "오늘도 바다를 꾸준히 지킨\n당신은 바다의 조개같은 존재예요!"
                BadgeTitle = "img_badge_clam"
            case "해마":
                description = "이젠 바다를 지키는게\n익숙한 당신은 바다의 해마에요"
                BadgeTitle = "img_badge_hippocampus"
            case "해파리":
                description = "바다 주변을 끊임없이 둘러보는\n당신은 바다의 해파리 같아요"
                BadgeTitle = "img_badge_jellyfish"
            case "돌고래":
                description = "멋진 돌고래 같은 당신!\n덕분에 오늘도 바다가 깨끗해요"
                BadgeTitle = "img_badge_dolphin"
            case "거북이":
                description = "오늘도 장로 거북이처럼\n노련하게 바다를 지키고 계시는군요!"
                BadgeTitle = "img_badge_turtle"
            case "물고기 떼":
                description = "작은 노력을 모아 바다를 돌보는\n당신은 거대한 물고기 떼 같아요"
                BadgeTitle = "img_badge_fishs"
            case "고래":
                description = "항상 변함없이 바다를 지키는\n당신은 바다의 주인인 고래 같아요"
                BadgeTitle = "img_badge_whale"
            default:
                description = ""
                BadgeTitle = "img_badge_clam"
            }
        }
        
    }
    
}


struct MyActivityView_Previews: PreviewProvider {
    static var previews: some View {
        MyActivityView()
            .environmentObject(SessionStore())
    }
}

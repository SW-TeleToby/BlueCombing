//
//  MultiModal.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/09/16.
//

import MapKit
import UIKit
import FirebaseAuth
import SwiftUI

struct MultiModal: View {
    @State var modalHeight = CGFloat(168)
    @State var loginCancleAlertTrigger = false
    @Binding var isRecordEnd: Bool
    @Binding var isRecordStart: Bool
    @Binding var currentModal: Int
    @Binding var pathCoordinates: [CLLocationCoordinate2D]
    @State var routeImage = Image("Is not Load")
    @Binding var movingTime: Int
    @Binding var movingDistance: Double
    @State private var showingAlert = false
    let firebaseAuth = Auth.auth()
    @State var isSignIn: Bool = false
    @State var isCustom: Bool = true
    
    @State var customModal: CustomModal = .startModal
    
    var body: some View {
        VStack {
            Spacer()
                
            
            switch customModal {
            case .startModal: StartModal(currentModal: $customModal,
                                         isRecordStart: $isRecordStart)
            case .recordConfirmModal: RecordConfirmModal(currentModal: $customModal,
                                                         isRecordEnd: $isRecordEnd,
                                                         isRecordStart: $isRecordEnd,
                                                         routeImage: $routeImage,
                                                         movingTime: $movingTime,
                                                         movingDistance: $movingDistance,
                                                         pathCoordinates: $pathCoordinates,
                                                         isSignIn: $isSignIn)
            case .cardMakingModal: CardMakingModal(currentModal: $customModal,
                                                   isRecordEnd: $isRecordEnd,
                                                   routeImage: $routeImage,
                                                   movingDistance: $movingDistance,
                                                   movingTime: $movingTime)
            case .loginModal: LoginModal(currentModal: $customModal,
                                         isSignIn: $isSignIn,
                                         showingAlert: $showingAlert,
                                         loginCancleAlertTrigger: $loginCancleAlertTrigger)
            case .none: Spacer()
            }
            
        }
        .alert("로그인하지 않으면 비치코밍\n기록을 남길 수 없습니다.", isPresented: $loginCancleAlertTrigger) {
            Button("취소", role: .cancel) { }
            Button("확인", role: .destructive) {
                isRecordEnd = false
                isRecordStart = false
                customModal = .startModal
            }
        }
            .onAppear {
                if firebaseAuth.currentUser != nil {
                    isSignIn = true
                } else {
                    isSignIn = false
                }
            }
    }
}
            

    /*
extension MultiModal {
    /*
    @ViewBuilder
    var startModal: some View {
        VStack {
            Spacer()
            
            ZStack {
                Rectangle()
                    .foregroundColor(.combingBlue5_2)
                    .cornerRadius(24, corners: [.topLeft, .topRight])
                
                VStack(alignment: .leading) {
                    
                    Text("비치코밍을 하기 전에 주변에서")
                        .foregroundColor(.combingGray1)
                        .font(.Body2)
                        .padding(.top, 24)
                        .padding(.leading, 16)
                    
                    Text("집게와 쓰레기 봉투를 받아가세요!")
                        .foregroundColor(.combingGray1)
                        .font(.Body2)
                        .padding(.leading, 16)
                    
                    Button(action: {
                        withAnimation(.spring()) {
                            modalHeight = 0
                            currentModal = -1
                            isRecordStart = true
                        }
                    }) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .background {
                                    Color.combingGradient1
                                }
                                .cornerRadius(16)
                            Text("비치코밍 시작하기")
                                .font(.Button1)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(height: 56)
                    .padding(16)
                } // VStack
            } // Zstack
        } // VStack
    } // startModal
     */
    
    /*
    @ViewBuilder
    var recordConfirmModal: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(24, corners: [.topLeft, .topRight])
            
            VStack {
                HStack {
                    Button(action: {
                        // TODO: 계속하기 Action
                        withAnimation(.spring()) {
                            currentModal = -1
                            isRecordEnd = false
                        }
                    }) {
                        Text("계속하기")
                            .font(.Body4)
                            .foregroundColor(Color(hex: 002172))
                    }
                    
                    Spacer().frame(width: 80)
                    
                    Text("비치코밍 기록")
                        .font(.Button1)
                    
                    Spacer()
                } // 모달 상단
                .padding(.horizontal, 16)
                
                Spacer().frame(height: 26)
                //                    Rectangle()
                //                        .cornerRadius(16)
                //                        .foregroundColor(.combingBlue2)
                //                        .padding(.horizontal, 16)
                
                // MARK: Canvas View
                HStack {
                    ZStack {
                        Rectangle()
                            .cornerRadius(16)
                            .foregroundColor(.combingBlue3)
                        
                        routeImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    }
                    .frame(width: 149, height: 175)
                    
                    Spacer().frame(width: 23)
                    
                    VStack(alignment: .leading) {
                        Text("이동 거리")
                            .font(.Body5)
                            .foregroundColor(.combingGray4)
                            .padding(.bottom, 4)
                        Text(String(format: "%.2f", movingDistance / 1000) + "km")
                            .font(.Heading2)
                            .foregroundColor(.combingBlue5)
                        
                        Spacer().frame(height: 22)
                        
                        Text("이동 시간")
                            .font(.Body5)
                            .foregroundColor(.combingGray4)
                            .padding(.bottom, 4)
                        if movingTime >= 60 {
                            Text("\(movingTime / 3600)시간 \(movingTime / 60)분")
                                .font(.Heading2)
                                .foregroundColor(.combingBlue5)
                        } else {
                            Text("1분 이내")
                                .font(.Heading2)
                                .foregroundColor(.combingBlue5)
                        }
                    }
                    Spacer()
                } // HStack
                .padding(.leading, 43)
                .onAppear {
                    CanvasView(pathCoordinates: $pathCoordinates).saveAsImage(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) { image in
                        routeImage = Image(uiImage: image)
                    }
                }
                
                Spacer().frame(height: 34)
                
                Button(action: {
                    withAnimation(.spring()) {
                        isRecordStart = false
                        isRecordEnd = false
                        if isSignIn {
                            currentModal = 2
                        } else {
                            currentModal = 3
                        }
                    }
                }) {
                    ZStack {
                        Rectangle()
                            .cornerRadius(16)
                            .foregroundColor(.combingBlue4)
                        
                        Text("비치코밍 끝내기")
                            .foregroundColor(.combingGray1)
                            .font(.Button1)
                    }
                    .frame(height: 56)
                    .padding([.top, .horizontal], 16)
                }
            }
        }
    }
     */
    
    /*
    @ViewBuilder
    var cardMakingModal: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.combingBlue5_2)
                .cornerRadius(24, corners: [.topLeft, .topRight])
            
            VStack(alignment: .leading) {
                HStack {
                    Text("쓰래기봉투를 버리고")
                        .font(.Body2)
                        .foregroundColor(.white)
                    Spacer()
                }
                HStack {
                    Text("비치코밍 인증 카드를 직접 만들어보세요.")
                        .font(.Body2)
                        .foregroundColor(.white)
                }
                
                Spacer().frame(height: 16)
                
                NavigationLink {
                    MakeCardView(isCustom: true, movingDistance: movingDistance, movingTime: movingTime, routeImage: routeImage)
                        .onAppear {
                            currentModal = 0
                        }
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.combingBlue4)
                            .cornerRadius(16)
                        Text("직접 만들러가기")
                            .font(.Button1)
                            .foregroundColor(.white)
                    }
                }
                .frame(height: 56)
                
                Spacer().frame(height: 16)
                
                NavigationLink {
                    MakeCardView(isCustom: false, movingDistance: movingDistance, movingTime: movingTime, routeImage: routeImage)
                        .onAppear {
                            currentModal = 0
                        }
                } label: {
                    HStack {
                        Spacer()
                        Text("기본 카드 사용하기")
                            .font(.Body3)
                            .foregroundColor(.combingGray2)
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
     */

    /*
    @ViewBuilder
    var loginModal: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.combingBlue5_2)
                .cornerRadius(24, corners: [.topLeft, .topRight])
            
            VStack {
                HStack {
                    Text("쓰레기 봉투를 버리고 로그인을 하여")
                        .foregroundColor(.white)
                        .font(.Body2)
                    Spacer()
                }
                HStack {
                    Text("비치코밍 인증 카드를 만들어보세요.")
                        .foregroundColor(.white)
                        .font(.Body2)
                    Spacer()
                }
                
                Spacer().frame(height: 18)
                
                NavigationLink(destination: LoginHome(isSignIn: $isSignIn, loginMode: .beachCombing) {
                    if isSignIn {
                        currentModal = 2
                    } else {
                        currentModal = 3
                        showingAlert = true
                    }
                }) {
                    ZStack {
                        Rectangle()
                            .cornerRadius(16)
                            .foregroundColor(.combingBlue4)
                        Text("로그인하러 가기")
                            .foregroundColor(.white)
                            .font(.Button1)
                    }
                }
                .frame(height: 56)
                .alert(isPresented: $showingAlert) {
                    let firstButton = Alert.Button.default(Text("확인")) {
                        currentModal = 0
                    }
                    let secondButton = Alert.Button.cancel(Text("취소"))
                    return Alert(title: Text("로그인하지 않으면 비치코밍 기록을 남길 수 없습니다"), primaryButton: firstButton, secondaryButton: secondButton)
                }
                
                Spacer().frame(height: 16)
                
                Button(action: { loginCancleAlertTrigger.toggle() }) {
                    Text("카드를 안 만들래요")
                        .font(.Body3)
                        .foregroundColor(.combingGray2)
                }
            }
            .padding(.leading, 16)
        }
    } // loginModal
     */
}
     */

enum CustomModal: String {
    case startModal
    case recordConfirmModal
    case cardMakingModal
    case loginModal
    case none
    
    var modalHeight: CGFloat {
        switch self {
        case .startModal: return 168
        case .recordConfirmModal: return 366
        case .cardMakingModal, .loginModal: return 212
        case .none: return 0
        }
    }
}


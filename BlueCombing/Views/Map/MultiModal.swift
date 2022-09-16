//
//  MultiModal.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/09/16.
//

import SwiftUI
import FirebaseAuth

struct MultiModal: View {
    @State var modalHeight = CGFloat(168)
    @Binding var recordEndTrigger: Bool
    @Binding var recordStartTrigger: Bool
    @Binding var currentModal: Int
    let firebaseAuth = Auth.auth()

    var body: some View {
        VStack {
            Spacer()

            switch currentModal {
            case 0:
                startModal
                    .frame(height: modalHeight)
            case 1:
                recordConfirmModal
                    .frame(height: modalHeight)
            case 2:
                cardMakingModal
                    .frame(height: modalHeight)
            case 3:
                loginModal
                    .frame(height: modalHeight)
            default:
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: modalHeight)
            }
        } // VStack
        .onChange(of: currentModal, perform: { value in
            switch value {
            case 0:
                withAnimation(.spring()) {
                    modalHeight = 168
                }
            case 1:
                withAnimation(.spring()) {
                    modalHeight = 366
                }
            case 2, 3:
                withAnimation(.spring()) {
                    modalHeight = 212
                }
            default:
                withAnimation(.spring()) {
                    modalHeight = 0
                }
            }
        })
    }
}

extension MultiModal {
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
                            recordStartTrigger = true
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
                            recordEndTrigger = false
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

                Spacer().frame(height: 18)

                Rectangle()
                    .cornerRadius(16)
                    .foregroundColor(.combingBlue2)
                    .frame(height: 201)
                    .padding(.horizontal, 16)

                Button(action: {
                    withAnimation(.spring()) {
                        recordStartTrigger = false
                        recordEndTrigger = false
                        if firebaseAuth.currentUser != nil {
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

                Button(action: {
                    // MARK: 액션 추가하기
                }) {
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

                Button(action: {
                    // MARK: 액션 추가하기
                }) {
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

                NavigationLink(destination: LoginHome(isSignIn: .constant(false)) ) {
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
                
                Spacer().frame(height: 16)
                
                Button(action: {}){
                    Text("카드를 안 만들래요")
                        .font(.Body3)
                        .foregroundColor(.combingGray2)
                }
            }
            .padding(.leading, 16)
        }
    } // loginModal
}

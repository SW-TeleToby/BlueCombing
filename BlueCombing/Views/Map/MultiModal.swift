//
//  MultiModal.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/09/16.
//

import SwiftUI

struct MultiModal: View {
    @State var modalHeight = CGFloat(168)
    @Binding var recordEndTrigger: Bool
    @Binding var recordStartTrigger: Bool
    @Binding var currentModal: Int

    var body: some View {
        VStack {
            Spacer()

            switch currentModal {
            case 0:
                startModal
                    .frame(height: modalHeight)
            case 1:
                RecordModal
                    .frame(height: modalHeight)
            default:
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: modalHeight)
            }
        } // VStack
//        .onChange(of: recordEndTrigger, perform: { value in
//            if value {
//                withAnimation(.spring()) {
//                    modalHeight = 366
//                    currentModal = 1
//                }
//            } else {
//                withAnimation(.spring()) {
//                    modalHeight = 0
//                    currentModal = -1
//                }
//            }
//        })
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
                        .padding(16)
                } // VStack
            } // Zstack
            .frame(height: 168)
        } // VStack
    } // startModal

    var RecordModal: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white) // MARK: 컬러 수정해야함
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
                        currentModal = 0
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
}

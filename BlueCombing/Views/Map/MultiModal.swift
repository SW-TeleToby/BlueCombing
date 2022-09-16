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
        .onChange(of: recordEndTrigger, perform: { value in
            if value {
                withAnimation(.spring()) {
                    modalHeight = 366
                    currentModal = 1
                }
            } else {
                withAnimation(.spring()) {
                    modalHeight = 0
                    currentModal = -1
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
                    .foregroundColor(.white) // MARK: 컬러 수정해야함
                    .cornerRadius(24, corners: [.topLeft, .topRight])

                VStack(alignment: .leading) {

                    Text("비치코밍을 하기 전에 주변에서\n집게와 쓰레기 봉투를 받아가세요!") // MARK: 폰트 설정
                    .padding(.top, 24)
                        .padding(.leading, 16)

                    Button(action: {
                        withAnimation(.spring()) {
                            modalHeight = 0
                            currentModal = -1
                            recordStartTrigger = true
                        }
                    }) {
                        ZStack {
                            Rectangle() // MARK: 색상 설정
                            .cornerRadius(16)

                            Text("비치코밍 시작하기")
                                .foregroundColor(.white)// MARK: 폰트 설정
                        }
                    }
                        .padding(16)
                } // VStack
            } // Zstack
            .frame(height: 168)
        } // VStack
    } // startModal

    var RecordModal: some View {
        Button(action: {
            recordStartTrigger = false
            recordEndTrigger = false
        }) {
            Rectangle()
                .foregroundColor(.white) // MARK: 컬러 수정해야함
                .cornerRadius(24, corners: [.topLeft, .topRight])
        }
    }

}

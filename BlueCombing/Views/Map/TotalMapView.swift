//
//  TotalMapView.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/09/16.
//

import SwiftUI
import UIKit

struct TotalMapView: View {
    @State var mapManager = MapDelegate()
    @State var startModalTrigger = true
    @State var endModalTrigger = false
    @State var test = CGFloat.zero

    init() { // TODO: 여기서 지랄해서 가능하지 않을까?
    }

    var body: some View {
        ZStack {
            MapView(map: $mapManager.map)
                .ignoresSafeArea(.container, edges: .top)

            Rectangle()
                .frame(width: 40, height: 40)
                .cornerRadius(30)

            if !startModalTrigger {
                didStartView
            }

            CustomModalView(isShown: $startModalTrigger, height: 168, isreverse: true) {
                didNotStartView
            }


        }
            .navigationBarHidden(true)
    }
}


extension TotalMapView {
    @ViewBuilder
    var didNotStartView: some View {
        VStack {
            Spacer()

            ZStack {
                Rectangle()
                    .foregroundColor(.blue) // MARK: 컬러 수정해야함
                .cornerRadius(24, corners: [.topLeft, .topRight])

                VStack(alignment: .leading) {

                    Text("비치코밍을 하기 전에 주변에서\n집게와 쓰레기 봉투를 받아가세요!") // MARK: 폰트 설정
                    .padding(.top, 24)
                        .padding(.leading, 16)

                    Button(action: { startModalTrigger.toggle() }) {
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
    } // didNotStartView

    var didStartView: some View {
        HStack {
            VStack {
                Button(action: { startModalTrigger.toggle() }) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.blue) // MARK: 색상 설정
                        .cornerRadius(16)

                        Text("비치코밍 끝내기") // MARK: 폰트 설정
                        .foregroundColor(.white)
                    }
                }
                    .frame(width: 175, height: 48)

                ZStack {
                    Rectangle()
                        .foregroundColor(.gray) // MARK: 색상 설정
                    .cornerRadius(16)

                    VStack(alignment: .leading) {
                        Text("이동 거리") // MARK: 폰트 설정
                        Text("2km") // MARK: 폰트 설정

                        Text("이동 시간") // MARK: 폰트 설정
                        Text("1시간 20분") // MARK: 폰트 설정
                    }
                }
                    .frame(width: 175, height: 142)

                Spacer()
            } // VStack
            .padding(.top, 17)
                .padding(.leading, 15)
            Spacer()
        } // HStack
    }

    var RecordView: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)

            VStack {
                HStack {
                    Button(action: { }) {
                        Text("계속하기")
                    }

                    Text("비치코밍 기록")
                } // HStack
                .padding(.top, 22)

                ZStack {
                    Rectangle()
                        .foregroundColor(.purple) // MARK: 색상 설정
                    .cornerRadius(16)

                    HStack {
                        Rectangle()
                            .foregroundColor(.cyan) // TODO: 경로 그림 대체할 것
                        .padding([.top, .bottom], 40)
                            .padding(.leading, 51)
                            .padding(.trailing, 19)

                        VStack {
                            Text("이동 거리") // MARK: 폰트 설정
                            Text("2km") // MARK: 폰트 설정

                            Text("이동 시간") // MARK: 폰트 설정
                            Text("1시간 20분") // MARK: 폰트 설정
                        }
                    }
                }
                    .frame(width: 201, height: 358)
                    .padding([.leading, .trailing, .bottom], 16)
                    .padding(.top, 18)

                Button(action: { endModalTrigger.toggle() }) { // MARK: 액션 설정
                    ZStack {
                        Rectangle()
                            .foregroundColor(.blue) // MARK: 색상 설정
                        Text("비치코이 끝내기") // MARK: 폰트 설정
                        .foregroundColor(.white)
                    }
                }
                    .padding(16)

            } // VStack
        }
    }
}

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
    @State var isStarted = false
    @State var isRecordEnd = false
    @State var isRecordStart = false
    @State var currentModal = 0

    var body: some View {
        ZStack {
            MapView(map: $mapManager.map)
                .ignoresSafeArea(.container, edges: .top)

            Image("userPin")

            if isRecordStart {
                recordingView
            }

            MultiModal(recordEndTrigger: $isRecordEnd, recordStartTrigger: $isRecordStart, currentModal: $currentModal)
        }
            .navigationBarHidden(true)
    }
}


extension TotalMapView {
    var recordingView: some View {
        HStack {
            VStack {
                Button(action: {
                    isRecordStart = false
                    isRecordEnd = true
                }) {
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
}

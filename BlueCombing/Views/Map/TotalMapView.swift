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
            
            if isRecordEnd {
                VisualEffectView(effect: UIBlurEffect(style: .init(rawValue: 3)!))
                    .ignoresSafeArea(.container, edges: .top)
            }

            MultiModal(recordEndTrigger: $isRecordEnd, recordStartTrigger: $isRecordStart, currentModal: $currentModal)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}


extension TotalMapView {
    var recordingView: some View {
        VStack {
            HStack {
                VStack {
                    Button(action: {
                        isRecordEnd = true
                        currentModal = 1
                    }) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.combingBlue4)
                                .cornerRadius(16)

                            Text("비치코밍 끝내기")
                                .font(.Button1)
                                .foregroundColor(.white)
                        }
                    }
                        .frame(width: 175, height: 48)
                        .padding(.top, 17)
                        .padding(.leading, 15)
                    
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.combingBlue5_2)
                            .cornerRadius(16)

                        VStack(alignment: .leading) {
                            Text("이동 거리")
                                .font(.Body5)
                                .foregroundColor(.combingGray1)
                            Text("2km")
                                .font(.Heading2)
                                .foregroundColor(.combingGray1)
                            
                            Spacer()
                                .frame(height: 18)
                            
                            Text("이동 시간")
                                .font(.Body5)
                                .foregroundColor(.combingGray1)
                            Text("1시간 20분")
                                .font(.Heading2)
                                .foregroundColor(.combingGray1)
                        }
                        .padding(.leading, 19)
                    }
                        .frame(width: 175, height: 142)
                        .padding(.top, 6)
                        .padding(.leading, 15)
                    
                }
                Spacer()
            }
            Spacer()
        }
        
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

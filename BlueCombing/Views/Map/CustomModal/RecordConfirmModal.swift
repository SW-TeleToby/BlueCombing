//
//  RecordConfirmView.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/10/12.
//

import SwiftUI
import MapKit

struct RecordConfirmModal: View {
    @Binding var currentModal: CustomModal
    @Binding var isRecordEnd: Bool
    @Binding var isRecordStart: Bool
    @Binding var routeImage: Image
    @Binding var movingTime: Int
    @Binding var movingDistance: Double
    @Binding var pathCoordinates: [CLLocationCoordinate2D]
    @Binding var isSignIn: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(24, corners: [.topLeft, .topRight])
            
            VStack {
                HStack {
                    Button(action: {
                        // TODO: 계속하기 Action
                        withAnimation(.spring()) {
                            currentModal = .none
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
                    isRecordStart = false
                    withAnimation(.spring()) {
                        if isSignIn {
                            currentModal = .cardMakingModal
                        } else {
                            currentModal = .loginModal
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
        .frame(height: currentModal.modalHeight)
    }
}

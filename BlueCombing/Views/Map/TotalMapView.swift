//
//  TotalMapView.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/09/16.
//

import SwiftUI
import UIKit
import MapKit

struct TotalMapView: View {
    @State var totalMapModel = TotalMapModel()
    @State var userActivityData = UserActivityData()
    @State var timer: Timer? = nil
    
    var body: some View {
        ZStack {
            MapView(map: $totalMapModel.map,
                    pathCoordinates: $userActivityData.pathCoordinates,
                    movingDistance: $userActivityData.movingDistance)
                .ignoresSafeArea(.container, edges: .top)

            Image("userPin")
            
            if totalMapModel.isRecordStart {
                recordingView
            }

            MultiModal(
                isRecordStart: $totalMapModel.isRecordStart,
                currentModal: $totalMapModel.currentModal,
                userActivityData: $userActivityData
            )
            .onChange(of: totalMapModel.isRecordStart, perform: { value in
                    if value {
                        startMoving()
                    }
                })
                .onChange(of: totalMapModel.currentModal) { value in
                    if value == .startModal {
                        totalMapModel.map.removeOverlays(totalMapModel.map.overlays)
                        userActivityData.pathCoordinates.removeAll()
                    }
                }
            
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    func simulatingFunction() {
        Task {
            tempCoordinates.publisher.sink(receiveValue: { value in
                sleep(1) // MARK: 타이머 조절
                userActivityData.pathCoordinates.append(value)
            })
        }
    }
    
    func startMoving() {
        simulatingFunction()
        
        userActivityData.movingTime = 0
        userActivityData.movingDistance = 0
        
        timer?.invalidate()
        
        totalMapModel.map.removeOverlays(totalMapModel.map.overlays)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            userActivityData.movingTime += 1
        }
    }
}


extension TotalMapView {
    var recordingView: some View {
        VStack {
            HStack {
                VStack {
                    Button(action: {
                        // TODO: 추후에 Spacer의 minHeight를 높여가는 방식으로 애니메이션 변경해야합니다.
                        withAnimation(.linear) {
                            totalMapModel.currentModal = .recordConfirmModal
                        }
                        CardViewModel.longitude = totalMapModel.map.region.center.longitude
                        CardViewModel.latitude = totalMapModel.map.region.center.latitude
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
                            Text(String(format: "%.2f", userActivityData.movingDistance / 1000) + "km")
                                .font(.Heading2)
                                .foregroundColor(.combingGray1)
                            
                            Spacer()
                                .frame(height: 18)
                            
                            Text("이동 시간")
                                .font(.Body5)
                                .foregroundColor(.combingGray1)
                            if userActivityData.movingTime >= 60 {
                                Text("\(userActivityData.movingTime / 3600)시간 \(userActivityData.movingTime / 60)분")
                                    .font(.Heading2)
                                    .foregroundColor(.combingGray1)
                            } else {
                                Text("1분 이내")
                                    .font(.Heading2)
                                    .foregroundColor(.combingGray1)
                            }
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


fileprivate let tempCoordinates: [CLLocationCoordinate2D] = [
    CLLocationCoordinate2D(latitude: 36.0519679, longitude: 129.378830),
    CLLocationCoordinate2D(latitude: 36.052458, longitude: 129.378543),
    CLLocationCoordinate2D(latitude: 36.053063, longitude: 129.378130),
    CLLocationCoordinate2D(latitude: 36.053583, longitude: 129.377371),
    CLLocationCoordinate2D(latitude: 36.0548065, longitude: 129.3773040),
    CLLocationCoordinate2D(latitude: 36.055565, longitude: 129.3784654),
    CLLocationCoordinate2D(latitude: 36.056294, longitude: 129.3786478),
    CLLocationCoordinate2D(latitude: 36.0571809, longitude: 129.3788382),
    CLLocationCoordinate2D(latitude: 36.0577251, longitude: 129.3787497),
    CLLocationCoordinate2D(latitude: 36.0579983, longitude: 129.37862366),
    CLLocationCoordinate2D(latitude: 36.0589502, longitude: 129.37918692),
    CLLocationCoordinate2D(latitude: 36.0590587, longitude: 129.3796268),
]

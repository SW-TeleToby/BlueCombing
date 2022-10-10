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
    @State var map = MKMapView()
    @State var isRecordEnd = false
    @State var isRecordStart = false
    @State var currentModal = 0
    // TODO: GPS 연결되면 초기값 변경해야 합니다.
    @State var pathCoordinates: [CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: 36.0519679, longitude: 129.378830)]
    @State var movingTime: Int = 0
    @State var movingDistance: Double = 0.0
    @State var timer: Timer? = nil
    private let digit: Double = pow(10, 2)
    
    var body: some View {
        ZStack {
            
            MapView(map: $map, pathCoordinates: $pathCoordinates, movingDistance: $movingDistance)
                .ignoresSafeArea(.container, edges: .top)

            Image("userPin")
            
            if isRecordStart {
                recordingView
            }
            
            if isRecordEnd {
                VisualEffectView(effect: UIBlurEffect(style: .init(rawValue: 3)!))
                    .ignoresSafeArea(.container, edges: .top)
            }

            MultiModal(
                recordEndTrigger: $isRecordEnd,
                isRecordStart: $isRecordStart,
                currentModal: $currentModal,
                pathCoordinates: $pathCoordinates,
                movingTime: $movingTime,
                movingDistance: $movingDistance
            )
                .onChange(of: isRecordStart, perform: { value in
                    if value {
                        startMoving()
                    } else {
                        map.removeOverlays(map.overlays)
                        pathCoordinates.removeAll()
                    }
                })
            
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    func simulatingFunction() {
        Task {
            tempCoordinates.publisher.sink(receiveValue: { value in
                sleep(1) // MARK: 타이머 조절
                pathCoordinates.append(value)
            })
        }
    }
    
    func startMoving() {
        simulatingFunction()
        
        movingTime = 0
        movingDistance = 0
        
        timer?.invalidate()
        
        map.removeOverlays(map.overlays)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            movingTime += 1
        }
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
                        CardViewModel.longitude = map.region.center.longitude
                        CardViewModel.latitude = map.region.center.latitude
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
                            Text(String(format: "%.2f", movingDistance / 1000) + "km")
                                .font(.Heading2)
                                .foregroundColor(.combingGray1)
                            
                            Spacer()
                                .frame(height: 18)
                            
                            Text("이동 시간")
                                .font(.Body5)
                                .foregroundColor(.combingGray1)
                            if movingTime >= 60 {
                                Text("\(movingTime / 3600)시간 \(movingTime / 60)분")
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

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
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

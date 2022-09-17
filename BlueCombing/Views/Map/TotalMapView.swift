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
    @State var mapManager = MapDelegate()
    @State var isRecordEnd = false
    @State var isRecordStart = false
    @State var currentModal = 0
    @State var pathCoordinates: [CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: 36.662222, longitude: 127.501667)]
    @State var movingTime: Int = 0
    @State var movingDistance: Double = 0.0
    @State var timer: Timer? = nil
    private let digit: Double = pow(10, 2)
    
    var body: some View {
        ZStack {
            
            MapView(map: mapManager.map, delegate: mapManager, pathCoordinates: $pathCoordinates, movingDistance: $movingDistance)
                .ignoresSafeArea(.container, edges: .top)

            Image("userPin")
            
            if isRecordStart {
                recordingView
                    .onAppear{
                        simulatingFunction()
                    }
            }
            
            if isRecordEnd {
                VisualEffectView(effect: UIBlurEffect(style: .init(rawValue: 3)!))
                    .ignoresSafeArea(.container, edges: .top)
            }

            MultiModal(
                recordEndTrigger: $isRecordEnd,
                recordStartTrigger: $isRecordStart,
                currentModal: $currentModal,
                pathCoordinates: $pathCoordinates,
                movingTime: $movingTime,
                movingDistance: $movingDistance
            )
                .onChange(of: isRecordStart, perform: { value in
                    if value {
                        startMoving()
                    }
                })
            
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    func simulatingFunction() {
        Task {
            tempCoordinates.publisher.sink(receiveValue: { value in
                sleep(3) // MARK: 타이머 조절
                pathCoordinates.append(value)
            })
        }
    }
    
    func startMoving() {
        movingTime = 0
        movingDistance = 0
        
        timer?.invalidate()
        
        mapManager.map.removeOverlays(mapManager.map.overlays)
        
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
                        CardViewModel.longitude = mapManager.map.region.center.longitude
                        CardViewModel.latitude = mapManager.map.region.center.latitude
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
                            Text("\(movingTime / 3600)시간 \(movingTime / 60)분 \(movingTime % 60)초")
                                .font(.Body3) // MARK: 폰트 자시 조정할 것 Original Heading2
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


fileprivate let tempCoordinates: [CLLocationCoordinate2D] = [
    CLLocationCoordinate2D(latitude: 36.663, longitude: 127.501),
    CLLocationCoordinate2D(latitude: 36.662, longitude: 127.504),
    CLLocationCoordinate2D(latitude: 36.660, longitude: 127.509),
    CLLocationCoordinate2D(latitude: 36.657, longitude: 127.505),
    CLLocationCoordinate2D(latitude: 36.659, longitude: 127.510),
    CLLocationCoordinate2D(latitude: 36.660, longitude: 127.513),
]

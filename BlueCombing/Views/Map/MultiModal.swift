//
//  MultiModal.swift
//  BlueCombing
//
//  Created by Inho Choi on 2022/09/16.
//

import MapKit
import UIKit
import FirebaseAuth
import SwiftUI

struct MultiModal: View {
    @State var modalHeight = CGFloat(168)
    @State var loginCancleAlertTrigger = false
    @Binding var isRecordEnd: Bool
    @Binding var isRecordStart: Bool
    @Binding var currentModal: CustomModal
    @Binding var pathCoordinates: [CLLocationCoordinate2D]
    @State var routeImage = Image("Is not Load")
    @Binding var movingTime: Int
    @Binding var movingDistance: Double
    @State private var showingAlert = false
    let firebaseAuth = Auth.auth()
    @State var isSignIn: Bool = true
    @State var isCustom: Bool = true
    
    
    var body: some View {
        ZStack {
            
            switch currentModal {
            case .recordConfirmModal: BlurView().ignoresSafeArea(.container, edges: .top)
            default: Spacer()
            }
            
            VStack {
                Spacer()
                
                switch currentModal {
                case .startModal: StartModal(currentModal: $currentModal,
                                             isRecordStart: $isRecordStart,
                                             isRecordEnd: $isRecordEnd)
                case .recordConfirmModal: RecordConfirmModal(currentModal: $currentModal,
                                                             isRecordEnd: $isRecordEnd,
                                                             isRecordStart: $isRecordStart,
                                                             routeImage: $routeImage,
                                                             movingTime: $movingTime,
                                                             movingDistance: $movingDistance,
                                                             pathCoordinates: $pathCoordinates,
                                                             isSignIn: $isSignIn)
                case .cardMakingModal: CardMakingModal(currentModal: $currentModal,
                                                       isRecordEnd: $isRecordEnd,
                                                       routeImage: $routeImage,
                                                       movingDistance: $movingDistance,
                                                       movingTime: $movingTime)
                .frame(height: currentModal.modalHeight)
                case .loginModal: LoginModal(currentModal: $currentModal,
                                             isSignIn: $isSignIn,
                                             showingAlert: $showingAlert,
                                             loginCancleAlertTrigger: $loginCancleAlertTrigger)
                .frame(height: currentModal.modalHeight)
                case .none: Spacer()
                        .frame(height: currentModal.modalHeight)
                }
                
                
            }
        }
        .alert("로그인하지 않으면 비치코밍\n기록을 남길 수 없습니다.", isPresented: $loginCancleAlertTrigger) {
            Button("취소", role: .cancel) { }
            Button("확인", role: .destructive) {
                isRecordEnd = false
                isRecordStart = false
                currentModal = .startModal
            }
        }
            .onAppear {
                if firebaseAuth.currentUser != nil {
                    isSignIn = true
                } else {
                    isSignIn = false
                }
            }
    }
}

enum CustomModal: String {
    case startModal
    case recordConfirmModal
    case cardMakingModal
    case loginModal
    case none
    
    var modalHeight: CGFloat {
        switch self {
        case .startModal: return 168
        case .recordConfirmModal: return 366
        case .cardMakingModal, .loginModal: return 212
        case .none: return 0
        }
    }
}


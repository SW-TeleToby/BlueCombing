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
    @EnvironmentObject var authSession: SessionStore
    
    @Binding var isRecordStart: Bool
    @Binding var currentModal: CustomModal
    @Binding var userActivityData: UserActivityData
    @State var showDeleteActivityDataAlert = false
    @State var routeImage = Image("Is not Load")
    @State private var showingAlert = false
    let firebaseAuth = Auth.auth()
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
                                             isRecordStart: $isRecordStart)
                case .recordConfirmModal: RecordConfirmModal(currentModal: $currentModal,
                                                             isRecordStart: $isRecordStart,
                                                             routeImage: $routeImage,
                                                             userActivityData: $userActivityData)
                case .cardMakingModal: CardMakingModal(currentModal: $currentModal,
                                                       routeImage: $routeImage,
                                                       userActivityData: $userActivityData)
                case .loginModal: LoginModal(currentModal: $currentModal,
                                             showDeleteActivityDataAlert: $showDeleteActivityDataAlert)
                case .none: Spacer()
                        .frame(height: currentModal.modalHeight)
                }
                
                
            }
        }
        .alert("로그인하지 않으면 비치코밍\n기록을 남길 수 없습니다.", isPresented: $showDeleteActivityDataAlert) {
            Button("취소", role: .cancel) { }
            Button("확인", role: .destructive) {
                isRecordStart = false
                currentModal = .startModal
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


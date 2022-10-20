//
//  OnboardingView.swift
//  BlueCombing
//
//  Created by Wonhyuk Choi on 2022/09/17.
//

import SwiftUI

struct OnboardingView: View {
    @State private var textAnimation = false
    @State private var onboardingState = OnboardingState.start
    @GestureState var isUpdating = false
    @State private var offset = CGSize.zero
    @State private var isIn = false
    @Binding var isFirstStart: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .overlay {
                    Image("img_onboarding_background")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
            if onboardingState == .done {
                BlurView()
                    .ignoresSafeArea()
            }
            
            VStack {
                if onboardingState == .done {
                    Spacer()
                    VStack {
                        Image("img_trash_set")
                        Text("이처럼 해변을 빗질하듯 바다의 쓰레기를\n줍는 행위를 비치코밍(Beach Combing)이라고 합니다") { string in
                            string.foregroundColor = .combingGray1
                            if let range = string.range(of: "비치코밍(Beach Combing)") {
                                string[range].foregroundColor = .combingBlue3
                            }
                        }
                        .font(.custom("Pretendard-Medium", size: 16))
                        .multilineTextAlignment(.center)
                        .padding(.vertical)
                        Text("블루코밍에서 해변을 빗질해보세요!")
                            .font(.custom("Pretendard-Medium", size: 16))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                 else {
                    Text("BLUE\nCOMBING")
                        .kerning(-7)
                        .font(.custom("Pretendard-Bold", size: 80))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 64)
                    Spacer()
                }
                gestureView
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.75).repeatForever()) {
                textAnimation = true
            }
        }
    }
}

extension OnboardingView {
    @ViewBuilder
    var gestureView: some View {
        switch onboardingState {
            
        case .start:
            Image("img_pet")
                .offset(x: -70, y: -50)
                .opacity(isUpdating ? 0.5 : 1.0)
                .gesture(
                    LongPressGesture(minimumDuration: 0.5)
                        .updating($isUpdating) { currentState, gestureState, transaction in
                            gestureState = currentState
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                onboardingState = .trash
                            }
                        }
                )
            Text("쓰래기를 꾹 눌러서 버려보세요")
                .font(.custom("Pretendard-Medium", size: 16))
                .foregroundColor(.combingBlue5)
                .lineLimit(1)
                .opacity(textAnimation ? 1.0 : 0.5)
                .padding(.bottom, 88)
            
        case .trash:
            ZStack {
                Button {
                    
                } label: {
                    HStack(alignment: .center) {
                        Image("icn_trash")
                        Text("쓰레기 버리기")
                            .font(.custom("Pretendard-Bold", size: 16))
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 15)
                    .frame(minWidth: 0, maxWidth: 175)
                }
                .background(isIn ? Color(hex: 0xB92D2D) : Color(hex: 0xDF5E5E))
                .cornerRadius(16)
                Image("img_pet")
                    .offset(x: -70 + offset.width, y: -137 + offset.height)
                    .gesture(
                        DragGesture()
                            .onChanged{ gesture in
                                offset = gesture.translation
                                if 80 < offset.height && offset.height < 205 &&
                                    -20 < offset.width && offset.width < 150 {
                                    isIn = true
                                } else {
                                    isIn = false
                                }
                            }
                            .onEnded { _ in
                                if 80 < offset.height && offset.height < 205 &&
                                    -20 < offset.width && offset.width < 150 {
                                    withAnimation(.spring()) {
                                        onboardingState = .done
                                    }
                                } else {
                                    offset = .zero
                                }
                            }
                    )
            }
            .padding(.vertical, 27)
        case .done:
            Button {
                withAnimation(.spring()) {
                    isFirstStart = false
                }
            } label: {
                HStack(alignment: .center) {
                    Image("icn_trash")
                    Text("쓰레기 버리기")
                        .font(.custom("Pretendard-Bold", size: 16))
                        .foregroundColor(.white)
                }
                .padding(.vertical, 15)
                .frame(minWidth: 0, maxWidth: 175)
            }
            .background(Color.combingGradient1)
            .cornerRadius(16)
            .padding(.vertical, 47)
        }
    }
}

extension Text {
    init(_ string: String, configure: ((inout AttributedString) -> Void)) {
        var attributedString = AttributedString(string) /// create an `AttributedString`
        configure(&attributedString) /// configure using the closure
        self.init(attributedString) /// initialize a `Text`
    }
}

enum OnboardingState {
    case start
    case trash
    case done
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isFirstStart: .constant(true))
    }
}

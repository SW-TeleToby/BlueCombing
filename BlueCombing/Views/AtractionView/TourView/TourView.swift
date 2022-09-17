//
//  TourView.swift
//  BlueCombing
//
//  Created by Jun.Mac on 2022/09/17.
//

import SwiftUI

struct TourView: View {
    @Namespace var namespace
    @State var show = false
    @State var showStatusBar = true
    @State var selectedID = UUID()
    
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
            
            ScrollView {
                
                if !show {
                    cards
                } else {
                    ForEach(tourCourses) { course in
                        Rectangle()
                            .fill(.white)
                            .frame(height: 300)
                            .cornerRadius(30)
                            .shadow(color: Color("Shadow"), radius: 20, x: 0, y: 10)
                            .opacity(0.3)
                            .padding(.horizontal, 30)
                    }
                }
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            
            if show {
                detail
            }
        }
        .statusBar(hidden: !showStatusBar)
        .onChange(of: show) { newValue in
            withAnimation(.closeCard) {
                if newValue {
                    showStatusBar = false
                } else {
                    showStatusBar = true
                }
            }
        }
    }
    var cards: some View {
        ForEach(tourCourses) { course in
            TourCourseItem(namespace: namespace, course: course, show: $show)
                .onTapGesture {
                    withAnimation(.openCard) {
                        show.toggle()
                        showStatusBar = false
                        selectedID = course.id
                    }
                }
        }
    }
    var detail: some View {
        ForEach(tourCourses) { course in
            if course.id == selectedID {
                TourCourseView(namespace: namespace, course: course, show: $show)
                    .zIndex(1)
                    .transition(.asymmetric(
                        insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                        removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
            }
        }
    }
}

struct TourView_Previews: PreviewProvider {
    static var previews: some View {
        TourView()
    }
}

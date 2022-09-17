//
//  CourseView.swift
//  BlueCombing
//
//  Created by Jun.Mac on 2022/09/17.
//

import SwiftUI

struct TourCourseView: View {
    var namespace: Namespace.ID
    var course: Course
    @Binding var show: Bool
    @State var appear = [false, false, false]
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                
                content
                    .offset(y: 120)
                    .padding(.bottom, 200)
                    .opacity(appear[2] ? 1 : 0)
            }
            .background(Color(.white))
            .ignoresSafeArea()
            
            button
        }
        .onAppear {
            fadeIn()
        }
        .onChange(of: show) { newValue in
            fadeOut()
        }
    }
    
    var cover: some View {
        VStack {
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 500)
        .foregroundStyle(.black)
        .background(
            Image(course.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background\(course.id)", in: namespace)
        )
        .mask(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask\(course.id)", in: namespace)
        )
        .overlay(
            VStack(alignment: .leading, spacing: 12) {
                Text(course.name)
                    .opacity(appear[1] ? 1 : 0)
                    .font(.largeTitle.weight(.bold))
                    .matchedGeometryEffect(id: "name\(course.id)", in: namespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(course.location)
                    .opacity(appear[1] ? 1 : 0)
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "location\(course.id)", in: namespace)
                
            }
                .background(
                    Rectangle()
                        .fill(.thinMaterial)
                        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .blur(radius: 30)
                        .matchedGeometryEffect(id: "blur\(course.id)", in: namespace)
                )
                .opacity(appear[2] ? 1 : 0)
                .offset(y: 200)
                .padding(20)
        )
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text(course.text)
                .font(.title3).fontWeight(.medium)
            
        }
        .padding(20)
    }
    var button: some View {
        Button {
            withAnimation(.closeCard) {
                show.toggle()
            }
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.bold))
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
        .ignoresSafeArea()
    }
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
        withAnimation(.easeOut.delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.5)) {
            appear[2] = true
        }
    }
    
    func fadeOut() {
        appear[0] = false
        appear[1] = false
        appear[2] = false
    }
}


//struct TourCourseView_Previews: PreviewProvider {
//    @Namespace static var namespace
//    
//    static var previews: some View {
//        TourCourseView(namespace: namespace, show: .constant(true))
//    }
//}

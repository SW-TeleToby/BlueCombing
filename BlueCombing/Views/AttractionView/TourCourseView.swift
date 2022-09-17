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
    @State var descriptions = [String]()

    var body: some View {
        ZStack {
            ScrollView {
                cover
                
                content
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
            ForEach(descriptions, id: \.self) { str in
                Text(str)
                    .font(.Body4)
                    .foregroundColor(.combingGray5)
            }
        }
            .padding(20)
            .onAppear {
            descriptions = course.text.components(separatedBy: "\n")
        }
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


struct TourCourseView_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        TourCourseView(namespace: namespace, course: Course(name: "호미곶 상생의 손", location: "경상북도 포항시 남구 호미곶면 해맞이로 136", text: "상생의 손은 포항시 호미곶에 있는 해맞이 광장에 위치한 기념물로 인류가 화합하고 화해하며 더불어 사는 사회를 만들어가자는 의미로 만들어진 조각물이다. 바다에는 오른손이, 육지에는 왼손이 있다. \n1999년에 조각가 영남대학교 김승국 교수를 제작되었으며, 이어령 대한민국 새천년준비위원회 위원장, 대구은행 협찬 당시에 붙인 이름이다.\n하지만 상생의 손 조각의 원본이라 할 수 있는 작품은 서울예술대학(구 서울예술전문대) 사진과 1997년 졸업 작품집에 먼저 등장했다.", background: "img_hand"), show: .constant(true))
    }
}

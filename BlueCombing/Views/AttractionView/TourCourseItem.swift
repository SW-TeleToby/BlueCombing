//
//  CourseItem.swift
//  BlueCombing
//
//  Created by Jun.Mac on 2022/09/17.
//

import SwiftUI

struct TourCourseItem: View {
    var namespace: Namespace.ID
    var course: Course
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text(course.name)
                    .font(.largeTitle.weight(.bold))
                    .matchedGeometryEffect(id: "name\(course.id)", in: namespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(course.location)
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "location\(course.id)", in: namespace)
                
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur\(course.id)", in: namespace)
            )
        }
        .foregroundStyle(.white)
        .background(
            Image(course.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background\(course.id)", in: namespace)
        )
        .mask(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .matchedGeometryEffect(id: "mask\(course.id)", in: namespace)
        )
        .frame(height: 470)
        .padding(20)
    }
}

//struct TourCourseItem_Previews: PreviewProvider {
//    @Namespace static var namespace
//    
//    static var previews: some View {
//        TourCourseItem(namespace: namespace, show: .constant(true))
//    }
//}

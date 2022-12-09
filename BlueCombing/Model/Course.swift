//
//  Course.swift
//  BlueCombing
//
//  Created by Jun.Mac on 2022/09/17.
//

import SwiftUI

struct Course: Identifiable {
    let id = UUID()
    var name: String
    var location: String
    var background: String
}


//var tourCourses = [
//    Course(name: "호미곶 상생의 손", location: "경상북도 포항시 남구 호미곶면 해맞이로 136", text: "블라블라", background: "img_hand"),
//    Course(name: "영일대 해상누각", location: "경상북도 포항시 남구 호미곶면 해맞이로 136", text: "블라블라", background: "img_​​pavilion"),
//    Course(name: "영일대 이순신 동상", location: "경상북도 포항시 남구 호미곶면 해맞이로 136", text: "블라블라", background: "img_sunshin"),
//    Course(name: "영일대 스카이 라인", location: "경상북도 포항시 남구 호미곶면 해맞이로 136", text: "블라블라", background: "img_skyline"),
//]

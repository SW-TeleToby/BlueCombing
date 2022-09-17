//
//  BadgeGradeViewNavbar.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/17.
//

import SwiftUI

struct BadgeGradeViewNavbar: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack(spacing: 100){
            Image(systemName: "chevron.backward")
                .font(.Body2)
                .padding(20)
                .onTapGesture {
                    dismiss()
                }
            Text("비치코밍 등급")
                .font(.Body3)
            Spacer()
        }
    }
}

struct BadgeGradeViewNavbar_Previews: PreviewProvider {
    static var previews: some View {
        BadgeGradeViewNavbar()
    }
}

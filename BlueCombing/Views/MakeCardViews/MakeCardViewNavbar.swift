//
//  MakeCardViewNavbar.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/16.
//

import SwiftUI

struct MakeCardViewNavbar: View {
    @Environment(\.dismiss) var dismiss
    @Binding var page: Int
    var body: some View {
        HStack(spacing: 90){
            Image(systemName: "chevron.backward")
                .font(.system(size: 20, weight: .semibold))
                .padding(.leading,20)
                .onTapGesture {
                    if page == 0 {
                        dismiss()
                    }
                    else {
                        page = 0
                    }
                    
                }
            Text("비치코밍 카드 만들기")
                .font(.system(size: 17, weight: .bold))
            Spacer()
        }
    }
}

struct MakeCardViewNavbar_Previews: PreviewProvider {
    static var previews: some View {
        MakeCardViewNavbar(page: .constant(0))
    }
}
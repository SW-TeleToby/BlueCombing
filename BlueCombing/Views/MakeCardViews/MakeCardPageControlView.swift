//
//  MakeCardPageControlView.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/16.
//

import SwiftUI

struct MakeCardPageControlView: View {
    @State var page = 0
    var body: some View {
        if page == 0 {
            // 이미지 변경하는 뷰
            MakeCardView(page: $page)
        } else {
            // 뱃지 추가하는 뷰

        }

    }
}

struct MakeCardPageControlView_Previews: PreviewProvider {
    static var previews: some View {
        MakeCardPageControlView()
    }
}

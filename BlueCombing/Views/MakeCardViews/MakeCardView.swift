//
//  MakeCardView.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/16.
//

import SwiftUI

struct MakeCardView: View {
    @StateObject var cardViewModel = CardViewModel()
    @Binding var page: Int
    var body: some View {
        VStack {
            Text("hi")
        }
    }
}

struct MakeCardView_Previews: PreviewProvider {
    static var previews: some View {
        MakeCardView(page: .constant(0))
    }
}

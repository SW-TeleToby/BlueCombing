//
//  LimitedImagePicker.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/16.
//

import SwiftUI
import PhotosUI
// 선택한 사진 접근 권한시 나오는 시트
struct LimitedImagePicker: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var card: Card
    private let threeColumnGrid = [
        GridItem(.flexible(minimum: 40), spacing: 2),
        GridItem(.flexible(minimum: 40), spacing: 2),
        GridItem(.flexible(minimum: 40), spacing: 2),
    ]
    
    @State var disabled = true
    @State var grid : [Photo] = []
    
    var body: some View {
        ZStack {
            VStack {
                // 앨범에서 선택한 사진이 없을때 어떻게 보여줄 것인가?
                HStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }){
                        Text("취소")
                    }.padding()
                    Spacer()
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: threeColumnGrid, alignment: .leading, spacing: 2) {
                        ForEach(0..<grid.count, id: \.self) { i in
                            Rectangle()
                                .fill(.black)
                                .aspectRatio(1, contentMode: .fit)
                                .overlay{
                                    Image(uiImage: grid[i].image)
                                        .resizable()
                                        .scaledToFill()
                                }
                                .clipped()
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    card.backgroundImage = grid[i].image
                                    presentationMode.wrappedValue.dismiss()
                                }
                        }
                    }
                }
            }
            
            
        }.onAppear {
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    getAllImages()
                    disabled = false
                }
                else {
                    disabled = true
                }
            }
        }
    }
    
    func getAllImages(){
        let opt = PHFetchOptions()
        opt.includeHiddenAssets = false
        
        let req = PHAsset.fetchAssets(with: .image, options: .none)
        DispatchQueue.global(qos: .background).async {
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            options.resizeMode = .exact
            
            var iteration : [Photo] = []
            for i in stride(from: 0, to: req.count, by: 1) {
                if i < req.count {
                    // 원본 화질로 하면, 보기는 좋지만 로딩되는 시간때문에 체크가 풀린다.
                    PHCachingImageManager.default().requestImage(for: req[i], targetSize: .init(), contentMode: .default, options: options) { (image,_) in
                        let data = Photo(image: image!, selected: false, asset: req[i])
                        iteration.append(data)
                    }
                }
                DispatchQueue.main.async {
                    self.grid = iteration
                }
            }
        }
    }
}


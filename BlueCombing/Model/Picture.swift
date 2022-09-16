//
//  PictureModel.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/16.
//

import Foundation
import UIKit
import Photos

struct Photo: Hashable {
    let id = UUID()
    var image:UIImage
    var selected:Bool
    var asset: PHAsset
}

//
//  CameraView.swift
//  BlueCombing
//
//  Created by ryu hyunsun on 2022/09/16.
//

import SwiftUI
import UIKit

struct Camera: UIViewControllerRepresentable {
    @Binding var card: Card
    @Environment(\.presentationMode) var presentationMode
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Camera>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: Camera
        init(_ parent: Camera) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.card.backgroundImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}

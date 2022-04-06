//
//  ImagePicker.swift
//  test
//
//  Created by Илья Колбеко on 22.03.22.
//

import SwiftUI
import Foundation

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var image: UIImage?
    @Binding var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = self.sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {  }
}

// MARK: Coordinator
class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var parent: ImagePicker
    
    init(_ parent: ImagePicker) {
        self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.parent.image = selectedImage
        parent.isPresented.toggle()
    }
}

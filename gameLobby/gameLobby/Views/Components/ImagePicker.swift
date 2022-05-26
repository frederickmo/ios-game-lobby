//
//  ImagePicker.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/24.
//

import SwiftUI

typealias ImagePickerImageIsSelected = (UIImage) -> Void

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) private var presentationMode
    
    // 控制通过系统相册获取图片还是通过摄像头获取图片
    let sourceType: UIImagePickerController.SourceType
    let isImageSelected: ImagePickerImageIsSelected
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, isImageSelected: isImageSelected)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = context.coordinator
        return imagePickerViewController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding private var presentationMode: PresentationMode
        private let isImageSelected: (UIImage) -> Void
        
        init(presentationMode: Binding<PresentationMode>, isImageSelected: @escaping ImagePickerImageIsSelected) {
            _presentationMode = presentationMode
            self.isImageSelected = isImageSelected
        }
        
        // 从相册或相机获取到图片的代理方法
        func imagePickerController(_ _picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // 从Info中获取图片
            let image = info[.originalImage] as! UIImage
            // 执行isImageSelected回调将图片传出去
            isImageSelected(image)
            // 退出imagePickerViewController
            presentationMode.dismiss()
        }
    }
    
    typealias UIViewControllerType = UIImagePickerController
    
    
    
}

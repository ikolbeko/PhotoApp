//
//  AddImageView.swift
//  PhotoApp
//
//  Created by Илья Колбеко on 22.03.22.
//

import SwiftUI

struct AddImageView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @StateObject var cameraManager = CameraManager()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var image: UIImage?
    @State var descriptions = ""
    @State var show = false
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                
                ZStack {
                    // Library & Camera Picker Button
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    } else {
                        HStack {
                            // From Camera
                            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                                Button {
                                    sourceType = .camera
                                    show.toggle()
                                } label: {
                                    Image(systemName: "camera")
                                        .font(.system(size: 70))
                                        .padding(50)
                                }
                            }
                            // From Library
                            Button {
                                sourceType = .photoLibrary
                                show.toggle()
                            } label: {
                                Image(systemName: "photo")
                                    .font(.system(size: 70))
                                    .padding(50)
                            }
                        }
                    }
                    
                }
                
                // Description TextField
                TextField("Description...", text: $descriptions)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                
                // Add Image Button
                Button {
                    addItem()
                } label: {
                    if image != nil {
                        Text("Add Image")
                            .padding()
                            .foregroundColor((descriptions.count > 0) ? Color.white : Color.black)
                            .background((descriptions.count > 0) ? Color.blue : Color.secondary)
                            .cornerRadius(20)
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        isPresented.toggle()
                    }, label: {
                        Text("Cancel")
                    })
                }
            }
        }
        .sheet(isPresented: $show) {
            ImagePicker(image: $image, sourceType: sourceType)
        }
        .onAppear {
            cameraManager.requestPermission()
        }
    }
}

extension AddImageView {
    private func addItem() {
        let newItem = ImageStorage(context: viewContext)
        newItem.descriptions = descriptions
        newItem.savedImage = image?.jpegData(compressionQuality: 1)
        newItem.date = Date.now
        
        do {
            try viewContext.save()
            isPresented.toggle()
            descriptions = ""
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

//struct AddImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddImageView()
//    }
//}

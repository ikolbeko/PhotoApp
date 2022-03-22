//
//  AddImageView.swift
//  PhotoApp
//
//  Created by Илья Колбеко on 22.03.22.
//

import SwiftUI

struct AddImageView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var image: Data? = .init(count: 0)
    @State var descriptions = ""
    @State var show = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                // ImagePicker Button
                if image?.count != 0 {
                    Button {
                        show.toggle()
                    } label: {
                        if let data = image,
                           let uiimage = UIImage(data: data) {
                            AnyView(Image(uiImage: uiimage)
                                        .resizable()
                                        .scaledToFit()
                            )
                        }
                        else {
                            AnyView(EmptyView())
                        }
                    }
                } else {
                    Button {
                        show.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 70))
                            .padding(50)
                    }
                }
                
                // Description TextField
                TextField("Description...", text: $descriptions)
                    .padding()
                
                
                // Add Image Button
                Button {
                    addItem()
                } label: {
                    if let image = image?.count {
                        Text("Add Image")
                            .padding()
                            .foregroundColor((descriptions.count > 0 && image > 0) ? Color.white : Color.black)
                            .background((descriptions.count > 0 && image > 0) ? Color.blue : Color.secondary)
                            .cornerRadius(20)
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
            }
        }
        .sheet(isPresented: $show) {
            ImagePicker(image: $image, show: $show)
        }
    }
}

extension AddImageView {
    private func addItem() {
        let newItem = ImageStorage(context: viewContext)
        newItem.descriptions = descriptions
        newItem.savedImage = image
        newItem.date = Date.now
        
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
            descriptions = ""
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
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

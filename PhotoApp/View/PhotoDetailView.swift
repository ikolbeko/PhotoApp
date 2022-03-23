//
//  PhotoDetailView.swift
//  PhotoApp
//
//  Created by Илья Колбеко on 22.03.22.
//

import SwiftUI

struct PhotoDetailView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    var items: FetchedResults<ImageStorage>
    @State var current: ImageStorage
    
    var body: some View {
        
        TabView(selection: $current) {
            ForEach(items) { item in
                VStack {
                    if let image = item.savedImage, let descriptions = item.descriptions {
                        Image(uiImage: UIImage(data: image) ?? UIImage())
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFill()
                            .frame(width: (UIScreen.main.bounds.width - 32)/2, height: 250, alignment: .center)
                        
                        Text(descriptions)
                    }
                }.tag(item)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .toolbar {
            ToolbarItem {
                Button(action: {
                    deleteItems(current)
                }, label: {
                    Image(systemName: "trash")
                })
            }
        }
    }
}

extension PhotoDetailView {
    private func deleteItems(_ value: ImageStorage) {
        withAnimation {
            viewContext.delete(current)
            
            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

//struct PhotoDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoDetailView()
//    }
//}

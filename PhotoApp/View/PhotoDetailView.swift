//
//  PhotoDetailView.swift
//  PhotoApp
//
//  Created by Илья Колбеко on 22.03.22.
//

import SwiftUI

struct PhotoDetailView: View {
    
    var items: FetchedResults<ImageStorage>
    @State var current: ImageStorage
    
    var body: some View {
        
        TabView(selection: $current) {
            ForEach(items) { item in
                if let image = item.savedImage {
                    Image(uiImage: UIImage(data: image) ?? UIImage())
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(width: (UIScreen.main.bounds.width - 32)/2, height: 250, alignment: .center)
                        .tag(item)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

//struct PhotoDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoDetailView()
//    }
//}

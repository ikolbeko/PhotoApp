//
//  ImageRow.swift
//  PhotoApp
//
//  Created by Илья Колбеко on 22.03.22.
//

import SwiftUI

struct ImageRow: View {
    
    var photo: ImageStorage
    
    var body: some View {
        if let photo = photo.savedImage {
            Image(uiImage: UIImage(data: photo) ?? UIImage())
                .resizable()
                .scaledToFit()
        }
    }
}

//    struct ImageRow_Previews: PreviewProvider {
//        static var previews: some View {
//            ImageRow()
//        }
//    }

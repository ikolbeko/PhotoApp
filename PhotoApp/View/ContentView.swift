//
//  ContentView.swift
//  PhotoApp
//
//  Created by Илья Колбеко on 22.03.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ImageStorage.date, ascending: true)],animation: .default)
    private var items: FetchedResults<ImageStorage>
    
    @State private var navigationText = LocalizedStringKey("Gallery")
    @State var show = false
    
    var columns = [
        GridItem(),
        GridItem(),
        GridItem()
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(items) { item in
                        NavigationLink(destination: PhotoDetailView(items: items, current: item)) {
                            ImageRow(photo: item)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        show.toggle()
                    }, label: {
                        Label("Add Item", systemImage: "plus")
                    })
                }
            }
            .navigationTitle(navigationText)
            .sheet(isPresented: $show) {
                AddImageView(isPresented: $show).environment(\.managedObjectContext, self.viewContext)
            }
        }
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}

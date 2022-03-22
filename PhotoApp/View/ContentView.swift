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

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ImageStorage.savedImage, ascending: true),
            NSSortDescriptor(keyPath: \ImageStorage.descriptions, ascending: true),
        ],
        animation: .default)
    private var items: FetchedResults<ImageStorage>
    
    @State var show = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    if let data = item.savedImage,
                       let uiimage = UIImage(data: data) {
                        AnyView(Image(uiImage: uiimage)
                                    .resizable()
                                    .scaledToFit()
                        )
                    }
                    else {
                        AnyView(EmptyView())
                    }
                    
                    if let descriptions = item.descriptions {
                        Text("\(descriptions)")
                    }
//                    NavigationLink {
//                        Text("Item at \(item.descriptions!)")
//                    } label: {
//                        Text("\(item.descriptions!)")
//                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        show.toggle()
                    }, label: {
                        Label("Add Item", systemImage: "plus")
                    })
                }
            }
            .sheet(isPresented: $show) {
                AddImageView().environment(\.managedObjectContext, self.viewContext)
            }
            Text("Select an item")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}

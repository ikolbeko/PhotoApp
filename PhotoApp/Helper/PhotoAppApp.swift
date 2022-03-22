//
//  PhotoAppApp.swift
//  PhotoApp
//
//  Created by Илья Колбеко on 22.03.22.
//

import SwiftUI

@main
struct PhotoAppApp: App {
    let persistenceController = PersistenceController.shared
    let data = KeyChainHelper.standart.read(service: "app", account: "photoApp")
    
    var body: some Scene {
        
        WindowGroup {
                ContentView()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
        
//        WindowGroup {
//            if data != nil {
//                LoginView()
//            } else {
//                InitialView()
//            }
//        }
    }
}

//
//  LoginView.swift
//  PhotoApp
//
//  Created by Илья Колбеко on 20.03.22.
//

import SwiftUI

struct LoginView: View {
    
    @State private var password = ""
    @State private var confirm = false
    
    var body: some View {
        VStack {
            Text("Enter password")
                .font(.largeTitle)
            
            SecureField("Input password..." ,text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button {
                let data = KeyChainHelper.standart.read(service: "app", account: "photoApp")!
                let accessToken = String(data: data, encoding: .utf8)!
                if password == accessToken {
                    confirm = true
                } else {
                    //confirmLabel = "invalid password"
                }
            } label: {
                Text("Login")
            }
            .fullScreenCover(isPresented: $confirm) {
                ContentView()
                    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            }
            .padding()
            .buttonStyle(.bordered)
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}

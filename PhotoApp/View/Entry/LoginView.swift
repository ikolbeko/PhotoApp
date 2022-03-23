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
    @State private var confirmLabel = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .white, .pink]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            VStack {
                Text("Enter password")
                    .font(.largeTitle)
                
                SecureField("password..." ,text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Text(confirmLabel)
                
                Button {
                    let data = KeyChainHelper.standart.read(service: "app", account: "photoApp")!
                    let accessToken = String(data: data, encoding: .utf8)!
                    if password == accessToken {
                        confirm = true
                    } else {
                        confirmLabel = "invalid password"
                    }
                } label: {
                    Text("Login")
                        .font(.title2)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .foregroundColor(.white)
                        .background(.indigo)
                        .cornerRadius(20)
                }
                .fullScreenCover(isPresented: $confirm) {
                    ContentView()
                        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                }
                .padding()
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}

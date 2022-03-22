//
//  ContentView.swift
//  PhotoApp
//
//  Created by Илья Колбеко on 19.03.22.
//

import SwiftUI

struct InitialView: View {
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var confirm = false
        
    var body: some View {
        VStack {
            Text("Welcome! 🎉")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Text("You need a set password")
            
            // Set password textField
            SecureField("Set password..." ,text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Confirm password..." ,text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                        
            // Set password button
            Button {
                if password == confirmPassword && password != ""{
                    confirm = true
                    let data = Data(password.utf8)
                    KeyChainHelper.standart.save(data, service: "app", account: "photoApp")
                    print(data)
                } else {
                    //confirmLabel = "invalid password"
                }
            } label: {
                Text("Set password")
            }
            .fullScreenCover(isPresented: $confirm) {
                ContentView()
                    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            }
            .buttonStyle(.bordered)
            
            Spacer()
        }
        .padding()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        InitialView()
//    }
//}

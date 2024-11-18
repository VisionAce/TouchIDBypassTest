//
//  ContentView.swift
//  TouchID
//
//  Created by 褚宣德 on 2024/8/8.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var isUnclocked = false
    var body: some View {
        VStack {
            Button {
                isUnclocked = false
            } label: {
                HStack {
                    Text ("reset")
                    Image(systemName: "arrow.triangle.2.circlepath")
                }
            }.padding()
            
            if isUnclocked {
                Text("Unlocked")
               
            } else {
                Text("Locked")
                Button("解鎖") {
                    authenticate()
                }
                
            }
        }
       
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need you unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    isUnclocked = true
                    } else {
                    // no biometrics
                }
            }
        }
        
    }
    
    
}

#Preview {
    ContentView()
}

//
//  DoubleAuthenticate.swift
//  TouchID
//
//  Created by 褚宣德 on 2024/8/8.
//

import SwiftUI
import LocalAuthentication
import Security

struct SecAccessControlView: View {
    @State private var isUnlocked = false
    @State private var retrievedPassword: String?
    
    var body: some View {
        VStack {
            if isUnlocked {
                if let password = retrievedPassword {
                    Text("Unlocked: \(password)")
                } else {
                    Text("Unlocked, but no password retrieved.")
                }
            } else {
                Text("Locked")
                Button("Unlock") {
                    authenticateAndRetrievePassword()
                }
            }
        }
    }
    
    func authenticateAndRetrievePassword() {
        let context = LAContext()
        context.localizedReason = "Please, pass authorization to enter this area"
        var error: Unmanaged<CFError>?
        
        // 1. Create the AccessControl object that will represent authentication settings
        guard let accessControl = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                                  kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
                                                                  SecAccessControlCreateFlags.biometryCurrentSet,
                                                                  &error) else {
            // Failed to create AccessControl object
            print("Unable to create access control: \(error.debugDescription)")
            return
        }
        
        // 2. Create the keychain services query to save the password
        let saveQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrLabel as String: "com.me.myapp.password" as CFString,
            kSecAttrAccount as String: "OWASP Account" as CFString,
            kSecValueData as String: "test_strong_password".data(using: .utf8)! as CFData,
            kSecAttrAccessControl as String: accessControl
        ]
        
        // 3. Save the item to the keychain
        let saveStatus = SecItemAdd(saveQuery as CFDictionary, nil)
        
        if saveStatus == errSecSuccess {
            print("Successfully saved password.")
        } else {
            print("Error saving password: \(saveStatus)")
        }
        
        // 4. Now request the saved item from the keychain with biometric authentication
        var queryResult: AnyObject?
        let retrieveQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecAttrAccount as String: "OWASP Account" as CFString,
            kSecAttrLabel as String: "com.me.myapp.password" as CFString,
            kSecUseAuthenticationContext as String: context
        ]
        
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(retrieveQuery as CFDictionary, UnsafeMutablePointer($0))
        }
        
        if status == errSecSuccess {
            if let passwordData = queryResult as? Data {
                let retrievedPassword = String(data: passwordData, encoding: .utf8)
                print("Successfully retrieved password: \(retrievedPassword!)")
            }
        } else {
            print("Authorization not passed or item not found: \(status)")
        }
    }

}

#Preview {
    SecAccessControlView()
}

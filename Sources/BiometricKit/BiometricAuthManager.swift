//
//  BiometricAuthManager.swift
//  ImageSlider
//
//  Created by Noman belim on 10/12/25.
//
import LocalAuthentication
import SwiftUI
import Foundation
import LocalAuthentication


public class BiometricAuthManager: ObservableObject {
    @Published public var isUnlocked: Bool = false
    @Published public var errorMessage: String?

    
    public  func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        context.localizedFallbackTitle = ""
        context.localizedCancelTitle = "Cancel"
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Unlock using Face ID"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                        self.errorMessage = nil
                    } else {
                        self.isUnlocked = false
                        self.errorMessage = authError?.localizedDescription ?? "Face ID failed"
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.errorMessage = "Face ID not available"
                self.isUnlocked = false
            }
        }
    }
    
    // MARK: Auto-lock functions
    public  func appMovedToBackground() {
        print("🔒 App locked due to background")
        DispatchQueue.main.async {
            self.isUnlocked = false
            self.errorMessage = nil
        }
    }
    
    public func appBecameActive() {
        print("🔐 App became active, isUnlocked: \(isUnlocked)")
        // Always authenticate when app becomes active from background
        if !isUnlocked {
            print("🔓 Requesting Face ID authentication")
            authenticate()
        }
    }
}


public struct LockScreenView: View {
    
    @EnvironmentObject var biometricManager: BiometricAuthManager
    
    public var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "faceid")
                .font(.system(size: 70))
                .foregroundColor(.blue)
                .padding()
            
            Text("Unlock with Face ID")
                .font(.title3)
                .bold()
            
            if let error = biometricManager.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, 10)
            }
            
            Button(action: {
                biometricManager.authenticate()
            }) {
                Text("Try Again")
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            .padding(.top, 20)
            
            Spacer()
            
            Text("Your app is protected with Face ID")
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 20)
        }
        .padding()
    }
}



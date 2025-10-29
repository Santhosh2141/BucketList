//
//  FaceIDView.swift
//  BucketList
//
//  Created by Santhosh Srinivas on 29/10/25.
//

import SwiftUI
import LocalAuthentication

struct FaceIDView: View {
    
    @State private var isUnlocked = false
    
    var body: some View {
        VStack{
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
        // you need to enroll your simulator
        // have a backup plan like saving a pin which can be used if the faceID fails
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // if there is an error then change the NSError
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "We need to get your data"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ success, authenticationError in
                
                if success{
                    isUnlocked = true
                } else {
                    
                }
                
            }
        } else {
            // no biometrics
        }
    }
}

struct FaceIDView_Previews: PreviewProvider {
    static var previews: some View {
        FaceIDView()
    }
}

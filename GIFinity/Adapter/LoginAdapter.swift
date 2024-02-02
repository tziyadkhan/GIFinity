//
//  LoginAdapter.swift
//  GIFinity
//
//  Created by Ziyadkhan on 02.02.24.
//

import Foundation
import GoogleSignIn

class LoginAdapter {
    
    var controller: UIViewController
    var userCompletion: ((UserProfile) -> ())?
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    
    
    func login(loginType: LoginType) {
        switch loginType {
        case .google:
            googleLogin()
        case .facebook:
            facebookLogin()
        case .apple:
            appleLogin()
        }
    }
    
    fileprivate func googleLogin() {
        GIDSignIn.sharedInstance.signIn(withPresenting: controller) { result, error in
            if let error {
                print(error.localizedDescription)
            } else if let result {
                var fullname = "\(result.user.profile?.name ?? "") \(result.user.profile?.familyName ?? "")"
                var user = UserProfile(fullname: fullname ,
                                   email: result.user.profile?.email,
                                   password: "")
                self.userCompletion?(user)
            }
        }
    }
    
    fileprivate func facebookLogin() {
        
    }
    
    fileprivate func appleLogin() {
        
    }
}

enum LoginType {
    case google
    case facebook
    case apple
}

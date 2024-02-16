//
//  URLs.swift
//  GIFinity
//
//  Created by Ziyadkhan on 02.02.24.
//

import Foundation
import UIKit
import SafariServices

class URLs {
    
    func callURL(urlType: URLType) {
        switch urlType {
            
        case .termsOfService:
            termsOfService()
        case .privacyTerms:
            privacyTerms()
        case .googlePrivacyTerms:
            googlePrivacyTerms()
        case .gifinitySuppoty:
            gifinitySupport()
        }
    }
    
    func termsOfService() {
        if let url = URL(string: "https://support.giphy.com/hc/en-us/articles/360020027752-GIPHY-User-Terms-of-Service#:~:text=Please%20do%20not%20publicly%20post,in%20connection%20with%20its%20Services.") {
            let safariViewController = SFSafariViewController(url: url)
            UIApplication.shared.windows.first?.rootViewController?.present(safariViewController, animated: true, completion: nil)
        }
    }
    
    func privacyTerms() {
        if let url = URL(string: "https://support.giphy.com/hc/en-us/articles/360032872931") {
            let safariViewController = SFSafariViewController(url: url)
            UIApplication.shared.windows.first?.rootViewController?.present(safariViewController, animated: true, completion: nil)
        }
    }
    
    func googlePrivacyTerms() {
        if let url = URL(string: "https://policies.google.com/privacy?hl=en-US") {
            let safariViewController = SFSafariViewController(url: url)
            UIApplication.shared.windows.first?.rootViewController?.present(safariViewController, animated: true, completion: nil)
        }
    }
    
    func gifinitySupport() {
        if let url = URL(string: "https://support.giphy.com/hc/en-us") {
            let safariViewController = SFSafariViewController(url: url)
            UIApplication.shared.windows.first?.rootViewController?.present(safariViewController, animated: true, completion: nil)
        }
    }
}


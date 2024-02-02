//
//  URLs.swift
//  GIFinity
//
//  Created by Ziyadkhan on 02.02.24.
//

import Foundation
import UIKit

enum URLType {
    case termsOfService
    case privacyTerms
    case googlePrivacyTerms
}

class URLs {
    
    func callURL(urlType: URLType) {
        switch urlType {
            
        case .termsOfService:
            termsOfService()
        case .privacyTerms:
            privacyTerms()
        case .googlePrivacyTerms:
            googlePrivacyTerms()
        }
    }
    
    func termsOfService() {
        if let url = URL(string: "https://support.giphy.com/hc/en-us/articles/360020027752-GIPHY-User-Terms-of-Service#:~:text=Please%20do%20not%20publicly%20post,in%20connection%20with%20its%20Services.") {
            UIApplication.shared.open(url)
        }
    }
    
    func privacyTerms() {
        if let url = URL(string: "https://support.giphy.com/hc/en-us/articles/360032872931") {
            UIApplication.shared.open(url)
        }
    }
    
    func googlePrivacyTerms() {
        if let url = URL(string: "https://policies.google.com/privacy?hl=en-US") {
            UIApplication.shared.open(url)
        }
    }
}


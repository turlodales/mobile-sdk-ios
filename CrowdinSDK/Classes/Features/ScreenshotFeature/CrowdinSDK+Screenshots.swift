//
//  CrowdinSDK+ScreenshotFeature.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 6/1/19.
//

import Foundation

extension CrowdinSDK {
    @objc class func initializeScreenshotFeature() {
        guard let config = CrowdinSDK.config else { return }
        let crowdinProviderConfig = config.crowdinProviderConfig ?? CrowdinProviderConfig()
        if let crowdinScreenshotsConfig = config.crowdinScreenshotsConfig {
            ScreenshotFeature.shared = ScreenshotFeature(login: crowdinScreenshotsConfig.login, accountKey: crowdinScreenshotsConfig.accountKey, credentials: crowdinScreenshotsConfig.credentials, strings: crowdinProviderConfig.stringsFileNames, plurals: crowdinProviderConfig.pluralsFileNames, hash: crowdinProviderConfig.hashString, sourceLanguage: crowdinProviderConfig.sourceLanguage)
        }
    }
    
    public class func captureScreenshot(name: String, success: @escaping (() -> Void), errorHandler: @escaping ((Error?) -> Void)) {
        guard let screenshotFeature = ScreenshotFeature.shared else {
            errorHandler(NSError(domain: "Screenshots feature disabled", code: 9999, userInfo: nil))
            return
        }
        screenshotFeature.captureScreenshot(name: name, success: success, errorHandler: errorHandler)
    }
}

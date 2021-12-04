//
//  File.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 02.11.2021.
//

import Foundation
import CrowdinCore

public struct CustomLangugage {
    public let id: String
    public let locale: String
    public let twoLettersCode: String
    public let threeLettersCode: String
    public let localeWithUnderscore: String
    public let androidCode: String
    public let osxCode: String
    public let osxLocale: String
    
    public init(id: String, customLanguage: ManifestResponse.ManifestResponseCustomLangugage) {
        self.id = id
        self.locale = customLanguage.locale
        self.twoLettersCode = customLanguage.twoLettersCode
        self.threeLettersCode = customLanguage.threeLettersCode
        self.localeWithUnderscore = customLanguage.localeWithUnderscore
        self.androidCode = customLanguage.androidCode
        self.osxCode = customLanguage.osxCode
        self.osxLocale = customLanguage.osxLocale
    }
}

extension ManifestResponse {
    public var customLanguages: [CustomLangugage] {
        return responseCustomLanguages?.compactMap({ (key: String, value: ManifestResponseCustomLangugage) in
            CustomLangugage(id: key, customLanguage: value)
        }) ?? []
    }
}

extension CustomLangugage: CrowdinLanguage {
    public var name: String {
        return id
    }
}

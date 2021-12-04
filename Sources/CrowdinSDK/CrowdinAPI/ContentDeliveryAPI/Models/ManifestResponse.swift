//
//  ManifestResponse.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 03.11.2019.
//

import Foundation

public struct ManifestResponse: Codable {
    public let files: [String]
    public let timestamp: TimeInterval?
    public let languages: [String]?
    public let responseCustomLanguages: [String: ManifestResponseCustomLangugage]?    
    
    enum CodingKeys: String, CodingKey {
        case files
        case timestamp
        case languages
        case responseCustomLanguages = "custom_languages"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        files = try values.decode([String].self, forKey: .files)
        timestamp = try values.decodeIfPresent(TimeInterval.self, forKey: .timestamp)
        languages = try values.decodeIfPresent([String].self, forKey: .languages)
        if let customLanguages = try? values.decodeIfPresent([String : ManifestResponseCustomLangugage].self, forKey: .responseCustomLanguages) { // Do not throw error while encode custom_languages, as server can return empty array for manifests without language mappings.
            responseCustomLanguages = customLanguages
        } else {
            responseCustomLanguages = nil
        }
    }

    public init(files: [String], timestamp: TimeInterval, languages: [String]?, responseCustomLanguages: [String: ManifestResponseCustomLangugage]?) {
        self.files = files
        self.timestamp = timestamp
        self.languages = languages
        self.responseCustomLanguages = responseCustomLanguages
    }
    
    // MARK: - ManifestResponseCustomLangugage
    public struct ManifestResponseCustomLangugage: Codable {
        public let locale: String
        public let twoLettersCode: String
        public let threeLettersCode: String
        public let localeWithUnderscore: String
        public let androidCode: String
        public let osxCode: String
        public let osxLocale: String

        enum CodingKeys: String, CodingKey {
            case twoLettersCode = "two_letters_code"
            case threeLettersCode = "three_letters_code"
            case locale
            case localeWithUnderscore = "locale_with_underscore"
            case androidCode = "android_code"
            case osxCode = "osx_code"
            case osxLocale = "osx_locale"
        }
    }
}

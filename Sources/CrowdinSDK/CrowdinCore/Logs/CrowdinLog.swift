//
//  CrowidnLog.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 11.08.2020.
//

import UIKit

public enum CrowdinLogType: String {
    
    case info
    case error
    case warning
    case rest
}

extension CrowdinLogType {
    
    var color: UIColor {
        switch self {
        case .error:
            return .red
        case .info:
            return .blue
        case .warning:
            return .yellow
        case .rest:
            return .orange
        }
    }
}

public struct CrowdinLog {
    let date = Date()
    public let type: CrowdinLogType
    public let message: String
    public var attributedDetails: NSAttributedString? = nil
    
    public static func info(with message: String, attributedDetails: NSAttributedString? = nil) -> CrowdinLog {
        var log = CrowdinLog(type: .info, message: message)
        log.attributedDetails = attributedDetails
        
        return log
    }
    
    public static func error(with message: String, attributedDetails: NSAttributedString? = nil) -> CrowdinLog {
        var log = CrowdinLog(type: .error, message: message)
        log.attributedDetails = attributedDetails
        
        return log
    }
    
    public static func warning(with message: String, attributedDetails: NSAttributedString? = nil) -> CrowdinLog {
        var log = CrowdinLog(type: .warning, message: message)
        log.attributedDetails = attributedDetails
        
        return log
    }
    
    public static func rest(with message: String, attributedDetails: NSAttributedString? = nil) -> CrowdinLog {
        var log = CrowdinLog(type: .rest, message: message)
        log.attributedDetails = attributedDetails
        
        return log
    }
}

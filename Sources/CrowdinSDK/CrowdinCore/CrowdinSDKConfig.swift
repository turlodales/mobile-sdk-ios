//
//  CrowdinSDKConfig.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 4/9/19.
//

import Foundation

/// Class with all crowdin sdk information needed for initialization.
@objcMembers
public final class CrowdinSDKConfig: NSObject {
    /// Method for new config creation.
    ///
    /// - Returns: New CrowdinSDKConfig object instance.
    public static func config() -> CrowdinSDKConfig {
        return CrowdinSDKConfig()
    }
    
    var enterprise: Bool = false
	
    @discardableResult
	public func with(enterprise: Bool) -> Self {
		self.enterprise = enterprise
		return self
	}
}

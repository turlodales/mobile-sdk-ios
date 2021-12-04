//
//  CrowdinSDK+Login.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 8/16/19.
//

import Foundation
import CrowdinCore

extension CrowdinSDKConfig {
	private static var loginConfig: CrowdinLoginConfig?
	// Login
	var loginConfig: CrowdinLoginConfig? {
		get {
			return CrowdinSDKConfig.loginConfig
		}
		set {
			CrowdinSDKConfig.loginConfig = newValue
		}
	}
	
	public func with(loginConfig: CrowdinLoginConfig) -> Self {
		self.loginConfig = loginConfig
        with(enterprise: loginConfig.organizationName != nil)
		return self
	}
}

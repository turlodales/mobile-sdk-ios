//
//  ScreenshotFeature.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 1/26/19.
//

import UIKit

class ScreenshotFeature {
    static var shared: ScreenshotFeature?
	var screenshotUploader: ScreenshotUploader
	var screenshotProcessor: ScreenshotProcessor
	
	init(screenshotUploader: ScreenshotUploader, screenshotProcessor: ScreenshotProcessor) {
		self.screenshotUploader = screenshotUploader
		self.screenshotProcessor = screenshotProcessor
	}
	
    func captureScreenshot(name: String, success: @escaping (() -> Void), errorHandler: @escaping ((Error?) -> Void)) {
//        UIApplication.shared.cw_windows.forEach({
//            self.captureScreenshot(of: $0)
//        })
//        UIApplication.shared.cw_windows.forEach({
//            if let rootVC = $0.rootViewController {
//                self.captureScreenshot(of: rootVC.view)
//                rootVC.children.forEach({
//                    self.captureScreenshot(of: $0.view)
//                })
//                if let presentedVC = rootVC.presentedViewController {
//                    self.captureScreenshot(of: presentedVC.view)
//                }
//                if let parent = rootVC.parent {
//                    self.captureScreenshot(of: parent.view)
//                }
//            }
//        })
        guard let window = UIApplication.shared.cw_KeyWindow, let vc = window.topViewController() else {
			errorHandler(NSError(domain: "Unable to create screenshot.", code: defaultCrowdinErrorCode, userInfo: nil))
			return
		}
        self.captureScreenshot(view: vc.view, name: name, success: success, errorHandler: errorHandler)
    }
    
    func captureScreenshot(view: UIView, name: String, success: @escaping (() -> Void), errorHandler: @escaping ((Error?) -> Void)) {
        guard let screenshot = view.screenshot else {
            errorHandler(NSError(domain: "Unable to create screenshot.", code: defaultCrowdinErrorCode, userInfo: nil))
            return
        }
        let controlsInformation = ScreenshotInformationCollector.getControlsInformation(from: view, rootView: view)
        let screenshotVC = ScreenshotEditorVC()
        screenshotVC.loadViewIfNeeded()
        screenshotVC.set(screenshot: screenshot, controlsInfo: controlsInformation)
        screenshotVC.cw_present()
//        screenshotUploader.uploadScreenshot(screenshot: screenshot, controlsInformation: controlsInformation, name: name, success: success, errorHandler: errorHandler)
    }
    
    func captureScreenshot(of view: UIView) {
        let screenSquare = UIScreen.main.bounds.size.height * UIScreen.main.bounds.size.width
        let viewSquare = view.frame.size.height * view.frame.size.width
        if viewSquare >= 0.95 * screenSquare {
            if let image = view.screenshot {
                let file = UIImageFile(path: CrowdinFolder.shared.screenshotsFolder.path + "/(\(UUID().uuidString).png")
                file.file = image
                try? file.save()
                
                view.subviews.forEach({
                    self.captureScreenshot(of: $0)
                })
            }
        }
    }
}

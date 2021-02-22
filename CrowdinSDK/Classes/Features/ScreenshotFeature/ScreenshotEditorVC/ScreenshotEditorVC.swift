//
//  ScreenshotEditor.swift
//  CrowdinSDK
//
//  Created by Serhii Londar on 20.02.2021.
//

import UIKit

class LocalizedLabelView: UILabel {
    var deleteHandler: (() -> Void)? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let deleteButton = UIButton()
        deleteButton.setTitle("X", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.frame = CGRect(x: frame.width - 20, y: (frame.height - 50) / 2, width: 20, height: 50)
        deleteButton.addTarget(self, action: #selector(remove), for: .touchUpInside)
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.red.cgColor
        
        self.isUserInteractionEnabled = true
        
        self.addSubview(deleteButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func remove() {
        deleteHandler?()
    }
}

class ScreenshotEditorVC: UIViewController {
    var screenshotImage: UIImage? {
        didSet {
            imageView?.image = screenshotImage
        }
    }
    
    var controlsInfo: [ControlInformation] = [] {
        didSet {
            self.imageView?.subviews.forEach({
                $0.removeFromSuperview()
            })
            controlsInfo.forEach({ controlInfo in
                let label = LocalizedLabelView(frame: controlInfo.originalRect)
                label.text = controlInfo.key
                label.deleteHandler = { [self] in
                    if let index = controlsInfo.firstIndex(where: { $0 == controlInfo }) {
                        controlsInfo.remove(at: index)
                    }
                }
                self.imageView?.addSubview(label)
                label.isUserInteractionEnabled = true
            })
        }
    }
    
    var imageView: UIImageView? {
        didSet {
            imageView?.isUserInteractionEnabled = true
            imageView?.frame = self.view.bounds;
            if let imageView = imageView {
                view.addSubview(imageView)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView = UIImageView()
        self.setupTopView()
        self.setupTapGesture()
        self.perform(#selector(hideTopView), with: nil, afterDelay: 3)
    }
    
    var topView: UIView = UIView(frame: .zero)
    func setupTopView() {
        topView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        topView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 75)
        view.addSubview(topView)
        let closeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 75))
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        topView.addSubview(closeButton)
    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func hideTopView() {
        guard self.topView.frame.origin.y != -75 else { return }
        UIView.animate(withDuration: 0.3) {
            self.topView.frame.origin.y = -75
        }
    }
    
    @objc
    func showTopView() {
        guard self.topView.frame.origin.y != 0 else { return }
        UIView.animate(withDuration: 0.3) {
            self.topView.frame.origin.y = 0
        }
        self.perform(#selector(hideTopView), with: nil, afterDelay: 3)
    }
    
    @objc
    func tap() {
        self.showTopView()
    }
    
    func set(screenshot: UIImage, controlsInfo: [ControlInformation]) {
        self.screenshotImage = screenshot
        self.controlsInfo = controlsInfo
    }
    
    @objc
    func done() {
        self.cw_dismiss()
    }
    
    @objc
    func close() {
        self.cw_dismiss()
    }
}

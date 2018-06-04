//
//  MBProgressHUD.swift
//  ToastKit
//
//  Created by ZhiHua Shen on 2018/6/4.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

import Foundation

public enum ToastStatus {
    case success,error,info,none
}

public protocol Toastable {}

public extension Toastable where Self: UIResponder {
    
    private var toView: UIView {
        if self is UIViewController {
            let vc = self as! UIViewController
            return vc.view
        }
        else if self is UIView {
            return self as! UIView
        }
        else {
            return UIApplication.shared.keyWindow!
        }
    }
    
    private var hudView: MBProgressHUD {
        let tag = 9527
        let view = (toView.viewWithTag(tag) as? MBProgressHUD) ?? MBProgressHUD.showAdded(to: toView, animated: true)
        view.tag = tag
        /// 全局样式
        view.bezelView.alpha = 0.8
        view.bezelView.color = UIColor.black
        view.label.textColor = UIColor.white
        view.contentColor = UIColor.white
        return view
    }
    
    
    /// More status shows MBProgressHUD, which is hidden by default two seconds later
    ///
    /// - Parameters:
    ///   - status: Enumeration instance of ToastStatus
    ///   - text: Describe the text
    /// - Returns: Return MBProgressHUD, and you can set callbacks when they are completely hidden
    @discardableResult
    func showToast(_ text: String, status: ToastStatus = .none) -> MBProgressHUD {
        return showToast(text, status: status, hideAfter: 2)
    }
    
    
    /// More status shows MBProgressHUD
    ///
    /// - Parameters:
    ///   - status: Enumeration instance of ToastStatus
    ///   - text: Describe the text
    ///   - delay: MBProgressHUD is automatically hidden from the timer
    /// - Returns: Return MBProgressHUD, and you can set callbacks when they are completely hidden
    @discardableResult
    func showToast(_ text: String, status: ToastStatus, hideAfter delay: TimeInterval) -> MBProgressHUD {
        
        clearSettingStyle()
        
        let bundle = Bundle.init(for: MBProgressHUD.self)
        var imagePath: String?
        
        switch status {
        case .success:
            imagePath = bundle.path(forResource: "tips_done@2x.png", ofType: nil)
        case .info:
            imagePath = bundle.path(forResource: "tips_info@2x.png", ofType: nil)
        case .error:
            imagePath = bundle.path(forResource: "tips_error@2x.png", ofType: nil)
        case .none:
            break
        }
        
        if let imagePath = imagePath {
            let image = UIImage(contentsOfFile: imagePath)
            let imageView: UIImageView = UIImageView(image: image)
            imageView.sizeToFit()
            
            hudView.mode = .customView
            hudView.customView = imageView
        }
        else {
            hudView.mode = .text
        }
        
        hudView.detailsLabel.text = text
        hudView.detailsLabel.font = UIFont.systemFont(ofSize: 15)
        hudView.margin = 15
        
        hudView.hide(animated: true, afterDelay: delay)
        
        return hudView
    }
    
    
    /// Display MBProgressHUD based on progress
    ///
    /// - Parameters:
    ///   - progress: The current progress
    ///   - text: Describe the text
    /// - Returns: Return MBProgressHUD, and you can set callbacks when they are completely hidden
    @discardableResult
    func showProgress(_ progress: Float,text: String) -> MBProgressHUD {
        
        clearSettingStyle()
        
        hudView.mode = .annularDeterminate
        hudView.label.text = text
        hudView.progress = progress
        
        return hudView
    }

    
    /// Hide the currently added MBProgressHUD
    ///
    /// - Parameters:
    ///   - animated: Whether to display animation when hiding
    ///   - delay: MBProgressHUD is automatically hidden from the timer
    /// - Returns: Return MBProgressHUD, and you can set callbacks when they are completely hidden
    @discardableResult
    func hideToast(_ animated: Bool = true, afterDelay delay: TimeInterval = 0) -> MBProgressHUD {
        hudView.hide(animated: animated, afterDelay: delay)
        return hudView
    }
    
    /// 恢复默认样式
    private func clearSettingStyle() {
        hudView.margin = 20
        hudView.offset = .zero
        hudView.label.font = UIFont.boldSystemFont(ofSize: 16.0)
        hudView.detailsLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
    }
}

extension UIResponder: Toastable {}

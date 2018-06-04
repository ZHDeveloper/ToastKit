//
//  ViewController.swift
//  ToastKitDemo
//
//  Created by ZhiHua Shen on 2018/6/4.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

import UIKit
import ToastKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            showToast("Status bar could not find cached time string image.")
        case 1:
            showToast("登录成功", status: .success)
        case 2:
            showToast("Status bar could not find cached time string image.", status: .error)
        case 3:
            showToast("Status bar could not find cached time string image.", status: .info)
        case 4:

            let toast = showProgress(0.0, text: "正在上传")
            var progress:Float = 0.0

            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                progress = progress + 0.05
                toast.progress = progress
                if progress >= 1.0 {
                    timer.invalidate()
                    self.hideToast()
                }
            }
            
            toast.completionBlock = {
                print("Toast did dismiss!!!")
            }
            
        default:
            break
        }
        
    }
}


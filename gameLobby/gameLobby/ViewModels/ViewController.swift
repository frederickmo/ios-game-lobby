//
//  ViewController.swift
//  gameLobby
//
//  Created by Frederick Mo on 2022/5/24.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    @IBAction func didTapGoToAnotherApp(appPath: String) {
        
        let application = UIApplication.shared
        
//        let anotherAppPath = "example://"
        
        let appUrl = URL(string: appPath)!
        
        let websiteUrl = URL(string: "https://github.com/")!
        
        if application.canOpenURL(appUrl) {
            application.open(appUrl, options: [:], completionHandler: nil)
        } else {
            application.open(websiteUrl)
        }
    }
}

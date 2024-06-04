//
//  SplashVC.swift
//  PureGo
//
//  Created by admin on 6/4/24.
//

import UIKit

class SplashVC: UIViewController {

    //MARK: - Instance Variable
    var timerObj : Timer? = nil
    
    
    
    //MARK: - IBOutlet
    @IBOutlet weak var imgAppLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
    //MARK: - View Controller's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTheme()
        setupTimer()
    }
    
    //MARK: - IBActions
    
    
    //MARK: - Helper
    private func setupTheme() {
        self.view.backgroundColor = ThemeManager.sharedInstance.backgroundColor
        self.lblTitle.textColor = ThemeManager.sharedInstance.textColor
        self.lblTitle.text = "PureGo"
    }
    
    fileprivate func setupTimer() {
        timerObj = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(handleRootView), userInfo: nil, repeats: true)
    }
    
    @objc private func handleRootView() {
        
    }


    
}

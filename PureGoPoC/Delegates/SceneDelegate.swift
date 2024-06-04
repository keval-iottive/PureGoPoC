//
//  SceneDelegate.swift
//  PureGo
//
//  Created by admin on 6/4/24.
//

import UIKit
import CoreBluetooth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            if let splashVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SplashVC") as? SplashVC {
                window.rootViewController = splashVC
                self.window = window
                window.makeKeyAndVisible()

            }
        }

    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        if appDelegate_.centralManagerActor.centralManager?.state == CBManagerState.unauthorized {
            openAppOrSystemSettingsAlert(title: "app wants to turn ON your Bluetooth", message: "Please select ALLOW in Settings to grant bluetooth access")
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}


//
//  AppDelegateUtils.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//

import UIKit


final class AppDelegateUtils {
    
    
    static func getApp() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    @available(iOS 13.0, *)
    static func getScene() -> SceneDelegate? {
        return UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    }
    
    
    static func getWindow() -> UIWindow? {
        var window : UIWindow!
        
        if #available(iOS 13.0, *) {
            window = getScene()?.window
        } else {
            // Fallback on earlier versions
            window = getApp()?.window
        }
        
        return window
    }
    
    
    static func routeToMain() {
        guard let window = getWindow() else { return }
        window.rootViewController = UINavigationController.init(rootViewController: getApp()!.container.resolve(MainPage.self)!)
        window.makeKey()
    }
    
}

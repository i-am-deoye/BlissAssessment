//
//  UIViewController+Navigator.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//

import UIKit
import Swinject




extension UIViewController {
    
    func push<Service>(_ page: Service.Type, controller: UIViewController) {
        let container = AppDelegateUtils.getApp()?.container
        
        guard let resolvedController = container?.resolve(page) as? UIViewController else { return }
        controller.navigationController?.pushViewController(resolvedController, animated: true)
    }
    
}

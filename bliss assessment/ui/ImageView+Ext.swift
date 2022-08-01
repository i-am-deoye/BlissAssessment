//
//  ImageView+Ext.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//

import UIKit
import SDWebImage


extension UIImageView {
    
    func set(_ url: String) {
        self.sd_setImage(with: URL.init(string: url), completed: nil)
    }
}

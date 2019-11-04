//
//  UIImageView+Loader.swift
//  UsersInfo
//
//  Created by Narine Balasanyan on 11/2/19.
//  Copyright © 2019 Fifth. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func image(withURL url: String) {
        self.kf.setImage(with: URL(string: url))
    }
}

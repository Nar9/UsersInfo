//
//  UserTableViewCell.swift
//  UsersInfo
//
//  Created by Narine Balasanyan on 11/2/19.
//  Copyright © 2019 Fifth. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: CircleImageView!
    @IBOutlet weak var emailLabel: UILabel!
    
    var userData: User? {
        didSet {
            updateCellUI()
        }
    }
    
    // MARK: - Methods
    
    private func updateCellUI() {
        avatarImageView.image = nil
        emailLabel.text = nil
        
        guard let userData = userData else {
            print("Can't get user data")
            return
        }
        
        avatarImageView.image(withURL: userData.avatarUrl)
        emailLabel.text = userData.email
    }
}

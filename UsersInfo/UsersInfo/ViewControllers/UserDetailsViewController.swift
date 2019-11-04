//
//  UserDetailsViewController.swift
//  UsersInfo
//
//  Created by Narine Balasanyan on 11/2/19.
//  Copyright © 2019 Fifth. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    // MARK: - Interface builder outlets
    
    @IBOutlet weak var avatarImageView: CircleImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: - Properties
    
    var userData: User?
    
    // MARK: - View initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods
    
    func setupUI() {
        guard let userData = userData else {
            showAlert(withMessage: "", andTitle: ErrorMessages.defaultErrorTitle)
            return
        }
        avatarImageView.image(withURL: userData.avatarUrl)
        nameLabel.text = "\(userData.firstName) \(userData.lastName)"
        emailLabel.text = userData.email
    }
}

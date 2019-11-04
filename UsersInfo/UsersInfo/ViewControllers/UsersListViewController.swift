//
//  UsersListViewController.swift
//  UsersInfo
//
//  Created by Narine Balasanyan on 11/2/19.
//  Copyright © 2019 Fifth. All rights reserved.
//

import UIKit
import MBProgressHUD

class UsersListViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var usersList: UsersList?
    private var usersData = [User]()
    private let persistenceService = PersistenceService.shared
    private var currentPage: Int16 = 1
    private var shouldShowIndicatorCell = false
    
    // MARK: - View initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchSavedData()
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        self.title = "Users"
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = Constants.userCellHeight
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func fetchSavedData() {
        persistenceService.fetchUsersList { [weak self] savedData in
            guard let weakSelf = self else { return }
            if let savedData = savedData {
                let currentPageData = savedData.filter { $0.page == weakSelf.currentPage }.first
                if let currentPageData = currentPageData {
                    weakSelf.usersList = currentPageData
                    weakSelf.usersData = currentPageData.userData
                    DispatchQueue.main.async {
                        weakSelf.tableView.reloadData()
                    }
                }
            }
            DispatchQueue.main.async {
                MBProgressHUD.showAdded(to: weakSelf.view, animated: true)
            }
            weakSelf.getUsersList(deleteSavedData: true)
        }
    }
    
    private func getUsersList(deleteSavedData: Bool = false) {
        if deleteSavedData {
            persistenceService.deleteData()
        }
        guard usersList == nil || usersList?.page != usersList?.totalPages else {
            return
        }
        ApiManager().getUsersList(page: currentPage) { (isSuccess, usersList, errorMessage) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            
            if isSuccess, let usersList = usersList {
                if deleteSavedData {
                    self.usersData = usersList.userData
                } else {
                    self.usersData += usersList.userData
                }
                self.usersList = usersList
                self.persistenceService.saveContext(withData: usersList)
                self.shouldShowIndicatorCell = usersList.page < usersList.totalPages
                self.tableView.reloadData()
            } else {
                self.showAlert(withMessage: "", andTitle: errorMessage!)
            }
        }
    }
    
    private func getUsersNextPage() {
        currentPage += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.getUsersList()
        }
    }
    
    private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard shouldShowIndicatorCell else { return false }
        return indexPath.row == usersData.count
    }
    
    // MARK: - UITableViewDataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = usersData.count
        return shouldShowIndicatorCell ? count + 1 : count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingIndexPath(indexPath) {
            guard let indicatorCell = tableView.dequeueReusableCell(withIdentifier: TableCellIds.indicatorCell, for: indexPath) as? IndicatorTableViewCell else {
                return UITableViewCell()
            }
            return indicatorCell
        } else {
            guard let userCell = tableView.dequeueReusableCell(withIdentifier: TableCellIds.userCell, for: indexPath) as? UserTableViewCell else {
                return UITableViewCell()
            }
            userCell.userData = usersData[indexPath.row]
            return userCell
        }
    }
    
    // MARK: - UITableViewDelegate methods
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isLoadingIndexPath(indexPath) else { return }
        getUsersNextPage()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let userDetailsVC = UIStoryboard.loadUserDetailsViewController()
        userDetailsVC.userData = usersData[indexPath.row]
        show(userDetailsVC, sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.userCellHeight
    }
}

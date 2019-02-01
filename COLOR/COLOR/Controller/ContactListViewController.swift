//
//  ViewController.swift
//  COLOR
//
//  Created by Arvind Prem on 01/02/19.
//  Copyright © 2019 Arvind. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController, UISearchResultsUpdating {
    
    @IBOutlet weak var contactsTableView: UITableView?
    
    var fetchedContacts: Contacts = Contacts()
    var searchResults: [BasicInfo] = []
    weak var activityIndicatorView: UIActivityIndicatorView!
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupView()
    }
    
    func setupView(){
        self.title = "Contacts"
        
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        
        // Place the search bar in the navigation item's title view.
        self.navigationItem.titleView = searchController.searchBar
        searchController.searchBar.placeholder = "Search Contacts"
        // Don't hide the navigation bar because the search bar is in it.
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        contactsTableView?.backgroundView = activityIndicatorView
        self.activityIndicatorView = activityIndicatorView
        activityIndicatorView.startAnimating()
        
        if Reachability.isConnectedToNetwork(){
            fetchContacts()
        } else {
            let alert = UIAlertController(title: "Alert", message: "No network available", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func fetchContacts(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        guard let url = URL(string: ColorConstants.contactsUrl) else { return }
        SessionHandler.shared.fetchFromApi(url: url) { (contacts: Contacts) in
            self.fetchedContacts = contacts
            DispatchQueue.main.async {
                 self.contactsTableView?.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            //filter the contacts when user enters 3 or more characters
            if searchText.count > 2 {
                searchResults = self.fetchedContacts.results.filter {$0.name!.first!.lowercased().contains(searchText.lowercased()) || $0.name!.last!.lowercased().contains(searchText.lowercased())}
            } else {
                searchResults = self.fetchedContacts.results
            }
             self.contactsTableView?.reloadData()
        }
        
    }

}

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  searchController.isActive ? searchResults.count : fetchedContacts.results.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ColorConstants.contactListCellIdentifier, for: indexPath) as! ContactListCell
        if searchController.isActive  {
            cell.configureCell(basicInfo: searchResults[indexPath.row] )
        } else {
            cell.configureCell(basicInfo: fetchedContacts.results[indexPath.row] )
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let storyBoard = Utilities.shared.getStoryBoard() {
            if let detailedViewController = storyBoard.instantiateViewController(withIdentifier: ColorConstants.detailedVC) as? DetailedViewController {
                if searchController.isActive  {
                    detailedViewController.contactInfo = searchResults[indexPath.row]
                } else {
                    detailedViewController.contactInfo = fetchedContacts.results[indexPath.row]
                }
                self.navigationController?.pushViewController(detailedViewController, animated: true)
            }
        }
    }
}


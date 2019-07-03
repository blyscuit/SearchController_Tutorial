//
//  ViewController.swift
//  SearchTT
//
//  Created by Pisit W on 28/6/2562 BE.
//  Copyright © 2562 confusians. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    /// Search controller to help us with filtering.
    private var searchController: UISearchController!
    
    /// Secondary search results table view.
    private var resultsTableController: SearchTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsTableController = SearchTableViewController()
        
        resultsTableController.tableView.delegate = self
        
        
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        
        // replace searchBar with searchController's searchbar
        searchBar.addSubview(searchController.searchBar)
        
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false // The default is true.
        searchController.searchBar.delegate = self // Monitor when the search button is tapped.
        
        // set true to make searchbar moves to navigatoion
        searchController.hidesNavigationBarDuringPresentation = false
        
        /** Search presents a view controller by applying normal view controller presentation semantics.
         This means that the presentation moves up the view controller hierarchy until it finds the root
         view controller or one that defines a presentation context.
         */
        
        /** Specify that this view controller determines how the search controller is presented.
         The search controller should be presented modally and match the physical size of this view controller.
         */
        definesPresentationContext = true
        
    }


}


// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedString: String
        
        // Check to see which table view cell was selected.
        if tableView === resultsTableController.tableView {
            selectedString = resultsTableController.filterData[indexPath.row]
        } else {
            selectedString = ""
        }
        
        print(selectedString)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

// MARK: - UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}

// MARK: - UISearchControllerDelegate

// Use these delegate functions for additional control over the search controller.

extension ViewController: UISearchControllerDelegate {
    
    func presentSearchController(_ searchController: UISearchController) {
        // to move table under searchbar
        resultsTableController.view.frame = CGRect(x: 0, y: searchBar.frame.maxY, width: self.view.frame.width, height: self.view.frame.height - searchBar.frame.maxY)
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        // to move content to correct location
        resultsTableController.tableView.contentInset = UIEdgeInsets(top: searchBar.frame.size.height, left: 0, bottom: 0, right: 0)
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
}

// MARK: - UISearchResultsUpdating

extension ViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        // Update the filtered array based on the search text.
        let searchResults = ["abcde","cdefg","efghi","ghijk"]
        
        // Strip out all the leading and trailing spaces.
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString =
            searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
        
        let filteredResults = searchResults.filter { $0.contains(strippedString) }
        
        // Apply the filtered results to the search results table.
        if let resultsController = searchController.searchResultsController as? SearchTableViewController {
            resultsController.filterData = filteredResults
            resultsController.tableView.reloadData()
        }
    }
    
}

//
//  SearchTableViewController.swift
//  SearchTT
//
//  Created by Pisit W on 28/6/2562 BE.
//  Copyright © 2562 confusians. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {

    var filterData: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = filterData[indexPath.row]
        return cell
    }
    
}

//
//  FavoritesViewController.swift
//  Persistence using NSKeyedArchiver - Exercise
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchTerm = "" {
        didSet {
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        DataModel.shared.load()
        print(DataModel.shared.getLists())
    }
}

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 175
        let cell = tableView.dequeueReusableCell(withIdentifier: "Favorites Cell", for: indexPath)
        let favorite = DataModel.shared.getLists()[indexPath.row]
        cell.textLabel?.text = favorite.title
        let imageUrl = favorite.previewURL!
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.imageView?.image = onlineImage
            cell.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: imageUrl,
                                        completionHander: completion,
                                        errorHander: {print($0)})
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.shared.getLists().count
    }
}

extension FavoritesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTerm = searchBar.text ?? ""
    }
}

//
//  ViewController.swift
//  Persistence using NSKeyedArchiver - Exercise
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pixabay = [Hits]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchTerm = "" {
        didSet {
            loadPictures(named: searchTerm.lowercased())
        }
    }

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadPictures(named str: String) {
        let setPictures = {(onlinePictures: [Hits]) in
            self.pixabay = onlinePictures
        }
        let printErrors = {(error: Error) in
            print(error)
        }
        PixabayAPIClient.manager.getPicture(from: str,
                                            completionHandler: setPictures,
                                            errorHandler: printErrors)
        print(pixabay)
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let picture = pixabay[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Image Cell", for: indexPath)
        tableView.rowHeight = 100
        cell.textLabel?.text = picture.tags
        
        guard let imageUrlStr = picture.previewURL else {
            cell.imageView?.image = nil
            return cell
        }
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.imageView?.image = onlineImage
            cell.setNeedsLayout()
        }
        ImageAPIClient.manager.getImage(from: imageUrlStr,
                                        completionHander: completion,
                                        errorHander: {print($0)})
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pixabay.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PictureDetailViewController {
            destination.pictureDetail = pixabay[tableView.indexPathForSelectedRow!.row]
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTerm = searchBar.text ?? ""
    }
}













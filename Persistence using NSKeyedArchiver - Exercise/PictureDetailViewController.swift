//
//  PictureDetailViewController.swift
//  Persistence using NSKeyedArchiver - Exercise
//
//  Created by C4Q on 12/12/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class PictureDetailViewController: UIViewController {
    
    var pictureDetail: Hits!
    var favoriteItemToBeEdited: Favorites!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favoritesTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
    }
    
    private func getImage() {
        guard let imageUrl = pictureDetail.webformatURL else {
            imageView.image = nil
            return
        }
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            self.imageView.image = onlineImage
        }
        ImageAPIClient.manager.getImage(from: imageUrl,
                                        completionHander: completion,
                                        errorHander: {print($0)})
    }
    
    @IBAction func addToFavoritesPressed(_ sender: UIButton) {
        guard let favoritesTitle = favoritesTextField.text else { return }
        if favoritesTitle.isEmpty {
            showAlert()
        } else {
            let newFavoriteItem = Favorites.init(title: favoritesTitle, tags: pictureDetail.tags, previewURL: pictureDetail.previewURL, webformatURL: pictureDetail.webformatURL)
            if let _ = favoriteItemToBeEdited {
                favoriteItemToBeEdited.title = favoritesTitle
                favoriteItemToBeEdited.webformatURL = pictureDetail.webformatURL ?? "N/A"
                favoriteItemToBeEdited.previewURL = pictureDetail.previewURL ?? "N/A"
                DataModel.shared.updateFavoriteItem(withUpdatedItem: favoriteItemToBeEdited)
            } else {
                DataModel.shared.addFavoriteItemToList(newItem: newFavoriteItem)
            }
        }
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Missing Fields", message: "A title and description for the DSA item is required", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}


















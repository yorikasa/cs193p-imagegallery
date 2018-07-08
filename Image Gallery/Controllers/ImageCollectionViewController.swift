//
//  ImageCollectionViewController.swift
//  Image Gallery
//
//  Created by Yuki Orikasa on 2018/07/08.
//  Copyright © 2018 Yuki Orikasa. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Image Cell"

class ImageCollectionViewController: UICollectionViewController {
    
    var collection: [ImageItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // The code below don't have to be here when prototype cell was created in the storyboard!
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        collection.append(ImageItem.init())
        collection.append(ImageItem.init())
        
        collectionView?.addInteraction(UIDropInteraction(delegate: self))
    }
}

// MARK: - DataSource & Delegate & DelegateFlowLayout
extension ImageCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return collection.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let imageCell = cell as? ImageCollectionViewCell {
            imageCell.imageView.image = UIImage.init(named: collection[indexPath.item].urlString)
            return imageCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = 100
        let cellHeight: CGFloat = CGFloat(collection[indexPath.item].aspectRatio) * cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}


// MARK: - Drag & Drop Interaction (UIDropInteractionDelegate)
extension ImageCollectionViewController: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) &&
            session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction,
                         sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: UIImage.self) { (images) in
            if let image = images.first as? UIImage {
                DispatchQueue.main.async {
                    //
                }
            }
        }
        session.loadObjects(ofClass: NSURL.self) { (urls) in
            if let url = urls.first as? URL {
                print(url)
            }
        }
    }
}

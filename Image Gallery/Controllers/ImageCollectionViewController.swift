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
    
    var collection: [ImageItem] = [] {
        didSet {
            gallery?.collection = collection
        }
    }
    var gallery: Gallery? {
        didSet {
            collection = gallery!.collection
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // The code below don't have to be here when prototype cell was created in the storyboard!
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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
            DispatchQueue.global(qos: .userInitiated).async {
                let fetchedImage = self.fetchImage(url: self.collection[indexPath.row].url)
                DispatchQueue.main.async {
                    imageCell.imageView.image = fetchedImage
                }
            }
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
    
    private func fetchImage(url: URL) -> UIImage? {
        let data = try? Data(contentsOf: url)
        if let image = data {
            return UIImage(data: image)
        } else {
            return nil
        }
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
        collection.append(ImageItem.init())
        let itemIndex = collection.count - 1
        
        session.loadObjects(ofClass: UIImage.self) { (images) in
            if let image = images.first as? UIImage {
                self.collection[itemIndex].imageSize = image.size
                self.collectionView?.reloadData()
            }
        }
        session.loadObjects(ofClass: NSURL.self) { (urls) in
            if let url = urls.first as? URL {
                self.collection[itemIndex].url = url
                self.collectionView?.reloadData()
            }
        }
    }
}

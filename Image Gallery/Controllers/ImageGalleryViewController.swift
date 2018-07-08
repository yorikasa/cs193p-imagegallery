//
//  ImageGalleryViewController.swift
//  Image Gallery
//
//  Created by Yuki Orikasa on 2018/06/18.
//  Copyright © 2018 Yuki Orikasa. All rights reserved.
//

import UIKit

class ImageGalleryViewController: UIViewController, UIDropInteractionDelegate {
    
    var galleries: [Gallery] = []
    var deletedGalleries: [Gallery] {
        return galleries.filter {$0.status == Gallery.Status.deleted}
    }
    
    var collection: [ImageItem] = []

    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var previewView: PreviewView!
    @IBOutlet weak var dropZoneView: UIView! {
        didSet {
            dropZoneView.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collection.append(ImageItem.init())
        collection.append(ImageItem.init())
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Drag & Drop Interaction (UIDropInteractionDelegate)
extension ImageGalleryViewController {
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
                    self.previewView.backgroundImage = image
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

// MARK: - Collection View Data Source & Delegate & DelegateFlowLayout
extension ImageGalleryViewController: UICollectionViewDataSource,
                                      UICollectionViewDelegate,
                                      UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Image Cell", for: indexPath)
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

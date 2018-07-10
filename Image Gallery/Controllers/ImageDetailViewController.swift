//
//  ImageDetailViewController.swift
//  Image Gallery
//
//  Created by Yuki Orikasa on 2018/07/10.
//  Copyright © 2018 Yuki Orikasa. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {

    @IBOutlet weak var bigImage: UIImageView!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    var imageURL: URL? {
        didSet {
            DispatchQueue.global(qos: .userInitiated).async {
                let image = self.fetchImage(url: self.imageURL!)
                DispatchQueue.main.async {
                    self.bigImage.image = image
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // copied from ImageColletionViewController...
    private func fetchImage(url: URL) -> UIImage? {
        let data = try? Data(contentsOf: url)
        if let image = data {
            return UIImage(data: image)
        } else {
            return nil
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

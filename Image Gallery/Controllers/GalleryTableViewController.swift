//
//  GalleryTableViewController.swift
//  Image Gallery
//
//  Created by Yuki Orikasa on 2018/07/04.
//  Copyright © 2018 Yuki Orikasa. All rights reserved.
//

import UIKit

class GalleryTableViewController: UITableViewController {
    
    var galleries: [Gallery] = []
    var deletedGalleries: [Gallery] {
        return galleries.filter {$0.status == Gallery.Status.deleted}
    }
    private var editingRowIndex: Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        galleries.append(Gallery.init(name: "One"))
        galleries.append(Gallery.init(name: "Two"))
        galleries.append(Gallery.init(name: "Three"))
        
        registerGestures()
    }
    
    @IBAction func addGalleryRow(_ sender: UIBarButtonItem) {
        galleries.append(Gallery.init(name: "New Gallery"))
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return galleries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if editingRowIndex == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Editable Cell",
                                                     for: indexPath) as! EditableTableViewCell
            cell.textField.text = galleries[indexPath.row].name
            cell.resignationHandler = { [weak self, unowned cell] in
                if let name = cell.textField.text {
                    self?.galleries[indexPath.row].name = name
                }
                self?.editingRowIndex = nil
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Simple Cell", for: indexPath)
            cell.textLabel?.text = galleries[indexPath.row].name
            return cell
        }
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            galleries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        if let editingCell = cell as? EditableTableViewCell {
            editingCell.textField.becomeFirstResponder()
        }
    }
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Show Collection" {
            if let vc = (segue.destination as? UINavigationController)?.viewControllers.last as? ImageCollectionViewController,
                let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) {
                vc.gallery = galleries[indexPath.row]
            }
        }
    }
}

// Add Gestures
extension GalleryTableViewController {
    @objc private func renameGallery(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            let location = sender.location(in: sender.view)
            
            if let index = tableView.indexPathForRow(at: location){
                //print(tappedTableView.cellForRow(at: index))
                // tableView.reloadRows(at: [index], with: .automatic)
                editingRowIndex = index.row
                tableView.reloadData()
            }
        default:
            break
        }
    }
    private func registerGestures() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(renameGallery(_:)))
        doubleTap.numberOfTapsRequired = 2
        tableView?.addGestureRecognizer(doubleTap)
    }

}

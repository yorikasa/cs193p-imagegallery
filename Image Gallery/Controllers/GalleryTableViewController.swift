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
    var activeGalleries: [Gallery] {
        return galleries.filter {$0.status == Gallery.Status.active}
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
        if deletedGalleries.count > 0 {
            return 2
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return galleries.filter {$0.status == Gallery.Status.active}.count
        } else {
            return galleries.filter {$0.status == Gallery.Status.deleted}.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "Recently Deleted"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if editingRowIndex == indexPath.row {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Editable Cell",
                                                         for: indexPath) as! EditableTableViewCell
                cell.textField.text = activeGalleries[indexPath.row].name
                cell.resignationHandler = { [weak self, unowned cell] in
                    if let name = cell.textField.text {
                        self?.activeGalleries[indexPath.row].name = name
                    }
                    self?.editingRowIndex = nil
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Simple Cell", for: indexPath)
                cell.textLabel?.text = activeGalleries[indexPath.row].name
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Simple Cell", for: indexPath)
            cell.textLabel?.text = deletedGalleries[indexPath.row].name
            return cell
        }
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source

            // TODO: can delete deleted row
            // you should filter which row to delete by indexPath.section
            if indexPath.section == 0 {
                activeGalleries[indexPath.row].status = Gallery.Status.deleted
            } else {
                let aCell = deletedGalleries[indexPath.row]
                if let index = galleries.index(of: aCell) {
                    galleries.remove(at: index)
                }
            }
            tableView.reloadData()
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

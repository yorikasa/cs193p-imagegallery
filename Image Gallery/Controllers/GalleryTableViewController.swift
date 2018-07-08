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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        galleries.append(Gallery.init(name: "One"))
        galleries.append(Gallery.init(name: "Two"))
        galleries.append(Gallery.init(name: "Three"))
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Simple Cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = galleries[indexPath.row].name

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Show Collection" {
            if let vc = segue.destination as? ImageCollectionViewController,
                let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) {
                vc.gallery = galleries[indexPath.row]
            }
        }
    }

}

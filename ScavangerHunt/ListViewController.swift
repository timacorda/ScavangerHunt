//
//  ListViewController.swift
//  ScavangerHunt
//
//  Created by Timothy Acorda on 1/24/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var scavengerHuntItems = [ScavengerHuntItem(name: "Bird") ,
                                                 ScavengerHuntItem(name:"Goat") ,
                                                 ScavengerHuntItem(name: "Horse")]
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let indexPath = tableView.indexPathForSelectedRow() {
            let photo = info[UIImagePickerControllerOriginalImage] as UIImage
            let selectedItem = scavengerHuntItems[indexPath.row]
            selectedItem.photo = photo
            dismissViewControllerAnimated(true, completion: {
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                })
        }
    }
    
    
    
    override func tableView(taleView: UITableView, numberOfRowsInSection section: Int) ->Int {
        return scavengerHuntItems.count;
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath) as UITableViewCell
        
        let item = scavengerHuntItems[indexPath.row]
        cell.textLabel!.text = item.name
        if item.isComplete {
            cell.imageView!.image = item.photo
            cell.accessoryType = .Checkmark
        } else {
            cell.imageView!.image = nil
            cell.accessoryType = .None
        }
        return cell
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        if segue.identifier == "DoneItem" {
            let addItemController = segue.sourceViewController as AddViewController
            if let newItem = addItemController.newItem {
                scavengerHuntItems += [newItem]
                let indexPath = NSIndexPath(forRow: scavengerHuntItems.count-1 , inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
    
}

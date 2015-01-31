//
//  ListViewController.swift
//  ScavangerHunt
//
//  Created by Timothy Acorda on 1/24/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

import UIKit
import CoreLocation


class ListViewController: UITableViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    var itemsManager = ItemsManager()
    var locationer = CLLocationManager()
    
    override func viewDidLoad() {
        println("LOADS")
        locationer.delegate = self
        locationer.desiredAccuracy = kCLLocationAccuracyBest
        locationer.startUpdatingLocation()
        
    }
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
            let selectedItem = itemsManager.items[indexPath.row]
            selectedItem.photo = photo
            dismissViewControllerAnimated(true, completion: {
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                })
            itemsManager.save()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!, selectedpath: NSIndexPath) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            println("entered locationManager")
            if let _error = error {
                println(" ERROR")
                return
            }
            if placemarks.count > 0 {
                println("ENTERED HERE")
                let placemark1 = placemarks[0] as CLPlacemark
                self.displayInfo(placemark1, path: selectedpath)
            } else {
                println("Problem with geocoder")
            }
        })
    }
    
    func displayInfo(pm: CLPlacemark, path: NSIndexPath) {
        locationer.stopUpdatingLocation()
        let selectedItem = itemsManager.items[path.row]
        selectedItem.name = selectedItem.name + "Found at" + pm.locality
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("ERROR")
    }
    
    override func tableView(taleView: UITableView, numberOfRowsInSection section: Int) ->Int {
        return itemsManager.items.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath) as UITableViewCell
        let item = itemsManager.items[indexPath.row]
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
                itemsManager.items += [newItem]
                let indexPath = NSIndexPath(forRow: itemsManager.items.count-1 , inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                itemsManager.save()
            }
        }
    }
    
    
    
}

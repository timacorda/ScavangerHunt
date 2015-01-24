//
//  ListViewController.swift
//  ScavangerHunt
//
//  Created by Timothy Acorda on 1/24/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    var scavengerHuntItems = [ScavengerHuntItem(name: "Bird") ,
                                                 ScavengerHuntItem(name:"Goat") ,
                                                 ScavengerHuntItem(name: "Horse")]
    override func tableView(taleView: UITableView, numberOfRowsInSection section: Int) ->Int {
        return scavengerHuntItems.count;
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath) as UITableViewCell
        
        let item = scavengerHuntItems[indexPath.row]
        cell.textLabel!.text = item.name
        return cell
    }
}

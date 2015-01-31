//
//  ItemsManager.swift
//  ScavangerHunt
//
//  Created by Timothy Acorda on 1/24/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

import Foundation

class ItemsManager {
    //lazy -> expensive, one time
    //private-> only to our class
    var items = [ScavengerHuntItem]()
    lazy private var archievePath: String = {
        let fileManager = NSFileManager.defaultManager()
        let documentsDirectoryURLs = fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)
        let archiveURL = documentsDirectoryURLs.first!.URLByAppendingPathComponent("ScavengerHuntItems", isDirectory: false)
        return archiveURL.path!
    }()
    
    func save() {
        NSKeyedArchiver.archiveRootObject(items, toFile: archievePath)
    }
    
    private func unarchiveSavedItems() {
        if NSFileManager.defaultManager().fileExistsAtPath(archievePath) {
            let savedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(archievePath) as [ScavengerHuntItem]
            items = savedItems
            
        }
    }
    
    init() {
        unarchiveSavedItems()
    }
}
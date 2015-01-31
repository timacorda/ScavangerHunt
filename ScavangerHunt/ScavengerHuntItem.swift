//
//  ScavengerHuntItem.swift
//  ScavangerHunt
//
//  Created by Timothy Acorda on 1/24/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

import Foundation
import UIKit

class ScavengerHuntItem: NSObject , NSCoding {
    var name: String
    let NameKey = "NameKey"
    let PhotoKey = "PhotoKey"
    var photo: UIImage?
    var isComplete: Bool {
        get {
            return photo != nil
        }
    }
    init(name: String) {
        self.name = name
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: NameKey)
        if let thePhoto = photo {
            aCoder.encodeObject(photo, forKey: PhotoKey)
        }
    }
    
    required init(coder aDecoder:NSCoder) {
        name = aDecoder.decodeObjectForKey(NameKey) as String
        photo = aDecoder.decodeObjectForKey(PhotoKey) as? UIImage
    }
}
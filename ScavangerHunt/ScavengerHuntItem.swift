//
//  ScavengerHuntItem.swift
//  ScavangerHunt
//
//  Created by Timothy Acorda on 1/24/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

import Foundation
import UIKit

class ScavengerHuntItem: NSObject {
    let name: String
    var photo: UIImage?
    var isComplete: Bool {
        get {
            return photo != nil
        }
    }
    init(name: String) {
        self.name = name
    }
}
//
//  ViewController.swift
//  ScavangerHunt
//
//  Created by Timothy Acorda on 1/24/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}


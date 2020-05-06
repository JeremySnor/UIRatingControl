//
//  ViewController.swift
//  UIRatingControlExample
//
//  Created by Artem Eremeev on 06.05.2020.
//  Copyright © 2020 Artem Eremeev. All rights reserved.
//

import UIKit
import UIRatingControl

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func ratingChanged(_ sender: UIRatingControl) {
        print("currentRating", sender.currentRating)
    }
    
}


//
//  DetailViewController.swift
//  CustomTableView
//
//  Created by Burak Akin on 17.07.2018.
//  Copyright © 2018 Burak Akin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailVCLabel: UILabel!
    var text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailVCLabel.text = text
      
    }

  
}

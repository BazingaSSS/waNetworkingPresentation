//
//  ViewController.swift
//  DemoSwapi
//
//  Created by WA on 8/13/19.
//  Copyright © 2019 WA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PeopleService().getFirstHero { [weak self] hero in
            self?.nameLabel.text = hero.name
            self?.hairColorLabel.text = hero.hairColor
            self?.heightLabel.text = "Height: " + hero.height
        }
    }
}


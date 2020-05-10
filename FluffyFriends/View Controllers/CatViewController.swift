//
//  CatViewController.swift
//  FluffyFriends
//
//  Created by Veronika Babii on 07.05.2020.
//  Copyright © 2020 Veronika Babii. All rights reserved.
//

import UIKit

class CatViewController: UIViewController {
    
    var cat:Cat?
    
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        breedLabel.text = cat?.name
        descriptionLabel.text = cat?.description
        countryLabel.text = cat?.origin
        lifeLabel.text = cat?.life_span
    }

}

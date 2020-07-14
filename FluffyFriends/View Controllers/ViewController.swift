//
//  ViewController.swift
//  FluffyFriends
//
//  Created by Veronika Babii on 05.05.2020.
//  Copyright © 2020 Veronika Babii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }

    func setUpElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    
}



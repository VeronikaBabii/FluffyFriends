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
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var isHypoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var threeElemView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        //view.backgroundColor = UIColor.init(red: 241/255, green: 160/255, blue: 143/255, alpha: 1)
        
        breedLabel.text = cat?.name
        lifeLabel.text = cat!.life_span
        countryLabel.text = cat?.origin
        descriptionLabel.text = cat?.description
        
        intelligenceLabel.text = "\((cat?.intelligence)!)"
        
        if "\((cat?.hypoallergenic)!)" == "1" {
            isHypoLabel.text = "Yes"
        } else {
            isHypoLabel.text = "No"
        }
        
        //weightLabel.text = cat?.weight.metric
        
        // wiki button
//        let url = cat?.wikipedia_url
//        print(url!)
        
        Utilities.styleReadMoreButton(readButton)
        styleViews()
        
        
    }
    
    func styleViews() {
        styleView(view: firstView)
        styleView(view: secondView)
        styleView(view: threeElemView)
        styleView(view: descriptionView)
    }
    
    func styleView(view: UIView) {
        view.backgroundColor = UIColor.init(red: 241/255, green: 160/255, blue: 143/255, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 2
        view.layer.shadowRadius = 4
    }
}

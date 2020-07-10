//
//  CharacterDetailVC.swift
//  BreakingBad
//
//  Created by Daniel Hilton on 09/07/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import UIKit

class CharacterDetailVC: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var appearancesLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    //MARK:- Properties
    
    var character: CharacterWithImage!

    //MARK:- View Lifecycle & Configuration
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    
    private func configureView() {
        nameLabel.text = character.name
        nicknameLabel.text = character.nickname
        characterImageView.image = character.image
        occupationLabel.text = character.occupation.joined(separator: ", ")
        appearancesLabel.text = character.appearance.map(String.init).joined(separator: ", ")
        statusLabel.text = character.status
        characterImageView.layer.cornerRadius = 18
    }

    

}

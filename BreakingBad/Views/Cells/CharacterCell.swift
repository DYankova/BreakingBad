//
//  CharacterCell.swift
//  BreakingBad
//
//  Created by Daniel Hilton on 09/07/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    static let reuseID = "CharacterCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 18
        cellView.layer.shadowColor = UIColor.lightGray.cgColor
        cellView.layer.shadowOpacity = 0.3
        cellView.layer.shadowRadius = 1.2
        cellView.layer.shadowOffset = .zero
        characterImageView.layer.cornerRadius = 12
        updateViewForUserInterfaceStyle()
    }
    
    // Adjust background color for dark mode
    func updateViewForUserInterfaceStyle() {
        cellView.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .systemGray6 : .white
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateViewForUserInterfaceStyle()
    }

    
}

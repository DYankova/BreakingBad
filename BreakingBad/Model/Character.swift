//
//  Character.swift
//  BreakingBad
//
//  Created by Daniel Hilton on 09/07/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import UIKit

struct Character: Codable {
    let img: String
    let name: String
    let nickname: String
    let occupation: [String]
    let status: String
    let appearance: [Int]
}

// Created separate Character struct to hold the UIImage property
struct CharacterWithImage {
    let image: UIImage
    let name: String
    let nickname: String
    let occupation: [String]
    let status: String
    let appearance: [Int]
}

//
//  BBError.swift
//  BreakingBad
//
//  Created by Daniel Hilton on 09/07/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import Foundation

enum BBError: String, Error {
    case invalidURL = "The URL used to retrieve the user data is invalid."
    case unableToComplete = "Unable able to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}

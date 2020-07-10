//
//  NetworkingManager.swift
//  BreakingBad
//
//  Created by Daniel Hilton on 09/07/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import UIKit

class NetworkingManager {
    
    static let shared = NetworkingManager()
    private init() {}
    
    
    func downloadCharacters(completion: @escaping (Result<[CharacterWithImage],BBError>) -> ()) {
        guard let url = URL(string: "https://breakingbadapi.com/api/characters") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error)
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let downloadedData = try decoder.decode([Character].self, from: data)
                
                var characters: [CharacterWithImage] = []
                for character in downloadedData {
                    let image = self.convertUrlToImage(character: character)
                    let newCharacter = CharacterWithImage(image: image,
                                                          name: character.name,
                                                          nickname: character.nickname,
                                                          occupation: character.occupation,
                                                          status: character.status,
                                                          appearance: character.appearance)
                    characters.append(newCharacter)
                }
                completion(.success(characters))
                
            }
            catch {
                print(error)
                completion(.failure(.invalidData))
            }
            
        }.resume()
    }
    
    
    func convertUrlToImage(character: Character) -> UIImage { 
        var image: UIImage!
        if let imageURl = URL(string: character.img) {
            do {
                let imageData = try Data(contentsOf: imageURl)
                image = UIImage(data: imageData)
            } catch {
                image = UIImage(systemName: "person.fill")!
            }
        } else {
            image = UIImage(systemName: "person.fill")!
        }
        return image
    }
    
}

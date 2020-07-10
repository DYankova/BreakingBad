//
//  CharactersVC.swift
//  BreakingBad
//
//  Created by Daniel Hilton on 09/07/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import UIKit

enum Season: Int {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
}

class CharactersVC: UIViewController {

    //IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK:- Properties
    
    private var characters: [CharacterWithImage] = []
    private var filteredCharacters: [CharacterWithImage] = []
    private var characterImages: [UIImage] = []
    private var selectedCharacter: CharacterWithImage?
    
    //MARK:- View Lifecycle & Configuration
    
    override func viewDidLoad() {
        super.viewDidLoad()

        downloadCharacters()
        configureTableView()
        searchBar.delegate = self
    }
    
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Nibs.characterCell, bundle: nil), forCellReuseIdentifier: CharacterCell.reuseID)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGroupedBackground
    }
    
    
    private func configure(activityIndicatorView: UIActivityIndicatorView) {
        view.addSubview(activityIndicatorView)
        view.bringSubviewToFront(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    //MARK:- Network Call

    private func downloadCharacters() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        configure(activityIndicatorView: activityIndicator)
        activityIndicator.startAnimating()
        
        NetworkingManager.shared.downloadCharacters { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let characters):
                self.characters = characters
                self.filteredCharacters = characters
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    activityIndicator.stopAnimating()
                }
                
            case .failure(let error):
                self.displayAlertOnMainThread(message: error.rawValue)
                activityIndicator.stopAnimating()
            }
        }
    }
    
    
    //MARK:- Actions
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        let ac = UIAlertController(title: "Filter by season appearances", message: nil, preferredStyle: .actionSheet)
        addActionToFilterBySeason(season: .one, alertController: ac)
        addActionToFilterBySeason(season: .two, alertController: ac)
        addActionToFilterBySeason(season: .three, alertController: ac)
        addActionToFilterBySeason(season: .four, alertController: ac)
        addActionToFilterBySeason(season: .five, alertController: ac)
        ac.addAction(UIAlertAction(title: "All", style: .default) { _ in
            self.filteredCharacters = self.filteredCharacters.filter { $0.appearance == [1,2,3,4,5] }
            self.tableView.reloadData()
        })
        ac.addAction(UIAlertAction(title: "Reset", style: .default) { _ in
            self.filteredCharacters = self.characters
            self.tableView.reloadData()
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    
    private func addActionToFilterBySeason(season: Season, alertController: UIAlertController) {
        alertController.addAction(UIAlertAction(title: "\(season.rawValue)", style: .default) { _ in
            self.filteredCharacters = self.filteredCharacters.filter { $0.appearance.contains(season.rawValue) }
            self.tableView.reloadData()
        })
    }
    
    
    //MARK:- Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.goToCharacterDetail {
            let destVC = segue.destination as! CharacterDetailVC
            destVC.character = selectedCharacter
        }
    }
    

}

//MARK:- TableView Delegate & DataSource

extension CharactersVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCharacters.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reuseID, for: indexPath) as! CharacterCell
        
        cell.characterImageView.image = filteredCharacters[indexPath.row].image
        cell.nameLabel.text = filteredCharacters[indexPath.row].name
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCharacter = filteredCharacters[indexPath.row]
        performSegue(withIdentifier: Segue.goToCharacterDetail, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK:- SearchBar Delegate

extension CharactersVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            filteredCharacters = characters.filter { $0.name.contains(searchText) }
            tableView.reloadData()
        }
        else {
            filteredCharacters = characters
            tableView.reloadData()
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            filteredCharacters = characters.filter { $0.name.contains(searchText) }
            searchBar.resignFirstResponder()
        }
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filteredCharacters = characters
        tableView.reloadData()
    }
    
}

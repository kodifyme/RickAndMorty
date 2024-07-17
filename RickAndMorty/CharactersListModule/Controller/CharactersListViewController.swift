//
//  CharactersListViewController.swift
//  RickAndMorty
//
//  Created by KOДИ on 17.07.2024.
//

import UIKit

protocol CharactersListViewControllerDelegate: AnyObject {
    func updateList(_ characters: [Character])
}

class CharactersListViewController: UIViewController {
    
    weak var delegate: CharactersListViewControllerDelegate?
    
    private lazy var charactersListView: CharactersListView = {
        let view = CharactersListView()
        delegate = view
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
        fetchCharacters()
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        title = "Rick & Morty Characters"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupView() {
        view.addSubview(charactersListView)
    }
    
    private func fetchCharacters() {
        NetworkService.shared.fetchCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                self?.delegate?.updateList(characters)
            case .failure(let error):
                print("Failed to fetch characters: \(error)")
            }
        }
    }
}

//MARK: - Constraints
private extension CharactersListViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            charactersListView.topAnchor.constraint(equalTo: view.topAnchor),
            charactersListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            charactersListView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            charactersListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

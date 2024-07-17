//
//  CharactersListViewController.swift
//  RickAndMorty
//
//  Created by KOДИ on 17.07.2024.
//

import UIKit

class CharactersListViewController: UIViewController {
    
    private lazy var charactersListView: CharactersListView = {
        CharactersListView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        title = "Rick & Morty Characters"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupView() {
        view.addSubview(charactersListView)
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

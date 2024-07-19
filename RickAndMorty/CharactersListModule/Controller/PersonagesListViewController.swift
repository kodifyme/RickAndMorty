//
//  PersonagesListViewController.swift
//  RickAndMorty
//
//  Created by KOДИ on 17.07.2024.
//

import UIKit

protocol CharactersListViewControllerDelegate: AnyObject {
    func updateList(_ personage: [Personage])
    func appendList(_ personage: [Personage])
}

class PersonagesListViewController: UIViewController {
    
    weak var delegate: CharactersListViewControllerDelegate?
    
    private var currentPage = 1
    private var isLoading = false
    private var filterCriteria: Filter?
    private var searchQuery: String?
    
    private lazy var charactersListView: PersonagesListView = {
        let view = PersonagesListView()
        view.delegate = self
        delegate = view
        return view
    }()
    
    private lazy var filterVC: FilterViewController = {
        let vc = FilterViewController()
        vc.delegate = self
        vc.sheetPresentationController?.prefersGrabberVisible = false
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
        fetchCharacters()
    }
    
    private func setupNavigationBar() {
        title = "Rick & Morty Characters"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupView() {
        view.addSubview(charactersListView)
        setupConstraints()
    }
    
    private func fetchCharacters() {
        isLoading = true
        NetworkService.shared.fetchPersonages(page: currentPage, searchQuery: searchQuery, filterCriteria: filterCriteria) { [weak self] result in
            guard let self else { return }
            isLoading = false
            
            switch result {
            case .success(let characters):
                currentPage == 1 ? delegate?.updateList(characters) : delegate?.appendList(characters)
            case .failure(let error):
                print("Failed to fetch characters: \(error)")
            }
        }
    }
}

//MARK: - FilterViewControllerDelegate
extension PersonagesListViewController: FilterViewControllerDelegate {
    func didApplyFilters(criteria: Filter) {
        filterCriteria = criteria
        currentPage = 1
        fetchCharacters()
    }
}

//MARK: - CharactersListViewDelegate
extension PersonagesListViewController: PersonagesListViewDelegate {
    
    func didSelectCharacter(_ personage: Personage) {
        navigationController?.pushViewController(DetailViewController(personage: personage), animated: true)
    }
    
    func loadMoreCharacters() {
        guard !isLoading else { return }
        currentPage += 1
        fetchCharacters()
    }
    
    func searchTextChanged(_ text: String) {
        searchQuery = text
        currentPage = 1
        fetchCharacters()
    }
    
    func filterButtonTapped() {
        filterVC.sheetPresentationController?.detents = [.medium()]
        present(filterVC, animated: true)
    }
}

//MARK: - Constraints
private extension PersonagesListViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            charactersListView.topAnchor.constraint(equalTo: view.topAnchor, constant: 2),
            charactersListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            charactersListView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            charactersListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

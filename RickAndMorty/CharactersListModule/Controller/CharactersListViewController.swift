//
//  CharactersListViewController.swift
//  RickAndMorty
//
//  Created by KOДИ on 17.07.2024.
//

import UIKit

protocol CharactersListViewControllerDelegate: AnyObject {
    func updateList(_ characters: [Character])
    func appendList(_ characters: [Character])
}

class CharactersListViewController: UIViewController {
    
    private var currentPage = 1
    private var isLoading = false
    
    weak var delegate: CharactersListViewControllerDelegate?
    
    private lazy var searchTextField: SearchTextField = {
        let textField = SearchTextField()
        textField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
        return textField
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchStackView: UIStackView = {
        UIStackView(arrangedSubviews: [searchTextField, filterButton],
                    axis: .horizontal,
                    spacing: 2,
                    alignment: .center)
    }()

    private lazy var charactersListView: CharactersListView = {
        let view = CharactersListView()
        view.delegate = self
        delegate = view
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
        fetchCharacters(page: currentPage)
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        title = "Rick & Morty Characters"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupView() {
        view.addSubview(searchStackView)
        view.addSubview(charactersListView)
    }
    
    private func fetchCharacters(page: Int) {
        isLoading = true
        NetworkService.shared.fetchCharacters(page: page) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let characters):
                if page == 1 {
                    self?.delegate?.updateList(characters)
                } else {
                    self?.delegate?.appendList(characters)
                }
            case .failure(let error):
                print("Failed to fetch characters: \(error)")
            }
        }
    }
    
    @objc private func searchTextChanged() {
        
    }
    
    @objc private func filterButtonTapped() {
        let filterVC = FilterViewController()
        
        if let sheet = filterVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = false
        }
        present(filterVC, animated: true)
    }
}

//MARK: -


//MARK: - CharactersListViewDelegate
extension CharactersListViewController: CharactersListViewDelegate {
    func didSelectCharacter(_ character: Character) {
        navigationController?.pushViewController(DetailViewController(character: character), animated: true)
    }
    
    func loadMoreCharacters() {
        guard !isLoading else { return }
        currentPage += 1
        fetchCharacters(page: currentPage)
    }
}

//MARK: - Constraints
private extension CharactersListViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            charactersListView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 2),
            charactersListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            charactersListView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            charactersListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

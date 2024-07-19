//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by KOДИ on 17.07.2024.
//

import UIKit

protocol CharactersListViewDelegate: AnyObject {
    func didSelectCharacter(_ character: Character)
    func loadMoreCharacters()
    func searchTextChanged(_ text: String)
    func filterButtonTapped()
}

protocol CharactersListActivityDelegate: AnyObject {
    func start()
    func stop()
}

class CharactersListView: UIView {
    
    weak var delegate: CharactersListViewDelegate?
    weak var activityDelegate: CharactersListActivityDelegate?
    
    private var characters: [Character] = []
    
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
    
    private lazy var charactersTableView: UITableView = {
        
        lazy var footerView: ActivityFooterView = {
            let footerView = ActivityFooterView()
            activityDelegate = footerView
            return footerView
        }()
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.identifier)
        tableView.register(ActivityFooterView.self, forHeaderFooterViewReuseIdentifier: ActivityFooterView.identifier)
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = footerView
        tableView.sectionFooterHeight = 44
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        
        addSubview(searchStackView)
        addSubview(charactersTableView)
    }
    
    @objc private func searchTextChanged() {
        guard let text = searchTextField.text else { return }
        delegate?.searchTextChanged(text)
    }
    
    @objc private func filterButtonTapped() {
        delegate?.filterButtonTapped()
    }
}

//MARK: - UITableViewDataSource
extension CharactersListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else {
            return UITableViewCell()
        }
        cell.configure(with: characters[indexPath.row])
        return cell
    }
}

//MARK: - UITableViewDelegate
extension CharactersListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
            activityDelegate?.start()
            delegate?.loadMoreCharacters()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectCharacter(characters[indexPath.row])
    }
}

//MARK: - CharactersListViewControllerDelegate
extension CharactersListView: CharactersListViewControllerDelegate {
    
    func updateList(_ characters: [Character]) {
        self.characters = characters
        activityDelegate?.stop()
        charactersTableView.reloadData()
    }
    
    func appendList(_ characters: [Character]) {
        activityDelegate?.stop()
        guard !characters.isEmpty else { return }
        self.characters.append(contentsOf: characters)
        charactersTableView.reloadData()
    }
}

//MARK: - Constraints
private extension CharactersListView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            searchStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            charactersTableView.topAnchor.constraint(equalTo: searchStackView.bottomAnchor, constant: 5),
            charactersTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            charactersTableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            charactersTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

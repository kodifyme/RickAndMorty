//
//  PersonagesListView.swift
//  RickAndMorty
//
//  Created by KOДИ on 17.07.2024.
//

import UIKit

protocol PersonagesListViewDelegate: AnyObject {
    func didSelectCharacter(_ personage: Personage)
    func loadMoreCharacters()
    func searchTextChanged(_ text: String)
    func filterButtonTapped()
}

protocol PersonagesListActivityDelegate: AnyObject {
    func start()
    func stop()
}

class PersonagesListView: UIView {
    
    // MARK: - Connections
    
    weak var delegate: PersonagesListViewDelegate?
    weak var activityDelegate: PersonagesListActivityDelegate?
    
    // MARK: - Data
    
    private var characters: [Personage] = []
    
    // MARK: - UI
    
    private lazy var searchTextField: SearchTextField = {
        let textField = SearchTextField()
        textField.textColor = .whiteTextColor
        textField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
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
        
        setupAppearance()
        embedViews()
        setupBehaviour()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func searchTextChanged() {
        guard let text = searchTextField.text else { return }
        delegate?.searchTextChanged(text)
    }
    
    @objc private func filterButtonTapped() {
        delegate?.filterButtonTapped()
    }
}

// MARK: - Setup appearance

private extension PersonagesListView {
    
    func setupAppearance() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
    }
}

// MARK: - Embed view

private extension PersonagesListView {
    
    func embedViews() {
        [
            searchStackView,
            charactersTableView
        ].forEach { addSubview($0) }
    }
}

// MARK: - Setup behaviour

private extension PersonagesListView {
    
    func setupBehaviour() {
        charactersTableView.register(PersonageCell.self, forCellReuseIdentifier: PersonageCell.identifier)
        charactersTableView.register(ActivityFooterView.self, forHeaderFooterViewReuseIdentifier: ActivityFooterView.identifier)
        
       
    }
}

//MARK: - UITableViewDataSource

extension PersonagesListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonageCell.identifier, for: indexPath) as? PersonageCell else {
            return UITableViewCell()
        }
        
        let personage = characters[indexPath.row]
        
        NetworkService.shared.fetchImage(from: personage.image) { result in
            switch result {
            case .success(let image):
                cell.configurePoster(image)
            case .failure(let error):
                print("Failed to load image: \(error)")
            }
        }
        
        cell.configure(with: personage)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension PersonagesListView: UITableViewDelegate {
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

extension PersonagesListView: CharactersListViewControllerDelegate {
    
    func updateList(_ characters: [Personage]) {
        self.characters = characters
        activityDelegate?.stop()
        charactersTableView.reloadData()
    }
    
    func appendList(_ characters: [Personage]) {
        activityDelegate?.stop()
        guard !characters.isEmpty else { return }
        self.characters.append(contentsOf: characters)
        charactersTableView.reloadData()
    }
}

//MARK: - Constraints

private extension PersonagesListView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            searchStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            charactersTableView.topAnchor.constraint(equalTo: searchStackView.bottomAnchor, constant: 5),
            charactersTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            charactersTableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            charactersTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            searchTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.83),
            searchTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

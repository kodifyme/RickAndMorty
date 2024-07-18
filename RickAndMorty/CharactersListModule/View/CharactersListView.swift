//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by KOДИ on 17.07.2024.
//

import UIKit

protocol CharactersListViewDelegate: AnyObject {
    func didSelectCharacter(_ character: Character)
}

class CharactersListView: UIView {
    
    weak var delegate: CharactersListViewDelegate?
    var characters: [Character] = []
    
    private lazy var charactersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.identifier)
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setDelegates()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        addSubview(charactersTableView)
    }
    
    private func setDelegates() {
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectCharacter(characters[indexPath.row])
    }
}

//MARK: - CharactersListViewControllerDelegate
extension CharactersListView: CharactersListViewControllerDelegate {
    func updateList(_ characters: [Character]) {
        self.characters = characters
        charactersTableView.reloadData()
    }
}

//MARK: - Constraints
private extension CharactersListView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            charactersTableView.topAnchor.constraint(equalTo: topAnchor),
            charactersTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            charactersTableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            charactersTableView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

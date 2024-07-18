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
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
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
        addSubview(activityIndicator)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height {
            delegate?.loadMoreCharacters()
        }
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let lastSectionIndex = tableView.numberOfSections - 1
//           let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
//           if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
//              // print("this is the last cell")
//               
//               activityIndicator.startAnimating()
//               activityIndicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
//
//               tableView.tableFooterView = activityIndicator
//               tableView.tableFooterView?.isHidden = false
//               delegate?.loadMoreCharacters()
//           }
//    }
    
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
    
    func appendList(_ characters: [Character]) {
        self.characters.append(contentsOf: characters)
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
            charactersTableView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: charactersTableView.bottomAnchor)
        ])
    }
}

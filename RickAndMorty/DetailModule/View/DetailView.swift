//
//  DetailView.swift
//  RickAndMorty
//
//  Created by KOДИ on 18.07.2024.
//

import UIKit

class DetailView: UIView {
    
    private let networkService = NetworkService.shared
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let posterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        return image
    }()
    
    private let statusView = StatusView()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let episodesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var itemsStackView: UIStackView = {
        UIStackView(arrangedSubviews: [posterImageView, statusView, speciesLabel, genderLabel, episodesLabel, locationLabel],
                    axis: .vertical,
                    spacing: 12,
                    alignment: .fill)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        
        addSubview(scrollView)
        scrollView.addSubview(posterImageView)
        scrollView.addSubview(statusView)
        scrollView.addSubview(itemsStackView)
    }
}

//MARK: - DetailViewControllerDelegate
extension DetailView: DetailViewControllerDelegate {
    func configure(with character: Character) {
        networkService.fetchImage(from: character.image) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.posterImageView.image = image
                }
            case .failure(let error):
                print("Failed to load image: \(error)")
            }
        }
        
        statusView.configure(with: character.status)
        speciesLabel.text = "Species: \(character.species)"
        genderLabel.text = "Gender: \(character.gender)"
        networkService.fetchEpisodeNames(from: character.episode) { [weak self] result in
            switch result {
            case .success(let episodeNames):
                self?.episodesLabel.text = "Episodes: \(episodeNames.joined(separator: ", "))"
            case .failure(let error):
                print("Failed to load episode names: \(error)")
            }
        }
        locationLabel.text = "Last known location: \(character.location.name)"
    }
}

//MARK: - Constraints
private extension DetailView {
    func setupContraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            itemsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            itemsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            itemsStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            itemsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}


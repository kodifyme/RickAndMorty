//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by KOДИ on 17.07.2024.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    static let identifier = "CharacterCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var statusSpeciesStackView: UIStackView = {
       UIStackView(arrangedSubviews: [statusLabel, speciesLabel],
                   axis: .horizontal,
                   spacing: 2,
                   alignment: .leading)
    }()
    
    private lazy var characteristicsStackView: UIStackView = {
        UIStackView(arrangedSubviews: [nameLabel, statusSpeciesStackView, genderLabel],
                    axis: .vertical,
                    spacing: 5,
                    alignment: .leading)
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        backgroundColor = .black
        
        contentView.addSubview(containerView)
        containerView.addSubview(characterImageView)
        containerView.addSubview(characteristicsStackView)
    }
    
    func configure(with model: Character) {
        NetworkService.shared.fetchImage(from: model.image) { [weak self] result in
            switch result {
            case .success(let image):
                self?.characterImageView.image = image
            case .failure(let error):
                print("Failed to load image: \(error)")
            }
        }
        nameLabel.text = model.name
        statusLabel.text = model.status.rawValue
        speciesLabel.text = "• \(model.species)"
        genderLabel.text = model.gender
        
        setStatusLabelColor(for: model.status)
    }
}

//MARK: - Set Color For Status
private extension CharacterCell {
    func setStatusLabelColor(for status: Status) {
        switch status {
        case .alive:
            statusLabel.textColor = .systemGreen
        case .dead:
            statusLabel.textColor = .systemRed
        case .unknown:
            statusLabel.textColor = .systemGray
        }
    }
}

//MARK: - Constraints
private extension CharacterCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            characterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            characterImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 85),
            characterImageView.heightAnchor.constraint(equalToConstant: 65),
            
            characteristicsStackView.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 15),
            characteristicsStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}

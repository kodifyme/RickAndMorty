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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //    private lazy var statusSpeciesStackView: UIStackView = {
    //        UIStackView(arrangedSubviews: [statusLabel, speciesLabel],
    //                    axis: .horizontal,
    //                    spacing: 2)
    //    }()
    //
    //    private lazy var characteristicsStackView: UIStackView = {
    //        UIStackView(arrangedSubviews: [nameLabel, statusSpeciesStackView, genderLabel],
    //                    axis: .vertical,
    //                    spacing: 5)
    //    }()
    
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
        
//        let selectedBackgroundView = UIView()
//        selectedBackgroundView.backgroundColor = .black
//        self.selectedBackgroundView = selectedBackgroundView
        
        contentView.addSubview(containerView)
        //        containerView.addSubview(characterImageView)
        //        containerView.addSubview(characteristicsStackView)
        containerView.addSubview(characterImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(statusLabel)
        containerView.addSubview(speciesLabel)
        containerView.addSubview(genderLabel)
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
            statusLabel.textColor = .green
        case .dead:
            statusLabel.textColor = .red
        case .unknown:
            statusLabel.textColor = .gray
        }
    }
}

//MARK: - Constraints
private extension CharacterCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            characterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            characterImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 85),
            characterImageView.heightAnchor.constraint(equalToConstant: 65),
            
            //            characteristicsStackView.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            //            characteristicsStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
            nameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 9),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            statusLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            
            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            speciesLabel.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant: 3),
            
            genderLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5),
            genderLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16)
        ])
    }
}

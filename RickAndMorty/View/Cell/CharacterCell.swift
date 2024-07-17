//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by KOДИ on 17.07.2024.
//

import UIKit

//class CharacterCell: UITableViewCell {
//
//    static let identifier = "cell"
//
//    private let characterImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "image")
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    private let nameLable: UILabel = {
//        let label = UILabel()
//        label.textColor = .white
//        label.text = "Rick Sanchez"
//        label.font = .boldSystemFont(ofSize: 18)
//        return label
//    }()
//
//    private let statusLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Alive"
//        label.font = .boldSystemFont(ofSize: 16)
//        return label
//    }()
//
//    private let speciesLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Human"
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.textColor = .white
//        return label
//    }()
//
//    private lazy var characteristicsStackView: UIStackView = {
//        UIStackView(arrangedSubviews: [nameLable, statusLabel, speciesLabel],
//                    axis: .vertical,
//                    spacing: 6)
//    }()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        setupCell()
//        setupConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupCell() {
//        backgroundColor = .gray
//        contentView.addSubview(characterImageView)
//        contentView.addSubview(characteristicsStackView)
//    }
//}
//


class CharacterCell: UITableViewCell {
    
    static let identifier = "CharacterCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Rick Sanchez"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Alive"
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let betweenPointLabel: UILabel = {
        let label = UILabel()
        label.text = "•"
        label.textColor = .white
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.text = "Human"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.text = "Male"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusSpeciesStackView: UIStackView = {
        UIStackView(arrangedSubviews: [statusLabel, betweenPointLabel, speciesLabel],
                    axis: .horizontal,
                    spacing: 2)
    }()
    
    private lazy var characteristicsStackView: UIStackView = {
        UIStackView(arrangedSubviews: [nameLabel, statusSpeciesStackView, genderLabel],
                    axis: .vertical,
                    spacing: 5)
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
        
//        let selectedBackgroundView = UIView()
//        selectedBackgroundView.backgroundColor = .black
//        self.selectedBackgroundView = selectedBackgroundView
        
        contentView.addSubview(containerView)
        containerView.addSubview(characterImageView)
        containerView.addSubview(characteristicsStackView)
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
            
            characteristicsStackView.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            characteristicsStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}

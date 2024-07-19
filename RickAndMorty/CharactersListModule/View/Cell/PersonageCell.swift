//
//  PersonageCell.swift
//  RickAndMorty
//
//  Created by KOДИ on 17.07.2024.
//

import UIKit

class PersonageCell: UITableViewCell {
    
    static let identifier = "PersonageCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let personageImageView: UIImageView = {
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
        label.adjustsFontSizeToFitWidth = true
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
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(personageImageView)
        containerView.addSubview(characteristicsStackView)
    }
    
    func configure(with personage: Personage) {
        nameLabel.text = personage.name
        statusLabel.text = personage.status.rawValue
        speciesLabel.text = "• \(personage.species)"
        genderLabel.text = personage.gender
        statusLabel.textColor = personage.status.coloring
    }
    
    func configurePoster(_ image: UIImage) {
        personageImageView.image = image
    }
}

//MARK: - Constraints
private extension PersonageCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            personageImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            personageImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            personageImageView.widthAnchor.constraint(equalToConstant: 85),
            personageImageView.heightAnchor.constraint(equalToConstant: 65),
            
            characteristicsStackView.leadingAnchor.constraint(equalTo: personageImageView.trailingAnchor, constant: 15),
            characteristicsStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}

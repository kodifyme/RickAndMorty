//
//  DetailView.swift
//  RickAndMorty
//
//  Created by KOДИ on 18.07.2024.
//

import UIKit

class DetailView: UIView {
    
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
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let episodesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
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
        scrollView.addSubview(itemsStackView)
    }
    
    private func makeAttributedString(title: String, value: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(
            string: "\(title): ",
            attributes: [.font: UIFont.ibmPlexSansBold16() as Any])
        attributedString.append(NSAttributedString(
            string: value,
            attributes: [.font: UIFont.ibmPlexSansRegular16() as Any]))
        return attributedString
    }

}

//MARK: - DetailViewControllerDelegate
extension DetailView: DetailViewControllerDelegate {
    
    func configurePoster(_ image: UIImage) {
        posterImageView.image = image
    }
    
    func configureEpisodes(_ text: String) {
        episodesLabel.text = text
    }
    
    func configure(with personage: Personage) {
        speciesLabel.attributedText = makeAttributedString(title: "Species", value: personage.species)
            genderLabel.attributedText = makeAttributedString(title: "Gender", value: personage.gender)
            episodesLabel.attributedText = makeAttributedString(title: "Episode", value: personage.episode.joined(separator: ", "))
            locationLabel.attributedText = makeAttributedString(title: "Last known location", value: personage.location.name)
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
            itemsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            itemsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}


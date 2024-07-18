//
//  SearchTextField.swift
//  RickAndMorty
//
//  Created by KOДИ on 18.07.2024.
//

import UIKit

class SearchTextField: UITextField {
    
    private let searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAppearance()
        setupLeftView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAppearance() {
        placeholder = "Search"
        tintColor = .white
        backgroundColor = .black
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 15
        leftViewMode = .always
    }
    
    private func setupLeftView() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 34 + 10, height: 24))
        searchIcon.frame = CGRect(x: 10, y: 0, width: 24, height: 24)
        container.addSubview(searchIcon)
        leftView = container
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        widthAnchor.constraint(equalToConstant: 320).isActive = true
    }
}

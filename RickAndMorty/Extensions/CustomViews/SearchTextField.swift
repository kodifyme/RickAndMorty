//
//  SearchTextField.swift
//  RickAndMorty
//
//  Created by KOДИ on 18.07.2024.
//

import UIKit

class SearchTextField: UITextField {
    
    private lazy var searchIconView: IconView = {
        IconView(with: UIImage(systemName: "magnifyingglass"), 
                 frame: CGRect(x: 0, y: 0, width: 44, height: 24))
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAppearance()
        setupLeftView()
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
        leftView = searchIconView
    }
}

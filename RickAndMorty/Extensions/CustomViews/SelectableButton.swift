//
//  SelectableButton.swift
//  RickAndMorty
//
//  Created by KOДИ on 19.07.2024.
//

import UIKit

class SelectableButton: UIButton {
    
    var isSelectedButton: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    init(title: String, frame: CGRect = .zero) {
        super.init(frame: frame)
        setTitle(title, for: .normal)
        titleLabel?.adjustsFontSizeToFitWidth = true
        
        setAppearance()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAppearance() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 35).isActive = true
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.darkGray.cgColor
        setTitleColor(.white, for: .normal)
        setTitleColor(.black, for: .selected)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        updateAppearance()
    }
    
    private func updateAppearance() {
        if isSelectedButton {
            backgroundColor = .white
            setTitleColor(.black, for: .normal)
        } else {
            backgroundColor = .black
            setTitleColor(.white, for: .normal)
        }
    }
    
    @objc private func buttonTapped() {
        isSelectedButton.toggle()
    }
}

//MARK: - Constraints
private extension SelectableButton {
    func setConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 35),
            widthAnchor.constraint(equalToConstant: 230)
        ])
    }
}

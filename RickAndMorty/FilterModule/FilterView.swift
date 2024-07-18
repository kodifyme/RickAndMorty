//
//  FilterView.swift
//  RickAndMorty
//
//  Created by KOДИ on 18.07.2024.
//

import UIKit

class FilterView: UIView {
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Status"
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let deadButton = SelectableButton()
    private let aliveButton = SelectableButton()
    private let unknownButton = SelectableButton()
    
    private lazy var statusStackView: UIStackView = {
        UIStackView(arrangedSubviews: [deadButton, aliveButton, unknownButton],
                    axis: .horizontal,
                    spacing: 8,
                    aligment: .leading)
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let femaleButton = SelectableButton()
    private let maleButton = SelectableButton()
    private let genderlessButton = SelectableButton()
    private let genderUnknownButton = SelectableButton()
    
    private lazy var genderStackView: UIStackView = {
        UIStackView(arrangedSubviews: [femaleButton, maleButton, genderLabel, genderUnknownButton],
                    axis: .horizontal,
                    spacing: 8,
                    aligment: .leading)
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Apply", for: .normal)
        button.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        UIStackView(arrangedSubviews: [applyButton, resetButton],
                    axis: .horizontal,
                    spacing: 10,
                    aligment: .center)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .darkGray
        layer.cornerRadius = 10
        
        addSubview(statusLabel)
        addSubview(statusStackView)
        addSubview(genderLabel)
        addSubview(genderStackView)
        addSubview(buttonsStackView)
    }
    
    @objc private func applyButtonTapped() {
        
    }
    
    @objc private func resetButtonTapped() {
        
    }
}

//MARK: - Constraints
private extension FilterView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            statusStackView.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            statusStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            statusStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            genderLabel.topAnchor.constraint(equalTo: statusStackView.bottomAnchor, constant: 20),
            genderLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            genderStackView.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 10),
            genderStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            genderStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            buttonsStackView.topAnchor.constraint(equalTo: genderStackView.bottomAnchor, constant: 10),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
    }
}

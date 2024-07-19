//
//  CustomSegmentedControl.swift
//  RickAndMorty
//
//  Created by KOДИ on 19.07.2024.
//

import UIKit

class CustomSegmentedControl: UIStackView {
    
    var selectedIndex: Int?
    
    var selectedItem: String? {
        guard let selectedIndex else { return nil }
        return titles[selectedIndex]
    }
    
    private let titles: [String]
    
    private var button: UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }
    
    private lazy var buttons: [UIButton] = {
        var array = [UIButton]()
        for (index, title) in titles.enumerated() {
            let button = button
            button.setTitle(title, for: .normal)
            button.tag = index
            array.append(button)
        }
        return array
    }()
    
    init(titles: [String]) {
        self.titles = titles
        super.init(frame: .zero)
        axis = .horizontal
        spacing = 8
        distribution = .fillEqually
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        for button in buttons {
            addArrangedSubview(button)
        }
    }
    
    func reset() {
        for button in buttons {
            button.isSelected = false
            button.backgroundColor = .black
        }
        selectedIndex = nil
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        
        sender.isSelected.toggle()
        
        selectedIndex = sender.isSelected ? sender.tag : nil
        
        buttons.forEach { button in
            if button != sender {
                button.isSelected = false
            }
            button.backgroundColor = button.isSelected ? .white : .black
        }
    }
}

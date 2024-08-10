//
//  FilterView.swift
//  RickAndMorty
//
//  Created by KOДИ on 18.07.2024.
//

import UIKit

protocol FilterViewDelegate: AnyObject {
    func didApplyFilter(filter: Filter)
}

class FilterView: UIView {
    
    weak var delegate: FilterViewDelegate?
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Status"
        label.textAlignment = .center
        label.font = .ibmPlexSansBold18()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusSegmentedControl: CustomSegmentedControl = {
        CustomSegmentedControl(titles: ["Dead", "Alive", "Unknow"])
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.textColor = .white
        label.font = .ibmPlexSansBold18()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genderSegmentedControl: CustomSegmentedControl = {
        CustomSegmentedControl(titles: ["Female", "Male", "Genderless", "Unknow"])
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Apply", for: .normal)
        button.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .ibmPlexSansBold16()
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .ibmPlexSansRegular16()
        return button
    }()
    
    private lazy var totalButtonsStackView: UIStackView = {
        UIStackView(arrangedSubviews: [applyButton, resetButton],
                    axis: .horizontal,
                    spacing: 10,
                    alignment: .center)
    }()
    
    private lazy var finalStackView: UIStackView = {
        UIStackView(arrangedSubviews: [statusLabel, statusSegmentedControl, genderLabel, genderSegmentedControl, totalButtonsStackView],
                    axis: .vertical,
                    spacing: 30,
                    alignment: .center)
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
        backgroundColor = .black
        layer.cornerRadius = 10
        
        addSubview(finalStackView)
    }
    
    @objc private func applyButtonTapped() {
        delegate?.didApplyFilter(filter: Filter(status: statusSegmentedControl.selectedItem, gender: genderSegmentedControl.selectedItem))
    }
    
    @objc private func resetButtonTapped() {
        statusSegmentedControl.reset()
        genderSegmentedControl.reset()
        applyButtonTapped()
    }
}

//MARK: - Constraints
private extension FilterView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            finalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            finalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            finalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            statusSegmentedControl.widthAnchor.constraint(equalTo: finalStackView.widthAnchor),
            genderSegmentedControl.widthAnchor.constraint(equalTo: finalStackView.widthAnchor),
            
            applyButton.widthAnchor.constraint(equalToConstant: 320),
            resetButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}

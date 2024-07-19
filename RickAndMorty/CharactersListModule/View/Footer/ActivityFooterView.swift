//
//  ActivityFooterView.swift
//  RickAndMorty
//
//  Created by KOДИ on 19.07.2024.
//

import UIKit

class ActivityFooterView: UITableViewHeaderFooterView {

    static let identifier = "ActivityFooterView"
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    init() {
        super.init(reuseIdentifier: ActivityFooterView.identifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(activityIndicator)
        setupConstraints()
    }
}

//MARK: - PersonagesListActivityDelegate
extension ActivityFooterView: PersonagesListActivityDelegate {
    
    func start() {
        activityIndicator.startAnimating()
    }
    
    func stop() {
        activityIndicator.stopAnimating()
    }
}

//MARK: - Constraints
private extension ActivityFooterView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            activityIndicator.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

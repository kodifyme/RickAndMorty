//
//  FilterViewController.swift
//  RickAndMorty
//
//  Created by KOДИ on 19.07.2024.
//

import UIKit

class FilterViewController: UIViewController {
    
    private lazy var filterView: FilterView = {
        let view = FilterView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.addSubview(filterView)
    }
}

//MARK: - Constraints
private extension FilterViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            filterView.topAnchor.constraint(equalTo: view.topAnchor),
            filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

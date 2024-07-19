//
//  FilterViewController.swift
//  RickAndMorty
//
//  Created by KOДИ on 19.07.2024.
//

import UIKit

protocol FilterViewControllerDelegate: AnyObject {
    func didApplyFilters(criteria: Filter)
}

class FilterViewController: UIViewController {
    
    weak var delegate: FilterViewControllerDelegate?
    
    private lazy var filterView: FilterView = {
        let view = FilterView()
        view.delegate = self
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

//MARK: - FilterViewDelegate
extension FilterViewController: FilterViewDelegate {
    func didApplyFilter(status: String?, gender: String?) {
        let criteria = Filter(status: status, gender: gender)
        delegate?.didApplyFilters(criteria: criteria)
        dismiss(animated: true)
    }
    
    func didResetFilters() {
        delegate?.didApplyFilters(criteria: Filter(status: nil, gender: nil))
        dismiss(animated: true)
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

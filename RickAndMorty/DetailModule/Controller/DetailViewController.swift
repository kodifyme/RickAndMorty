//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by KOДИ on 18.07.2024.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func configure(with character: Character)
}

class DetailViewController: UIViewController {
    
    weak var delegate: DetailViewControllerDelegate?
    private lazy var detailView: DetailView = {
        var view = DetailView()
        delegate = view
        return view
    }()
    
    private let character: Character
    
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(with: character)
        setupView()
        configureView(with: character)
        setupContraints()
    }
    
    private func setupNavigationBar(with character: Character) {
        title = character.name
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupView() {
        view.backgroundColor = .black
        view.addSubview(detailView)
    }
    
    private func configureView(with character: Character) {
        delegate?.configure(with: character)
    }
}

//MARK: - Constraints
private extension DetailViewController {
    func setupContraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by KOДИ on 18.07.2024.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func configure(with personage: Personage)
    func configurePoster(_ image: UIImage)
    func configureEpisodes(_ text: String)
}

class DetailViewController: UIViewController {
    
    weak var delegate: DetailViewControllerDelegate?
    private let networkService = NetworkService.shared
    
    private lazy var detailView: DetailView = {
        var view = DetailView()
        delegate = view
        return view
    }()
    
    private let personage: Personage
    
    init(personage: Personage) {
        self.personage = personage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar(with: personage)
        setupView()
        configureView(with: personage)
        setupContraints()
    }
    
    private func setupNavigationBar(with personage: Personage) {
        title = personage.name
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupView() {
        view.backgroundColor = .black
        view.addSubview(detailView)
    }
    
    private func configureView(with personage: Personage) {
        delegate?.configure(with: personage)
        
        networkService.fetchImage(from: personage.image) { [weak self] result in
            switch result {
            case .success(let image):
                self?.delegate?.configurePoster(image)
            case .failure(let error):
                print("Failed to load image: \(error)")
            }
        }
        
        networkService.fetchEpisodesNames(from: personage.episode) { [weak self] result in
            switch result {
            case .success(let episodes):
                self?.delegate?.configureEpisodes("Episodes: \(episodes.map({ $0.name }).joined(separator: ", "))")
            case .failure(let error):
                print("Failed to load episode names: \(error)")
            }
        }
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

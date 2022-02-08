//
//  CharacterDetailViewController.swift
//  marvel-character
//
//  Created by Leyner Jesus Castillo Guedez on 08/02/22.
//

import UIKit
import Kingfisher

protocol CharacterDetailViewControllerDelegate: AnyObject {
    
}

class CharacterDetailViewController: UIViewController {
    
    // MARK: - UI
    lazy private var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        return scrollView
    }()
    
    lazy private var contentStackView: UIStackView = {
        let contentStackView = UIStackView()
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.spacing = 8
        
        contentScrollView.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            contentStackView.leftAnchor.constraint(equalTo: contentScrollView.leftAnchor),
            contentStackView.rightAnchor.constraint(equalTo: contentScrollView.rightAnchor),
            contentStackView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor)
        ])
        
        return contentStackView
    }()
    
    lazy private var comicNameLabel: UILabel = {
        let comicNameLabel = UILabel()
        comicNameLabel.translatesAutoresizingMaskIntoConstraints = false
        comicNameLabel.numberOfLines = 0
        comicNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return comicNameLabel
    }()
    
    lazy private var comicDescriptionLabel: UILabel = {
        let comicDescriptionLabel = UILabel()
        comicDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        comicDescriptionLabel.numberOfLines = 0
        comicDescriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        return comicDescriptionLabel
    }()
    
    lazy private var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        let imageViewSize = UIScreen.main.bounds.height * 0.25
        imageView.heightAnchor.constraint(equalToConstant: imageViewSize).isActive = true
        return imageView
    }()
    
    // MARK: - Properties
    lazy var presenter: CharacterDetailPresenterDelegate = {
        let presenter = CharacterDetailPresenter(viewController: self)
        return presenter
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupContentStackView()
        setupThumbnail()
        setupTexts()
    }
    
    private func setupContentStackView() {
        contentStackView.addArrangedSubview(thumbnailImageView)
        setupComicNameLabel()
        setupComicDescriptionLabel()
    }
    
    private func setupThumbnail() {
        guard let character = presenter.character else { return }
        var imageURL = URL(string: character.photoURL)
        imageURL?.appendPathComponent("portrait_xlarge." + character.photoExtension)
        
        thumbnailImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "ic-hero-placeholder"))
    }
    
    private func setupComicNameLabel() {
        let comicNameContentView = UIView()
        comicNameContentView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(comicNameContentView)
        comicNameContentView.addSubview(comicNameLabel)
        
        NSLayoutConstraint.activate([
            comicNameLabel.rightAnchor.constraint(equalTo: comicNameContentView.rightAnchor, constant: -16),
            comicNameLabel.leftAnchor.constraint(equalTo: comicNameContentView.leftAnchor, constant: 16),
            comicNameLabel.topAnchor.constraint(equalTo: comicNameContentView.topAnchor),
            comicNameLabel.bottomAnchor.constraint(equalTo: comicNameContentView.bottomAnchor),
        ])
    }
    
    private func setupComicDescriptionLabel() {
        let comicDescriptionContentView = UIView()
        comicDescriptionContentView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(comicDescriptionContentView)
        comicDescriptionContentView.addSubview(comicDescriptionLabel)
        
        NSLayoutConstraint.activate([
            comicDescriptionLabel.rightAnchor.constraint(equalTo: comicDescriptionContentView.rightAnchor, constant: -16),
            comicDescriptionLabel.leftAnchor.constraint(equalTo: comicDescriptionContentView.leftAnchor, constant: 16),
            comicDescriptionLabel.topAnchor.constraint(equalTo: comicDescriptionContentView.topAnchor),
            comicDescriptionLabel.bottomAnchor.constraint(equalTo: comicDescriptionContentView.bottomAnchor),
        ])
    }
    
    private func setupTexts() {
        comicNameLabel.text = presenter.character?.name
        comicDescriptionLabel.text = presenter.character?.description
    }
}

// MARK: - CharacterDetailViewControllerDelegate
extension CharacterDetailViewController: CharacterDetailViewControllerDelegate {
    
}

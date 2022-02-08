//
//  ViewController.swift
//  marvel-character
//
//  Created by Leyner Castillo on 27/07/21.
//

import UIKit

protocol CharactersViewControllerDelegate: AnyObject {
    func displayError(message: String)
    func displayCharactersList()
}

class CharactersViewController: UIViewController {

    lazy var presenter: CharactersPresenterDelegate = {
        let presenter = CharactersPresenter()
        presenter.viewController = self
        return presenter
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setupUI()
        activityIndicator.startAnimating()
        presenter.fetchCharacters()
    }
}

// MARK: - CharactersViewControllerDelegate
extension CharactersViewController: CharactersViewControllerDelegate {
    func displayCharactersList() {
        activityIndicator.stopAnimating()
        charactersCollectionView.reloadData()
    }
    
    func displayError(message: String) {
        activityIndicator.stopAnimating()
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}
    
extension CharactersViewController {
    // MARK: - UI
    lazy var charactersCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: CharacterCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.tintColor = .darkGray
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()


    // MARK: - Properties
    lazy var presenter: CharactersPresenterDelegate = {
        let presenter = CharactersPresenter()
        presenter.viewController = self
        return presenter
    }()

    

    private func setupUI() {
        setupLocalizedText()
        setupCollectionView()
    }

    private func setupCollectionView() {
        view.addSubview(charactersCollectionView)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            charactersCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            charactersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            charactersCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            charactersCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),

            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

    }

    private func setupLocalizedText() {
        navigationItem.title = "Marvel Characters"
    }
    
    private func goToDetail(character: DisplayableCharacter) {
        let characterDetailViewController = CharacterDetailViewController()
        characterDetailViewController.presenter.character = character
        navigationController?.pushViewController(characterDetailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.characters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as? CharacterCollectionViewCell else {
            return UICollectionViewCell()
        }

        let character = presenter.characters[indexPath.item]
        cell.character = character
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = presenter.characters[indexPath.row]
        goToDetail(character: character)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

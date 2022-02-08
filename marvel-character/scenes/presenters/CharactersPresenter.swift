//
//  CharactersViewModel.swift
//  marvel-character
//
//  Created by Leyner Castillo on 27/07/21.
//

import Foundation

protocol CharactersPresenterDelegate: AnyObject {
    var characters: [DisplayableCharacter] { get set }
    func fetchCharacters()
}

class CharactersPresenter: CharactersPresenterDelegate {

    var characters = [DisplayableCharacter]()
    weak var viewController: CharactersViewControllerDelegate?
    private let apiClient = ApiClient()

    // MARK: - CharactersPresenterDelegate
    func fetchCharacters() {
        let charactersRouter = CharacterRouter.characterList
        apiClient.request(router: charactersRouter, type: CharactersDataModel.self) { [weak self] result in
            switch result {
            case .success(let object):
                guard let characters = object?.data.results else {
                    self?.viewController?.displayError(message: "Some error")
                    return
                }

                self?.characters = characters.map({ DisplayableCharacter(name: $0.name, description: $0.characterDescription, photoURL: $0.thumbnail.path, photoExtension: $0.thumbnail.thumbnailExtension) })
                self?.viewController?.displayCharactersList()

            case .failure(let error):
                self?.viewController?.displayError(message: error.localizedDescription)
            }
        }
    }
}

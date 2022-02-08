//
//  CharacterDetailPresenter.swift
//  marvel-character
//
//  Created by Leyner Jesus Castillo Guedez on 08/02/22.
//

import Foundation

protocol CharacterDetailPresenterDelegate: AnyObject {
    var character: DisplayableCharacter? { get set }
}

class CharacterDetailPresenter: CharacterDetailPresenterDelegate {
    
    // MARK: - Properties
    var character: DisplayableCharacter?
    weak var viewController: CharacterDetailViewControllerDelegate?
    
    init(viewController: CharacterDetailViewControllerDelegate) {
        self.viewController = viewController
    }
    
}

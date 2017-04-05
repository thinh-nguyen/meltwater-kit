//
//  FHAIProtocols.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 4/1/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import Foundation
import Alamofire

protocol FHAIDocumentsViewProtocol: class {
    var presenter: FHAIPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showDocuments(with documents: [Document])
    
    func onError(errorMsg: String)
    
    func showLoading()
    
    func hideLoading()
}

protocol FHAIRouterProtocol: class {
    static func createFHAIDocumentViewController() -> UIViewController
    // PRESENTER -> WIREFRAME
    func presentDocumentScreen(from view: FHAIDocumentsViewProtocol, forDocument doc: Document)
}

protocol FHAIPresenterProtocol: class {
    var view: FHAIDocumentsViewProtocol? { get set }
    var interactor: FHAIInteractorInputProtocol? { get set }
    var router: FHAIRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showDocument(document: Document)
}

protocol FHAIInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveDocuments(_ documents: [Document])
    func onError(errorMsg: String)
}

protocol FHAIInteractorInputProtocol: class {
    var presenter: FHAIInteractorOutputProtocol? { get set }
    var dataManager: FHAIDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveDocuments(query: BooleanQuery)
}

protocol FHAIDataManagerOutputProtocol: class {
    // DATAMANAGER -> INTERACTOR
    func onDocumentsRetrieved(documents: [Document])
    func onError(errorMsg: String)
}

protocol FHAIDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
    var documentsHandler:FHAIDataManagerOutputProtocol? { get set }
    
    func retrieveDocuments(payload: Parameters) throws
}

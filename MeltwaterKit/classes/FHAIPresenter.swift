//
//  FHAIPresenter.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 4/2/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

class FHAIPresenter: FHAIPresenterProtocol {
    
    weak var view: FHAIDocumentsViewProtocol?
    var interactor: FHAIInteractorInputProtocol?
    var router: FHAIRouterProtocol?
    
    func viewDidLoad() {
        let boolQuery = BooleanQuery(query: "Apple and orange",
            type :"article",
            language:"en",
            startDate:1489305600000,
            endDate:1490857200000,
            country:"us",
            from:0,
            size:20)
        
        view?.showLoading()
        interactor?.retrieveDocuments(query: boolQuery)
    }
    
    func showDocument(document: Document) {
        router?.presentDocumentScreen(from: view!, forDocument: document)
    }
    
}

extension FHAIPresenter: FHAIInteractorOutputProtocol {
    
    func didRetrieveDocuments(_ documents: [Document]) {
        view?.hideLoading()
        view?.showDocuments(with: documents)
    }
    
    func onError(errorMsg: String) {
        view?.hideLoading()
        view?.onError(errorMsg: errorMsg)
    }
    
}

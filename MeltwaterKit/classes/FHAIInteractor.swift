//
//  FHAIInteractor.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 4/2/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import Foundation
import Alamofire

class FHAIInteractor: FHAIInteractorInputProtocol {
    
    var presenter: FHAIInteractorOutputProtocol?
    var dataManager: FHAIDataManagerInputProtocol?
    
    func retrieveDocuments(query: BooleanQuery) {
        do {
            print("Request: \(String(describing: query.toJSONString(prettyPrint: true)))")
            try dataManager?.retrieveDocuments(payload: query.toJSON())
        } catch {
            
        }
    }
}

extension FHAIInteractor: FHAIDataManagerOutputProtocol {
    
    func onError(errorMsg: String) {
        presenter?.onError(errorMsg: errorMsg)
    }

    
    func onDocumentsRetrieved(documents: [Document]) {
        presenter?.didRetrieveDocuments(documents)
        
//        for document in documents {
//            // SAVE to coredata
//        }
    }
    
}


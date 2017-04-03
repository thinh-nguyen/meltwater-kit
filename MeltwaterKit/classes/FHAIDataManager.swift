//
//  FHAIDataManager.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 4/1/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class FHAIDataManager: FHAIDataManagerInputProtocol {
    
    var documentsHandler:FHAIDataManagerOutputProtocol?
    
    public func retrieveDocuments(payload: Parameters)  {

        RestClient.postToUrl(urlString: "https://demo.fairhair.ai/api/fhapp/getquiddities", payload: payload)
            .then { page -> Void in // Return Void to stop the promise chain
                print(page)
                self.documentsHandler?.onDocumentsRetrieved(documents: page.documents)
            }
            .catch { error in
                print(error)
                self.documentsHandler?.onError(errorMsg: error.localizedDescription)
            }
    }
   
}

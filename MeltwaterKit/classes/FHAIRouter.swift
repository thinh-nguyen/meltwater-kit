//
//  FHAIRouter.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 4/2/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import UIKit

class FHAIRouter: FHAIRouterProtocol {
    
    class func createFHAIModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "FHAINavigationController")
        if let view = navController.childViewControllers.first as? FHAIDocumentsViewController {
            let presenter: FHAIPresenterProtocol & FHAIInteractorOutputProtocol = FHAIPresenter()
            let interactor: FHAIInteractorInputProtocol & FHAIDataManagerOutputProtocol = FHAIInteractor()
            let dataManager: FHAIDataManagerInputProtocol = FHAIDataManager()
            let Router: FHAIRouterProtocol = FHAIRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = Router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.dataManager = dataManager
            dataManager.documentsHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "MeltwaterKit", bundle: Bundle.main)
    }
    
    
    func presentDocumentScreen(from view: FHAIDocumentsViewProtocol, forDocument document: Document) {
//        let postDetailViewController = PostDetailRouter.createPostDetailModule(forPost: post)
//        
//        if let sourceView = view as? UIViewController {
//            sourceView.navigationController?.pushViewController(postDetailViewController, animated: true)
//        }
    }
    
}

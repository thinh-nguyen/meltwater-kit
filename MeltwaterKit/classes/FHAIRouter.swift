//
//  FHAIRouter.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 4/2/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import UIKit

public class FHAIRouter: FHAIRouterProtocol {
    
    public class func createFHAIDocumentViewController() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "FHAIDocumentsViewController")
        if let view = viewController as? FHAIDocumentsViewController {
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
            
            return viewController
        }
        return UIViewController()
    }
    
//    public class func createFHAIDocumentViewController() -> UIViewController {
//        let navController = mainStoryboard.instantiateViewController(withIdentifier: "FHAINavigationController")
//        if let view = navController.childViewControllers.first as? FHAIDocumentsViewController {
//            let presenter: FHAIPresenterProtocol & FHAIInteractorOutputProtocol = FHAIPresenter()
//            let interactor: FHAIInteractorInputProtocol & FHAIDataManagerOutputProtocol = FHAIInteractor()
//            let dataManager: FHAIDataManagerInputProtocol = FHAIDataManager()
//            let Router: FHAIRouterProtocol = FHAIRouter()
//            
//            view.presenter = presenter
//            presenter.view = view
//            presenter.router = Router
//            presenter.interactor = interactor
//            interactor.presenter = presenter
//            interactor.dataManager = dataManager
//            dataManager.documentsHandler = interactor
//            
//            return navController
//        }
//        return UIViewController()
//    }

    public class func createLoginModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "MWLoginViewController")
        return navController
    }
    
    static var mainStoryboard: UIStoryboard {
        let podBundle = Bundle(for: FHAIDocumentsViewController.self)
        
        if let bundleURL = podBundle.url(forResource: "MeltwaterKit", withExtension: "bundle") {
            // Find the location of the MeltwaterKit storyboard
            let mwBundle = Bundle(url: bundleURL)!
            return UIStoryboard(name: "MeltwaterKit", bundle: mwBundle)
        }
        else {
            // In case this is included in the main bundle like the case of MeltwaterKitDemo
            return UIStoryboard(name: "MeltwaterKit", bundle: Bundle.main)
        }
    }
    
    
    func presentDocumentScreen(from view: FHAIDocumentsViewProtocol, forDocument document: Document) {
//        let postDetailViewController = PostDetailRouter.createPostDetailModule(forPost: post)
//        
//        if let sourceView = view as? UIViewController {
//            sourceView.navigationController?.pushViewController(postDetailViewController, animated: true)
//        }
    }
    
    func presentDocumentListScreen(from view: MWLoginViewController?, for query: BooleanQuery) {
        let documentsViewController = FHAIRouter.createFHAIDocumentViewController()
        if let sourceView = view {
            sourceView.navigationController?.pushViewController(documentsViewController, animated: true)
        }
    }
}

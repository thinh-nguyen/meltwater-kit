//
//  SearchRouter.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 4/4/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import UIKit

public class SearchRouter {
    
    public class func createSearchViewController() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "FHAINavigationController")
        if let view = navController.childViewControllers.first as? SearchViewController {
            return view
        }
        return UIViewController()
    }
    
    public class func createSearchNavBarController() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "FHAINavigationController")
        
        if let _ = navController.childViewControllers.first as? SearchViewController {
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        let podBundle = Bundle(for: SearchRouter.self)
        
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

}

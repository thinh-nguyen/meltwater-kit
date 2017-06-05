//
//  SearchViewController.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 4/4/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import UIKit

public class SearchViewController: UIViewController {

    @IBAction func doSearch(_ sender: Any) {
        let vc = FHAIRouter.createFHAIDocumentViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setStyles()
        // Do any additional setup after loading the view.
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
     MARK: - Navigation
     */

    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    
}

extension SearchViewController {
    fileprivate func setStyles() {
        if let cl = MWStyles.singleton?.styleMap["NAV_COLOR"] as? [Int] {
            self.navigationController?.navigationBar.barTintColor = MWStyles.singleton?.getColorFromRGB(rgbArray: cl)
        }
    }
}

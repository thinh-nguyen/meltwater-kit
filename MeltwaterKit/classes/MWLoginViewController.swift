//
//  MWLoginViewController.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 4/1/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import Foundation
import UIKit

public class MWLoginViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setStyles()
        
    }
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "documentsSegue" {
            //_;: FHAIDocumentsViewController = segue.destination as! FHAIDocumentsViewController
        }
    }
    
}

extension MWLoginViewController {
    fileprivate func setStyles() {
        if let img = MWStyles.singleton?.styleMap["LOGO"] as? String {
            if let filePath = MWStyles.mwBundle.path(forResource: img, ofType: "png") {
                logoImage.image = UIImage(contentsOfFile: filePath)
            }
        }
    }
}

//
//  FHAIDocumentsTableViewCell.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 4/2/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import UIKit
import AlamofireImage

@IBDesignable
public class FHAIDocumentsTableViewCell: UITableViewCell {
    
    @IBInspectable var BgColor: UIColor = UIColor(red: (234/255.0), green: (234/255), blue: (234/255.0), alpha: 1.0)
    @IBInspectable var Theme: String = "DarkTheme"
    
    @IBOutlet weak var documentImageView: UIImageView!
    
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var openingText: UITextView!
    
    func set(forDocument document: Document) {
        self.selectionStyle = .none
        titleLabel?.text = document.title
        sourceName?.text = "\(document.sourceName) (\(Date(timeIntervalSince1970: document.publishDate/1000)))"
        
        var openingString = document.openingText
        if( openingString.characters.count > 240) {
            let index = openingString.index(openingString.startIndex, offsetBy: 236)
            openingString = "\(openingString.substring(to: index))..."
        }
        openingText?.text = openingString
        if document.imageUrl.characters.count > 0 {
            let url = URL(string: document.imageUrl)!
            let placeholderImage = UIImage(named: "placeholder")!
            documentImageView?.af_setImage(withURL: url, placeholderImage: placeholderImage)
        }
        setStyles()
    }
    
   
//    override func draw(_ rect: CGRect) {
//        super.draw( rect )
//    }
}

extension FHAIDocumentsTableViewCell {
    
    fileprivate func setStyles() {
        if let cl = MWStyles.singleton?.styleMap["TABLE_CELL_BG_RGB"] as? [Int] {
            self.backgroundColor = MWStyles.singleton?.getColorFromRGB(rgbArray: cl)
        } else {
            self.backgroundColor = BgColor
        }
        
        if let cl = MWStyles.singleton?.styleMap["BODY_TEXT_COLOR"] as? [Int] {
            self.openingText.textColor = MWStyles.singleton?.getColorFromRGB(rgbArray: cl)
        }
    }
}

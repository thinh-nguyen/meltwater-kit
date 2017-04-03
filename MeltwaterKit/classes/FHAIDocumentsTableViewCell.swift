//
//  FHAIDocumentsTableViewCell.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 4/2/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import UIKit
import AlamofireImage

class FHAIDocumentsTableViewCell: UITableViewCell {
    
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
    }
}


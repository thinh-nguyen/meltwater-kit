//
//  MWDocumentView.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 4/2/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import UIKit
import PKHUD

public class FHAIDocumentsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var presenter: FHAIPresenterProtocol?
    var documents: [Document] = []
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
}

extension FHAIDocumentsViewController: FHAIDocumentsViewProtocol {
    
    func showDocuments(with documents: [Document]) {
        self.documents = documents
        tableView.reloadData()
    }
    
    func onError(errorMsg: String){
        HUD.flash(.label(errorMsg), delay: 2.0)
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.hide()
    }
    
}

extension FHAIDocumentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FHAICell", for: indexPath) as! FHAIDocumentsTableViewCell
        
        let doc = documents[indexPath.row]
        cell.set(forDocument: doc)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showDocument(document: documents[indexPath.row])
    }
    
}


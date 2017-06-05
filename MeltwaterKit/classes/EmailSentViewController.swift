//
//  EmailSentViewController.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 5/24/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import UIKit

class EmailSentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    fileprivate func showAlert(_ msg: String) {
        let alert = UIAlertController(title: "Status", message: "\(msg)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

extension EmailSentViewController: LoginProtocol {
    
    func onLoginSuccess(profile: AuthProfile, token: AuthToken) {
        self.dismiss(animated: true, completion: nil)
        self.showAlert(token.idToken!)
    }
    
    func onLoginFailure(error: Error) {
        self.showAlert(error.localizedDescription)
    }
}


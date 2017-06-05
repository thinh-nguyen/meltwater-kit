//
//  ViewController.swift
//  MeltwaterKitDemo
//
//  Created by Thinh Nguyen on 3/24/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBAction func doMagicLinkLogin(_ sender: Any) {
        MWLoginManager.sharedManager.startMagicLinkWith(email: emailTextfield!.text!, magicLinkDelegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 13/255, green: 101/255, blue: 153/255, alpha: 1.0)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Logo"), style: .plain, target: nil, action: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    fileprivate func showAlert(_ msg: String) {
        let alert = UIAlertController(title: "Status", message: "\(msg)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension LoginViewController: MagicLinkProtocol {
    func onEmailSent() {
        self.performSegue(withIdentifier: "emailSuccessSegue", sender: self)
    }
    
    func onLoginSuccess(profile: AuthProfile, token: AuthToken) {
        self.dismiss(animated: true, completion: nil)
        self.showAlert(token.idToken!)
    }
    
    func onEmailFailure(error: Error) {
        self.showAlert(error.localizedDescription)
    }
}


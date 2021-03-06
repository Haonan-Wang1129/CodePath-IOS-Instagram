//
//  LoginViewController.swift
//  Assignment 4 - Instagram
//
//  Created by Haonan Wang on 3/25/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func onLogin(_ sender: Any) {
        let username = userNameTextField.text!
        let password = userNameTextField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) {
            (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    @IBAction func onSignup(_ sender: Any) {
        let user = PFUser()
        user.username = userNameTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackground { (success, error) in
            if success {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

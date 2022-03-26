//
//  CameraViewController.swift
//  Assignment 4 - Instagram
//
//  Created by Haonan Wang on 3/25/22.
//

import UIKit
import Parse
import AlamofireImage

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onSubmit(_ sender: Any) {
        let posts = PFObject(className: "post")
        posts["comment"] = commentField.text!
        posts["author"] = PFUser.current()
        
        let image = imageView.image?.pngData()
        let imageFile = PFFileObject(name: "image.png", data: image!)
        posts["image"] = imageFile
        
        posts.saveInBackground {(success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved")
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
        
    }
    
    
    @IBAction func onCamera(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageScaled(to: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
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

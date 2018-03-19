//
//  FirstViewController.swift
//  HelloWorld
//
//  Created by eesee on 2017/12/13.
//  Copyright © 2017年 eesee. All rights reserved.
//

import Foundation
import UIKit
import os.log
import Kingfisher

class MealViewController: LifeCycleLogViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meal:Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tag = "MealViewController"
        if let meal = meal{
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            if (meal.imageUrl != nil) {
                let url = URL(string:meal.imageUrl!)
                photoImageView.kf.setImage(with:url)
            }
            ratingControl.rating = meal.rating
        }
        nameTextField.delegate = self
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem,button === saveButton else {
            //os_log("The sace button was not pressed, cancelling", log:OSLog.default)
            return
        }
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        meal = Meal(name:name, photo:photo, rating:rating)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesCancelled")
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        print("selectImageFromPhotoLibrary")
        nameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController,animated:true,completion:nil)
        
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode{
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The MealViewController is not inside a navigation controller")
        }
        //dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text;
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
                fatalError("Expected a dictionary containing an image, but was provided the following:\(info)")
                
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    private func updateSaveButtonState(){
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}

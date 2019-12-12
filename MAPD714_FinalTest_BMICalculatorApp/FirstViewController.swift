//
//  FirstViewController.swift
//  MAPD714_FinalTest_BMICalculatorApp
//
//  Created by Kevin Nobel on 2019-12-11.
//  Copyright © 2019 Kevin Nobel. All rights reserved.
//

import UIKit
import FirebaseFirestore

class FirstViewController: UIViewController {

    @IBOutlet weak var Name: UITextField!
    
    @IBOutlet weak var Age: UITextField!
    
    @IBOutlet weak var Gender: UITextField!
    
    @IBOutlet weak var Weight: UITextField!
    
    @IBOutlet weak var Height: UITextField!
    
    @IBOutlet weak var value: UILabel!
    
    var db:Firestore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
    }
    
    var isOn = true
    
    
    @IBAction func switched(_ sender: Any) {
        
        isOn = !isOn
        var height = 0
        var weight = 0
        
        if isOn{
            var bmiweight = 0
            var bmiheight = 0
            var final = 0
            var weight = Int(Weight.text!)
            var height = Int(Height.text!)
            bmiweight = (weight! * 703)
            bmiheight = (height! * height!)
                   
                   final = (bmiweight / bmiheight)
                   
            value.text = String(final)
        }
        else{
            var bmiweight = 0
            var bmiheight = 0
            var finalval = 0
            var weight = Int(Weight.text!)
            var height = Int(Height.text!)
            bmiweight = weight!
            bmiheight = (height! * height!)
            finalval = (bmiweight / bmiheight)
            value.text = String(finalval)
               }

    }

    

   
    
    
    @IBAction func Submit(_ sender: Any) {
        // Add a new document in collection
        db?.collection("Users").document("Values").setData([
            "Name": Name.text,
            "Age": Age.text,
            "Gender": Gender.text,
            "Weight" : Weight.text,
            "Height" : Height.text
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}


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

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var age: UITextField!
    
    @IBOutlet weak var gender: UITextField!
    
    @IBOutlet weak var weight: UITextField!
    
    @IBOutlet weak var height: UITextField!
    
   
    
    @IBOutlet weak var Switch: UISwitch!
        @IBAction func calculate(_ sender: UIButton) {
            var Name = name.text!
            var Age = age.text!
            var Gender = gender.text!
            var Weight = weight.text!
            var Height = height.text!
            
            var db = Firestore.firestore()
            if(Switch.isOn){
                var  data =  [
                    "name": Name,
                    "age": Age,
                    "gender": Gender,
                    "weight" : Weight+"pd",
                    "height" : Height+"in"]
                
                db.collection("BMI").document("data").setData(data) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        var wei = Double(Weight)
                        var hei = Double(Height)
                        var bmi = Double(wei!*703/(hei!*hei!))
                        let date = Date()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd.MM.yyyy"
                        let result = formatter.string(from: date)
                        var timestamp = String(Int64(Date().timeIntervalSince1970*1000))
                        
                        db.collection("entry").document(timestamp).setData([
                            "date": result,
                            "weight" : Weight+"pd",
                            "height" : Height+"in",
                            "bmi" : ""+String (format: "%.\(3)f",bmi)+" pd/in2",
                            "timestamp" : timestamp
                        ]) { err in
                            if let err = err {
                                print("Error writing document: \(err)")
                                
                            }else{
                                var alertController = UIAlertController(title: "BMI", message:
                                    "BMI is "+String (format: "%.\(3)f",bmi)+" pd/in2" as! String, preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default,handler: {
                                    (action) in self.performSegue(withIdentifier: "table", sender: nil)
                                }))
                                self.present(alertController, animated: true, completion: nil)
                                
                            }
                            
                            
                            
                        }
                    }
                }
            }
            else{
                var  data =  [
                    "name": Name,
                    "age": Age,
                    "gender": Gender,
                    "weight" : Weight+"kg",
                    "height" : Height+"m"]
                
                db.collection("BMI").document("data").setData(data) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        var wei = Double(Weight)
                        var hei = Double(Height)
                        var bmi = Double(wei!/(hei!*hei!))
                        let date = Date()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd.MM.yyyy"
                        let result = formatter.string(from: date)
                        var timestamp = String(Int64(Date().timeIntervalSince1970*1000))
                        
                        db.collection("entry").document(timestamp).setData([
                            "date": result,
                            "weight" : Weight+"kg",
                            "height" : Height+"m",
                            "bmi" : ""+String (format: "%.\(3)f",bmi)+" kg/m2",
                            "timestamp" : timestamp
                        ]) { err in
                            if let err = err {
                                print("Error writing document: \(err)")
                                
                            }else{
                                var alertController = UIAlertController(title: "BMI", message:
                                    "BMI is "+String (format: "%.\(3)f",bmi)+" kg/m2" as! String, preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default,handler: {
                                    (action) in self.performSegue(withIdentifier: "table", sender: nil)
                                }))
                                self.present(alertController, animated: true, completion: nil)
                                
                            }
                        }
                    }
                }
            }
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            var db = Firestore.firestore()
            
            let docRef = db.collection("BMI").document("data")
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "secondviewcontroller") as! SecondViewController
                    self.present(mainVC, animated: true, completion: nil)
                } else {
                    print("Document does not exist")
                }
            }
        }
    }


//
//  EditViewController.swift
//  MAPD714_FinalTest_BMICalculatorApp
//
//  Created by Kevin Nobel on 2019-12-15.
//  Copyright © 2019 Kevin Nobel. All rights reserved.
//

import UIKit
import FirebaseFirestore

class EditViewController: UIViewController {
    

    @IBOutlet weak var information: UILabel!
    
    var inde = [String:AnyObject]()
    
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var height: UILabel!
    
    @IBAction func calculate(_ sender: Any) {
        
        var weigh = Double(weight.text!)
        var heigh = height.text!
        if((heigh.contains("m"))){
            heigh.removeLast()
            print(heigh)
            var hei = Double(heigh)
            var bmi = Double(weigh!/(hei!*hei!))
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let result = formatter.string(from: date)
            var timestamp = String(Int64(Date().timeIntervalSince1970*1000))
            var db = Firestore.firestore()
            db.collection("entry").document(timestamp).setData([
                "date": result,
                "weight" : String(weigh!)+"kg",
                "height" : height.text,
                "bmi" : ""+String (format: "%.\(3)f",bmi)+" kg/m2",
                "timestamp" : timestamp
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                    
                }else{
                    var alertController = UIAlertController(title: "BMI", message:
                        "BMI is "+String (format: "%.\(3)f",bmi)+" kg/m2" as! String, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default,handler: {
                        (action) in self.performSegue(withIdentifier: "main", sender: nil)
                    }))
                    self.present(alertController, animated: true, completion: nil)
                    
                }
                
                
                
            }
        }
        else{
            heigh.removeLast()
            heigh.removeLast()
            print(heigh)
            var hei = Double(heigh)
            var bmi = Double(weigh!*703/(hei!*hei!))
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let result = formatter.string(from: date)
            var timestamp = String(Int64(Date().timeIntervalSince1970*1000))
            var db = Firestore.firestore()
            db.collection("entry").document(timestamp).setData([
                "date": result,
                "weight" : String(weigh!)+"pd",
                "height" : height.text,
                "bmi" : ""+String (format: "%.\(3)f",bmi)+" pd/in2",
                "timestamp" : timestamp
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                    
                }else{
                    var alertController = UIAlertController(title: "BMI", message:
                        "BMI is "+String (format: "%.\(3)f",bmi)+" pd/in2" as! String, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default,handler: {
                        (action) in self.performSegue(withIdentifier: "main", sender: nil)
                    }))
                    self.present(alertController, animated: true, completion: nil)
                    
                }
                
                
                
            }
            
            
        }
        
        
        
        
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var db = Firestore.firestore()
        
        db.collection("BMI").document("data").getDocument { (document, error) in
            if let document = document, document.exists {
                self.height.text = document.data()!["height"] as! String
                var detail = self.height.text
                if(detail!.contains("m")){
                    self.information.text = "Enter weight in kgs"
                }
                else{
                    self.information.text = "Enter weight in pounds"
                }
            } else {
                print("Document does not exist")
            }
        }
        
        
        
    }
    
    
    
}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



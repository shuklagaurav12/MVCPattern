//
//  ViewController.swift
//  SalaryDemoApp
//
//  Created by Shukla, Gaurav on 29/01/21.
//  Copyright © 2021 Shukla, Gaurav. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
     var db:DBHelper = DBHelper()

    @IBOutlet weak var dofTFX: UITextField!
    @IBOutlet weak var salaryTFX: UITextField!
    @IBOutlet weak var empIdTXF: UITextField!
    @IBOutlet weak var LastNameTXF: UITextField!
    @IBOutlet weak var firstNameTXF: UITextField!
    
    var empData = Emp()
    var arrExist = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         Utility.textFieldPadding(textFieldName: firstNameTXF)
         Utility.textFieldPadding(textFieldName: LastNameTXF)
         Utility.textFieldPadding(textFieldName: empIdTXF)
         Utility.textFieldPadding(textFieldName: salaryTFX)
         Utility.textFieldPadding(textFieldName: dofTFX)
         Utility.setPlaceholderColor(textField: firstNameTXF, placeholderText: "FirstName")
         Utility.setPlaceholderColor(textField: LastNameTXF, placeholderText: "LastName")
         Utility.setPlaceholderColor(textField: empIdTXF, placeholderText: "EmpId")
         Utility.setPlaceholderColor(textField: salaryTFX, placeholderText: "SalaryInUSD")
         Utility.setPlaceholderColor(textField: dofTFX, placeholderText: "DOJ(dd/mm/yyyy)")
    }

    @IBAction func generateBtn_Action(_ sender: Any) {
        empData.firstName = firstNameTXF.text
        empData.lastNmae = LastNameTXF.text
        empData.empId   = Int32(empIdTXF.text ?? "0")
        empData.salary  = Int32(salaryTFX.text ?? "0")
        empData.date    = dofTFX.text
       
        let arr = db.fetchRecords(empId: self.empData.empId ?? 0)
        if arr.count > 0{
            let alert = UIAlertController(title: "Alert", message: "EmpId already exist", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
             self.present(alert, animated: true, completion: nil)
        }else{
            db.insert(emp: empData)
            let obj = (self.storyboard?.instantiateViewController(identifier: "PaySlipViewController"))! as PaySlipViewController
            obj.records = self.db.fetchRecords(empId: self.empData.empId ?? 0)
            self.navigationController?.pushViewController(obj, animated: true)
        }
}

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
   
    
    
}


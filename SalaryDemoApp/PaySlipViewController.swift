//
//  PaySlipViewController.swift
//  SalaryDemoApp
//
//  Created by Shukla, Gaurav on 29/01/21.
//  Copyright © 2021 Shukla, Gaurav. All rights reserved.
//

import UIKit

class PaySlipViewController: UIViewController {
    
       var db:DBHelper = DBHelper()
       var records : [EmpResponse] = []
       var salaryEmp = SalaryEmp()

    @IBOutlet weak var dateOfJoiningLbl: UILabel!
    @IBOutlet weak var empSalaryLbl: UILabel!
    @IBOutlet weak var empIdLbl: UILabel!
    @IBOutlet weak var empNameLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apiCall()
    }
    
    @IBAction func backBtn_Action(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // currency api call
       func apiCall()
       {
           guard let url = URL(string: "https://api.currencyfreaks.com/latest?apikey=8be0c99dc11b4aafa44457c21d38ac8d&format=json") else {return}
           let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
           guard let dataResponse = data,
                     error == nil else {
                     print(error?.localizedDescription ?? "Response Error")
                     return }
               do{
                   //here dataResponse received from a network request
                   let jsonResponse = try JSONSerialization.jsonObject(with:
                                          dataResponse, options: [])
                 //  print(jsonResponse) //Response result
                   guard let resultNew = jsonResponse as? [String:Any] else {
                       return
                   }
                   guard let dic = resultNew["rates"] as? [String: Any] else{
                       return
                   }
                   if let currency = dic["INR"]{
                       let value: String = currency as! String
                       self.salaryEmp.currancy = Double(value)
                       self.convertSalary()
                   }
          
                }  catch let parsingError {
                   print("Error", parsingError)
              }
           }
           task.resume()
       }
       
    func convertSalary()
    {
        let salaryCalculate = (self.salaryEmp.currancy)! * Double(records[0].salary!)
      
        db.update(empId: self.records[0].empId!, salary: Int(salaryCalculate))
        DispatchQueue.main.async {
            self.empNameLbl.text = self.records[0].firstName! + " " + " " + self.records[0].lastNmae!
            self.empIdLbl.text = "\(String(describing: self.records[0].empId!))"
            self.empSalaryLbl.text = "\(String(format: "%.2f", salaryCalculate))"
            self.dateOfJoiningLbl.text = "\(String(describing: self.records[0].date!))"
        }
    }
    
    @IBAction func printBtn_Action(_ sender: Any) {
         let obj = (self.storyboard?.instantiateViewController(identifier: "allEmpSalaryDetails"))! as allEmpSalaryDetails
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
}

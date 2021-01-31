//
//  allEmpSalaryDetails.swift
//  SalaryDemoApp
//
//  Created by Shukla, Gaurav on 31/01/21.
//  Copyright © 2021 Shukla, Gaurav. All rights reserved.
//

import UIKit

class allEmpSalaryDetails: UIViewController {
     var db:DBHelper = DBHelper()
     var records : [EmpResponse] = []
    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        records = db.allRecords1()
        self.tblView.reloadData()
    }
    
    @IBAction func backBtn_Action(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - TableView Delegate

extension allEmpSalaryDetails: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:EmpCell = (tableView.dequeueReusableCell(withIdentifier: "EmpCell") as! EmpCell?)!
        let name = records[indexPath.row].firstName! + " " + records[indexPath.row].lastNmae!
        cell.empNameLBL.text = name
        cell.salaryInr.text =  "\(String(describing: records[indexPath.row].salaryINR!) + " " + "INR")"
        cell.empIdLBL.text =   "\(String(describing: records[indexPath.row].empId!))"
        cell.salaryUsd.text =  "\(String(describing: records[indexPath.row].salary!) + " "  + "USD")"
        cell.dateOfJoining.text = records[indexPath.row].date
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0;//Choose your custom row height
    }
    
}

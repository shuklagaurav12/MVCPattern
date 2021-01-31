//
//  EmpRecordModel.swift
//  SalaryDemoApp
//
//  Created by Shukla, Gaurav on 29/01/21.
//  Copyright © 2021 Shukla, Gaurav. All rights reserved.
//

import Foundation
import UIKit

class Emp {
 
    var firstName : String?
    var lastNmae  : String?
    var empId     : Int32?
    var salary    : Int32?
    var date      : String?
}

class EmpResponse {
      
       var firstName : String?
       var lastNmae  : String?
       var empId     : Int32?
       var salary    : Int32?
       var date      : String?
       var salaryINR : Int32?
    
    init(firstName:String, lastNmae:String, empId:Int32, salary:Int32, date: String, salaryINR: Int32){
      
        self.firstName = firstName
        self.lastNmae = lastNmae
        self.empId = empId
        self.salary = salary
        self.date = date
        self.salaryINR = salaryINR
    }
}

class SalaryEmp {
    var currancy : Double?
}

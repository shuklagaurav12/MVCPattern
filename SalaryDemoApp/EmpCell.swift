//
//  EmpCell.swift
//  SalaryDemoApp
//
//  Created by Shukla, Gaurav on 31/01/21.
//  Copyright © 2021 Shukla, Gaurav. All rights reserved.
//

import UIKit

class EmpCell: UITableViewCell {

    @IBOutlet weak var dateOfJoining: UILabel!
    @IBOutlet weak var salaryInr: UILabel!
    @IBOutlet weak var salaryUsd: UILabel!
    @IBOutlet weak var empIdLBL: UILabel!
    @IBOutlet weak var empNameLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

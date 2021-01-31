//
//  Utility.swift
//  SalaryDemoApp
//
//  Created by Shukla, Gaurav on 29/01/21.
//  Copyright © 2021 Shukla, Gaurav. All rights reserved.
//

import Foundation
import UIKit

public class Utility {
    
    class func setPlaceholderColor(textField: UITextField, placeholderText: String) {
          textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
      }
      
      class func setPlaceholderColorTxt(textField: UITextField, placeholderText: String) {
          textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
      }
    
     //This is my padding function.
    class func textFieldPadding(textFieldName: UITextField) {
         textFieldName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: textFieldName.frame.height))
         textFieldName.leftViewMode = .always
         textFieldName.rightViewMode = .always
     }
    
}

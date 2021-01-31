//
//  DBHelper.swift
//  SalaryDemoApp
//
//  Created by Shukla, Gaurav on 30/01/21.
//  Copyright © 2021 Shukla, Gaurav. All rights reserved.
//

enum SQLiteError: Error {
  case OpenDatabase(message: String)
  case Prepare(message: String)
  case Step(message: String)
  case Bind(message: String)
}

import Foundation

import SQLite3

class DBHelper
{
    
   init()
     {
         db = openDatabase()
         createTable()
     }
    
      let dbPath: String = "myDb.sqlite"
      var db:OpaquePointer?
    
    // open database
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }//INTEGER
    
    // create database table
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS emp(firstName TEXT,lastNmae TEXT,empId INTEGER PRIMARY KEY, salary INTEGER, date TEXT, salaryINR INTEGER);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
   

    // insert value in database table
    func insert(emp : Emp) {
      var insertStatement: OpaquePointer?
      // 1
        let insertStatementString = "INSERT INTO emp (firstName,lastNmae,empId,salary,date,salaryINR) VALUES (?,?,?,?,?,?);"
        
      if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
          SQLITE_OK {
        // 2
       // sqlite3_bind_int(insertStatement, 1, emp.Id ?? 0)
        // 3
        sqlite3_bind_text(insertStatement, 1, (emp.firstName! as NSString).utf8String, -1, nil)
        // 4
        sqlite3_bind_text(insertStatement, 2, (emp.lastNmae! as NSString).utf8String, -1, nil)
        // 5
        sqlite3_bind_int(insertStatement, 3, emp.empId!)
        // 6
        sqlite3_bind_int(insertStatement, 4, emp.salary!)
        // 7
        sqlite3_bind_text(insertStatement, 5, (emp.date! as NSString).utf8String, -1, nil)
        // 8
        sqlite3_bind_int(insertStatement, 6, emp.salary!)
        
        if sqlite3_step(insertStatement) == SQLITE_DONE {
          print("\nSuccessfully inserted row.")
        } else {
          print("\nCould not insert row.")
        }
      } else {
        print("\nINSERT statement is not prepared.")
      }
      // 5
      sqlite3_finalize(insertStatement)
    }
    
   // fetch single record from table
    func fetchRecords(empId: Int32) -> [EmpResponse] {
        
      var queryStatement: OpaquePointer?
      // 1
        let queryStatementString = "SELECT * FROM emp Where empId = \(empId);"
        var records : [EmpResponse] = []
      if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
          SQLITE_OK {
        // 2
        if sqlite3_step(queryStatement) == SQLITE_ROW {
        
          // 4
          let col1 = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
          let col2 = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
          let col3 = sqlite3_column_int(queryStatement, 2)
          let col4 = sqlite3_column_int(queryStatement, 3)
          let col5 = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
          let col6 = sqlite3_column_int(queryStatement, 5)
            records.append(EmpResponse(firstName: col1, lastNmae: col2, empId: col3, salary: col4, date: col5, salaryINR: col6))
           
          // 5
          print("\nQuery Result:")
        
      } else {
          print("\nQuery returned no results.")
      }
      } else {
          // 6
        let errorMessage = String(cString: sqlite3_errmsg(db))
        print("\nQuery is not prepared \(errorMessage)")
      }
      // 7
      sqlite3_finalize(queryStatement)
      return records
    }
    
     // fetch all record from table
        func allRecords1() -> [EmpResponse] {
              
                var queryStatement: OpaquePointer?
                 // 1
                    let queryStatementString = "SELECT * FROM emp"
                   var records : [EmpResponse] = []
                 if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
                     SQLITE_OK {
                   // 2
                   while sqlite3_step(queryStatement) == SQLITE_ROW {
                     // 4
                     let col1 = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                     let col2 = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                     let col3 = sqlite3_column_int(queryStatement, 2)
                     let col4 = sqlite3_column_int(queryStatement, 3)
                     let col5 = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                     let col6 = sqlite3_column_int(queryStatement, 5)
                       records.append(EmpResponse(firstName: col1, lastNmae: col2, empId: col3, salary: col4, date: col5, salaryINR: col6))
                      
                     // 5
                     print("\nQuery Result:")
                   
                 }

                 } else {
                     // 6
                   let errorMessage = String(cString: sqlite3_errmsg(db))
                   print("\nQuery is not prepared \(errorMessage)")
                 }
                 // 7
                 sqlite3_finalize(queryStatement)
                 return records
          }
    

    // update record
    func update(empId : Int32, salary : Int) {
      var updateStatement: OpaquePointer?
      let updateStatementString = "UPDATE emp SET salaryINR = \(salary) WHERE empId = \(empId);"

      if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) ==
          SQLITE_OK {
        if sqlite3_step(updateStatement) == SQLITE_DONE {
          print("\nSuccessfully updated row.")
        } else {
          print("\nCould not update row.")
        }
      } else {
        print("\nUPDATE statement is not prepared")
      }
      sqlite3_finalize(updateStatement)
    }
    
    
    // delete records
    func delete() {
      let deleteStatementString = "DELETE FROM Contact WHERE Id = 1;"
      var deleteStatement: OpaquePointer?
      if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) ==
          SQLITE_OK {
        if sqlite3_step(deleteStatement) == SQLITE_DONE {
          print("\nSuccessfully deleted row.")
        } else {
          print("\nCould not delete row.")
        }
      } else {
        print("\nDELETE statement could not be prepared")
      }
      
      sqlite3_finalize(deleteStatement)
    }
    
    
    
    func prepareMalformedQuery() {
      var malformedStatement: OpaquePointer?
      // 1
      let malformedQueryString = "SELECT Stuff from Things WHERE Whatever;"
      if sqlite3_prepare_v2(db, malformedQueryString, -1, &malformedStatement, nil)
          == SQLITE_OK {
        print("\nThis should not have happened.")
      } else {
        // 2
        let errorMessage = String(cString: sqlite3_errmsg(db))
        print("\nQuery is not prepared! \(errorMessage)")
      }
      
      // 3
      sqlite3_finalize(malformedStatement)
    }
    
    
}

//
//  DetailViewController.swift
//  ToDo List New
//
//  Created by Kushagra Saxena on 29/06/17.
//  Copyright © 2017 Kushagra Saxena. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var listofTasks:[Task] = []
    var taskIndex:Int! = nil
    
    @IBOutlet weak var detailsTextField: UITextField!
    @IBAction func addDetailButton(_ sender: UIButton) {
        guard detailsTextField.text != "" else {
            return
        }
        listofTasks[taskIndex].detail?.append(" " + detailsTextField.text!)
        print("Text added \(listofTasks[taskIndex].detail!)")
        done()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextView.text = listofTasks[taskIndex].detail
        
    }
    @IBAction func taskDeleteButton(_ sender: UIButton) {
        
        listofTasks[taskIndex].completion = false
        appDelegate.persistentContainer.viewContext.delete(listofTasks[taskIndex])
        done()
    }
    
    @IBOutlet weak var myTextView: UITextView!
    
    func done() -> Void
    {
        appDelegate.saveContext()
        performSegue(withIdentifier: "return_segue", sender: nil)
        
    }
    
}

//
//  ViewController.swift
//  ToDo List New
//
//  Created by Kushagra Saxena on 29/06/17.
//  Copyright © 2017 Kushagra Saxena. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,toggleSwitch {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet weak var taskInsertField: UITextField!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var tasks:[Task] = []
    
    
    func CellSwitchToggleON(info: TableViewCell) {
        let index = myTableView.indexPathForRow(at: info.center)!
        tasks[index.row].completion = true
        appDelegate.saveContext()
        myTableView.reloadData()
    }
    func CellSwitchToggleOFF(info: TableViewCell) {
        let index = myTableView.indexPathForRow(at: info.center)!
        tasks[index.row].completion = false
        appDelegate.saveContext()
        myTableView.reloadData()
    }
    
    
    
    @IBAction func addButton(_ sender: UIButton) {
        
        
        guard taskInsertField.text != "" else {
            errorLabel.textColor = .red
            errorLabel.text = "Cannot Create a task without name"
            return}
        let context = appDelegate.persistentContainer.viewContext
        let tempTask = Task(context: context)
        tempTask.name = taskInsertField.text!
        tempTask.completion = false
        appDelegate.saveContext()
        errorLabel.textColor = .black
        errorLabel.text = "Task Saved"
        taskInsertField.text = "Add a new task"
        tasks = self.FetchData()
        myTableView.reloadData()
    }
    
    
    @IBAction func SwitchViewButton(_ sender: UISwitch) {
        
        var incompleteElementList:[Task] = []
        for element in tasks
        {
            
            if(element.completion == false)
            {incompleteElementList.append(element)
                
            }
        }
        if(sender.isOn == true)
        {tasks = incompleteElementList
            myTableView.reloadData()
        }
        else
        {tasks = FetchData()
            myTableView.reloadData()}
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        tasks = FetchData()
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "my_cell") as! TableViewCell
        cell.delegate = self
        cell.listInfoLabel.text = tasks[indexPath.row].name
        if tasks[indexPath.row].completion
        { cell.contentView.backgroundColor = .green
            cell.toggleSwitch.setOn(true, animated: false)}
        else
        { cell.contentView.backgroundColor  = .red
            cell.toggleSwitch.setOn(false, animated: false)}
        cell.contentView.layer.cornerRadius = 8
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.masksToBounds = true
        return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "my_VC") as! DetailViewController
        nvc.taskIndex = indexPath.row
        nvc.listofTasks = tasks
        navigationController?.pushViewController(nvc, animated: true)
    }
    
    
    
    
    func FetchData ()->[Task]
    {
        var tasks:[Task] = []
        do
        {
            let request:NSFetchRequest<Task> = Task.fetchRequest()
            tasks = try appDelegate.persistentContainer.viewContext.fetch(request)
            
        }
        catch
        {   print("error")
        }
        return tasks
    }
    
}


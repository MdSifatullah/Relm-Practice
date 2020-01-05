//
//  ViewController.swift
//  Relm Practice
//
//  Created by Md Sifat on 1/2/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import RealmSwift
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var realm : Realm!
    
    var taskList : Results<Task>{
        get{
            return realm.objects(Task.self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        realm = try! Realm()
        print(realm.configuration.fileURL)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = taskList[indexPath.row]
        cell.textLabel?.text = item.taskName
        print("\(item.taskName)")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
    
    @IBAction func onClickAdd(_ sender: UIButton) {
        
        let newTask = Task()
        
        let alert = UIAlertController(title: "Create New List", message: "Add new item", preferredStyle: .alert)
        alert.addTextField{ (UITextField) in
            UITextField.placeholder = "Enter text ..."
        }
        
        let cancelAlert = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelAlert)
        let saveAlert = UIAlertAction(title: "Save", style: .default, handler: { (UIAlertAction) in
            
            let newTaskText = alert.textFields?.first as! UITextField
            print("Check: \(newTaskText)")
            newTask.taskName = newTaskText.text!
            try! self.realm.write {
                self.realm.add(newTask)
                self.tableView.insertRows(at: [IndexPath.init(row: self.taskList.count - 1, section: 0)], with: .automatic)
                print("Saved")
                
            }
        })
        alert.addAction(saveAlert)
        present(alert, animated: true)
    }
}


//
//  ToDoListTableViewController.swift
//  To-Do-List
//
//  Created by Liam Leahy on 10/10/15.
//  Copyright © 2015 Liam Leahy. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
        
    @IBAction func checkBox(sender: AnyObject) {
        if let checkBox = sender as? CheckBox {
            if !checkBox.isChecked {
                completedTasks += 1
                completed[completedTasks] = NSDate()
                checkBox.index = completedTasks
            } else {
                completed[checkBox.index!] = nil
            }
        }
    }
    
    var tasks = [Task]()
    var completedTasks = 0
    var completed = [Int: NSDate]()
    
    func checkToggled(isChecked: Bool, sender: AnyObject?) {
        if let selected = sender as? ToDoListTableViewCell {
            let indexPath = tableView.indexPathForCell(selected)!
            let selectedTask = tasks[indexPath.row]
            selectedTask.isChecked = isChecked
            if isChecked {
                selectedTask.dateCreated = NSDate()
            }
            completedTasks += 1
        }
    }
    
    func cleanCompleted() -> Int {
        var counter = 0
        for date in completed {
            let time = -date.1.timeIntervalSinceNow
            if time / 3600.0  < 24 {
                counter += 1
            }
        }
        return counter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem()
        if let savedTasks = loadTasks() {
            tasks += savedTasks
            for task in tasks {
                if task.isChecked {
                    completedTasks += 1
                }
            }
        } else {
            loadSampleData()
        }
    }
    
    func loadSampleData() {
        let taskOne = Task(taskName: "Label 1")!
        let taskTwo = Task(taskName: "Label 2")!
        
        tasks += [taskOne, taskTwo]
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let taskIdentifier = "ToDoListTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(taskIdentifier, forIndexPath: indexPath) as! ToDoListTableViewCell
        let task = tasks[indexPath.row]
        cell.cellLabel.text = task.taskName
        cell.isChecked = task.isChecked
        return cell
    }
    
    @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddTaskViewController, task = sourceViewController.task {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tasks[selectedIndexPath.row] = task
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                let newIndexPath = NSIndexPath(forRow: tasks.count, inSection: 0)
                tasks.append(task)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            saveTasks()
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            tasks.removeAtIndex(indexPath.row)
            saveTasks()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let taskDetailViewController = segue.destinationViewController as! AddTaskViewController
            if let selectedTask = sender as? ToDoListTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedTask)!
                let selectedTask = tasks[indexPath.row]
                taskDetailViewController.task = selectedTask
            }
        } else if segue.identifier == "AddItem" {
            print("Adding a new task...")
        } else if segue.identifier == "CompletedTasks" {
            let completedTaskViewController = segue.destinationViewController as! CompletedTasksViewController
            completedTaskViewController.counter = cleanCompleted()
        }
    }
    
    func saveTasks() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tasks, toFile: Task.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save tasks...")
        }
    }
    
    func loadTasks() -> [Task]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Task.ArchiveURL.path!) as? [Task]
    }
    
}

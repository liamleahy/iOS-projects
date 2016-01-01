//
//  AddTaskViewController.swift
//  To-Do-List
//
//  Created by Liam Leahy on 10/11/15.
//  Copyright © 2015 Liam Leahy. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addTaskTextField: UITextField!
    @IBOutlet weak var saveTask: UIBarButtonItem!
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        let isPresentingInAddTaskMode = presentedViewController is UINavigationController
        
        if isPresentingInAddTaskMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    var task = Task?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTaskTextField.delegate = self
        
        if let task = task {
            navigationItem.title = task.taskName
            addTaskTextField.text = task.taskName
        }
        
        checkValidTaskName()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveTask === sender {
            let taskName = addTaskTextField.text ?? ""
            task = Task(taskName: taskName)
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        saveTask.enabled = false
    }
    
    func checkValidTaskName() {
        let text = addTaskTextField.text ?? ""
        saveTask.enabled = !text.isEmpty
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidTaskName()
        navigationItem.title = textField.text
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

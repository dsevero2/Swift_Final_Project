//
//  RoundDetailTableViewController.swift
//  ScoreZ
//
//  Created by Dominic Severo on 4/30/22.
//

import UIKit

class RoundDetailTableViewController: UITableViewController {
    
    var round: Round!
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var courseField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var teesField: UITextField!
    @IBOutlet weak var yardageField: UITextField!
    @IBOutlet weak var frontNineField: UITextField!
    @IBOutlet weak var backNineField: UITextField!
    @IBOutlet weak var totalField: UITextField!
    @IBOutlet weak var resultsField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        if round == nil{
            round = Round()
        }
        
        updateUserInterface()
    
    }
    
    func updateUserInterface() {
        courseField.text = round.course
        datePicker.date = round.date
        teesField.text = round.tees
        yardageField.text = String(round.yardage)
        frontNineField.text = String(round.frontNine)
        backNineField.text = String(round.backNine)
        totalField.text = String(round.total)
        resultsField.text = String(round.result)
        enableDisableSaveButton(text: courseField.text!)
    }
    
    func enableDisableSaveButton(text: String) {
        if text.count > 0 {
            saveBarButton.isEnabled = true
        } else {
            saveBarButton.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue,
      sender: Any?) {
        round = Round(course: courseField.text!, date: datePicker.date, tees: teesField.text!, yardage: Int(yardageField.text!)!, frontNine: Int(frontNineField.text!)!, backNine: Int(backNineField.text!)!, total: Int(totalField.text!)!, result: resultsField.text!)
    }
    
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func textFieldEditingChange(_ sender: UITextField) {
        enableDisableSaveButton(text: sender.text!)
    }
}

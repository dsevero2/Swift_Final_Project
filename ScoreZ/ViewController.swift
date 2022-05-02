//
//  ViewController.swift
//  ScoreZ
//
//  Created by Dominic Severo on 4/30/22.
//

import UIKit

class ViewController: UIViewController {
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter
    }()
    
    var rounds = Rounds()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        rounds.loadData {
            self.tableView.reloadData()
        }
        
    }
    
    func saveData() {
        rounds.saveData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! RoundDetailTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.round = rounds.roundsArray[selectedIndexPath.row]
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
    let source = segue.source as! RoundDetailTableViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            rounds.roundsArray[selectedIndexPath.row] = source.round
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: rounds.roundsArray.count, section: 0)
            rounds.roundsArray.append(source.round)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
        saveData()
    }
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            sender.title = "Edit"
            addBarButton.isEnabled = true
        } else {
            tableView.setEditing(true, animated: true)
            sender.title = "Done"
            addBarButton.isEnabled = false
        }

    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rounds.roundsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RoundTableViewCell
        cell.courseLabel.text = rounds.roundsArray[indexPath.row].course
        cell.dateLabel.text = dateFormatter.string(from: rounds.roundsArray[indexPath.row].date)
        switch rounds.roundsArray[indexPath.row].result.lowercased() {
        case "good":
            cell.courseLabel.textColor = UIColor.green
            cell.dateLabel.textColor = UIColor.green
        case "bad":
            cell.courseLabel.textColor = UIColor.red
            cell.dateLabel.textColor = UIColor.red
        default:
            cell.courseLabel.textColor = UIColor.black
            cell.dateLabel.textColor = UIColor.black
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            rounds.roundsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        saveData()
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = rounds.roundsArray[sourceIndexPath.row]
        rounds.roundsArray.remove(at: sourceIndexPath.row)
        rounds.roundsArray.insert(itemToMove, at: destinationIndexPath.row)
        
        saveData()
    }
}

//
//  ViewController.swift
//  ReminderApp
//
//  Created by Surya Rayala on 2/20/26.
//

import UIKit

class HomeVC: UIViewController {

    var notes: [Note] = []
    var tableView : UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        view.backgroundColor = .white
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        navigationItem.rightBarButtonItem = addButton
        
        tableView = UITableView()
        tableView?.frame = view.bounds
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        if let tableView = tableView {
            view.addSubview(tableView)
        }
    }
}

extension HomeVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = notes[indexPath.row].title
        cell.detailTextLabel?.text = notes[indexPath.row].body
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension HomeVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = NoteDetailVC()
        detailVC.noteIndex = indexPath.row
        
        // Closure to load the note
        detailVC.loadNote = { [weak self] index in
            return self?.notes[index]
        }
        
        // Closure to save the note
        detailVC.saveNote = { [weak self] note, index in
            guard let self = self else { return }
            
            if let index = index {
                self.notes[index] = note
            } else {
                self.notes.append(note)
            }
            
            self.tableView?.reloadData()
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension HomeVC {
    @objc func addNote() {
        let detailVC = NoteDetailVC()
                
        // Closure to save the note
        detailVC.saveNote = { [weak self] note, index in
            guard let self = self else { return }
            
            if let index = index {
                self.notes[index] = note
            } else {
                self.notes.append(note)
            }
            
            self.tableView?.reloadData()
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

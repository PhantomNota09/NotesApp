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
        
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .white
        
        let titleButton = UIBarButtonItem(title: "Notes", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = titleButton
        
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
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil) //  style parameter determines the built-in layout of the cell
        
        cell.textLabel?.text = notes[indexPath.row].title
        cell.textLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        cell.textLabel?.textColor = .systemBlue
        
        cell.detailTextLabel?.text = notes[indexPath.row].body
        cell.detailTextLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        cell.detailTextLabel?.textColor = .lightGray
        cell.detailTextLabel?.numberOfLines = 2
        
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular)
        cell.imageView?.image = UIImage(systemName: "note.text", withConfiguration: config)
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
        
        /*
         style has 4 built in styles:
         
         - .default (Basic style)
             Properties available:
             • cell.textLabel - Main text (left-aligned)
             • cell.imageView - Optional image on the left
         
         - .subtitle
            Properties available:
             • cell.textLabel - Main text (bold, larger)
             • cell.detailTextLabel - Secondary text (smaller, gray)
             • cell.imageView - Optional image on the left
         
         - .value1 (right detail style)
            Properties available:
             • cell.textLabel - Main text (left-aligned)
             • cell.detailTextLabel - Secondary text (right-aligned, blue/gray)
             • cell.imageView - Optional image on the left
         
         - .value2 (contact card style)
             Properties available:
             • cell.textLabel - Label text (right-aligned, blue, small)
             • cell.detailTextLabel - Value text (left side, black)
             • No imageView support
         
        */
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
            if let index = index {
                self?.notes[index] = note // updates the existing note
            } else {
                self?.notes.append(note) // adds new note
            }
            
            self?.tableView?.reloadData()
        }
        
        
        // we need to mention self in closure bcz it is like a seperate mini func tht doesn't automatically belog to HomeVC, if we didnt mention it says cannot find notes in scope bcz it doesnt know where notes comes from
        // if we are using funtion then we dont need to say self since we are inside the method of HomeVC and it automatically knows tht we are referring to the instance's property
        /*
         can use [weak self] - then
         The closure holds a weak reference to HomeVC
         If HomeVC is deallocated, self becomes nil and the closure exits gracefully
         No retain cycle, no memory leak
         */
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension HomeVC {
    @objc func addNote() {
        let detailVC = NoteDetailVC() // strong reference
                
        // Closure to save the note
        detailVC.saveNote = { note, index in
            if let index = index {
                self.notes[index] = note  // ← 'self' refers to HomeVC
                                          // The closure captures HomeVC STRONGLY!
            } else {
                self.notes.append(note)
            }
            
            self.tableView?.reloadData()
        }
        
        // we are not using weak self but still works but now its captured as strongly instead of weekly
        /* This creates a retain cycle:
         • HomeVC owns detailVC (because it pushed it on the navigation stack)
         • detailVC owns the closure (the saveNote property)
         • The closure owns HomeVC (by capturing self strongly)
         
         Result: Even after you pop back, HomeVC might not be deallocated from memory → memory leak
         */
        
        navigationController?.pushViewController(detailVC, animated: true)
        // When pushed to navigation stack, HomeVC keeps a reference to detailVC
        // Neither HomeVC nor detailVC can be deallocated because they're keeping each other alive through the closure!
    }
}

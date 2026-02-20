//
//  NoteDetailVC.swift
//  ReminderApp
//
//  Created by Surya Rayala on 2/20/26.
//

import UIKit

class NoteDetailVC: UIViewController {
    
    var noteIndex: Int?
    var loadNote: ((Int) -> Note?)?  // Closure to load a note which takes an int and returns note
    var saveNote: ((Note, Int?) -> Void)?  // Closure to save a note which takes a note and int and returns nothing
    
    var titleTextField: UITextField?
    var bodyTextField: UITextField?
    var saveButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTitleTextField()
        setupBodyTextField()
        setupSaveButton()
        loadNoteData()
    }
    
    private func setupTitleTextField() {
        titleTextField = UITextField()
        titleTextField?.placeholder = "Title"
        titleTextField?.font = .systemFont(ofSize: 24)
        bodyTextField?.layer.borderWidth = 1
        titleTextField?.translatesAutoresizingMaskIntoConstraints = false
        if let titleTextField = titleTextField {
            view.addSubview(titleTextField)

            NSLayoutConstraint.activate([
                titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                titleTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    }
    
    private func setupBodyTextField() {
        bodyTextField = UITextField()
        bodyTextField?.placeholder = "Body"
        bodyTextField?.font = .systemFont(ofSize: 16)
        bodyTextField?.layer.borderColor = UIColor.gray.cgColor
        bodyTextField?.layer.borderWidth = 1
        bodyTextField?.translatesAutoresizingMaskIntoConstraints = false
        
        if let bodyTextField = bodyTextField, let titleTextField = titleTextField {
            view.addSubview(bodyTextField)
            
            NSLayoutConstraint.activate([
                bodyTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
                bodyTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                bodyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                bodyTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    }
    
    private func setupSaveButton() {
        saveButton = UIButton()
        saveButton?.setTitle("Save", for: .normal)
        saveButton?.backgroundColor = .systemBlue
        saveButton?.layer.cornerRadius = 10
        saveButton?.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton?.translatesAutoresizingMaskIntoConstraints = false
        
        if let saveButton = saveButton, let bodyTextField = bodyTextField {
            view.addSubview(saveButton)
            
            NSLayoutConstraint.activate([
                saveButton.topAnchor.constraint(equalTo: bodyTextField.bottomAnchor, constant: 20),
                saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                saveButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
    }
    
    private func loadNoteData() {
        if let index = noteIndex, let loadNote = loadNote {
            let note = loadNote(index) // this calls the closure passing the index
            titleTextField?.text = note?.title
            bodyTextField?.text = note?.body
        }
    }
    
    @objc func saveButtonTapped() {
        let title = titleTextField?.text ?? ""
        let body = bodyTextField?.text ?? ""
        let note = Note(title: title, body: body)
        
        // Call the closure to save the note
        saveNote?(note, noteIndex)
        
        navigationController?.popViewController(animated: true)
    }
}

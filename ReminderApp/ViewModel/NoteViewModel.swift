//
//  NoteViewModel.swift
//  ReminderApp
//
//  Created by Surya Rayala on 2/20/26.
//

import Foundation

// MARK: - NoteViewModelProtocol

/// Protocol defining the contract for a note view model
protocol NoteViewModelProtocol: AnyObject {
    
    /// Returns the number of notes
    func numberOfNotes() -> Int
    
    /// Returns a note at a specific index
    func note(at index: Int) -> Note?
    
    /// Adds a new note
    func addNote(_ note: Note)
    
    /// Updates an existing note at a specific index
    func updateNote(_ note: Note, at index: Int)
    
    /// Saves a note (either adds new or updates existing)
    func saveNote(_ note: Note, at index: Int?)
}

// MARK: - NoteViewModel

class NoteViewModel: NoteViewModelProtocol {
    
    // MARK: - Properties
    
    private(set) var notes: [Note] = []
    
    // MARK: - Public Methods
    
    /// Returns the number of notes
    func numberOfNotes() -> Int {
        return notes.count
    }
    
    /// Returns a note at a specific index
    func note(at index: Int) -> Note? {
        guard index >= 0 && index < notes.count else { return nil }
        return notes[index]
    }
    
    /// Adds a new note
    func addNote(_ note: Note) {
        notes.append(note)
    }
    
    /// Updates an existing note at a specific index
    func updateNote(_ note: Note, at index: Int) {
        guard index >= 0 && index < notes.count else { return }
        notes[index] = note
    }
    
    /// Saves a note (either adds new or updates existing)
    func saveNote(_ note: Note, at index: Int?) {
        if let index = index {
            updateNote(note, at: index)
        } else {
            addNote(note)
        }
    }
}

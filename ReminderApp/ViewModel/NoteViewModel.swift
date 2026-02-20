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
    /// Callback to notify the view when data changes
    var onNotesUpdated: (() -> Void)? { get set }
    
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
    
    /// Deletes a note at a specific index
    func deleteNote(at index: Int)
    
    /// Clears all notes
    func clearAllNotes()
}

// MARK: - NoteViewModel

class NoteViewModel: NoteViewModelProtocol {
    
    // MARK: - Properties
    
    private(set) var notes: [Note] = []
    
    // Callback to notify the view when data changes
    var onNotesUpdated: (() -> Void)?
    
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
        onNotesUpdated?()
    }
    
    /// Updates an existing note at a specific index
    func updateNote(_ note: Note, at index: Int) {
        guard index >= 0 && index < notes.count else { return }
        notes[index] = note
        onNotesUpdated?()
    }
    
    /// Saves a note (either adds new or updates existing)
    func saveNote(_ note: Note, at index: Int?) {
        if let index = index {
            updateNote(note, at: index)
        } else {
            addNote(note)
        }
    }
    
    /// Deletes a note at a specific index
    func deleteNote(at index: Int) {
        guard index >= 0 && index < notes.count else { return }
        notes.remove(at: index)
        onNotesUpdated?()
    }
    
    /// Clears all notes
    func clearAllNotes() {
        notes.removeAll()
        onNotesUpdated?()
    }
}

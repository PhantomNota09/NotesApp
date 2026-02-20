//
//  NoteStorage.swift
//  ReminderApp
//
//  Created by Surya Rayala on 2/20/26.
//

import Foundation

/* help taken by AI
class NoteStorage {
    static let shared = NoteStorage()
    
    private let userDefaultsKey = "SavedNotes"
    
    private init() {}
    
    func saveNotes(_ notes: [Note]) {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    func loadNotes() -> [Note] {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let notes = try? JSONDecoder().decode([Note].self, from: data) else {
            return []
        }
        return notes
    }
}
*/

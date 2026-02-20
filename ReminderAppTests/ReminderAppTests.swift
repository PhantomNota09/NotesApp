//
//  ReminderAppTests.swift
//  ReminderAppTests
//
//  Created by Surya Rayala on 2/20/26.
//

import XCTest
@testable import ReminderApp

final class ReminderAppTests: XCTestCase {
    
    var viewModel: NoteViewModel!

    override func setUpWithError() throws {
        viewModel = NoteViewModel()
    }

    override func tearDownWithError() throws {
    }
    
    // MARK: - Test numberOfNotes
    
    func testNumberOfNotes_WhenEmpty_ReturnsZero() throws {
        // Given: ViewModel with no notes
        
        // When
        let count = viewModel.numberOfNotes()
        
        // Then
        XCTAssertEqual(count, 0, "Expected 0 notes in empty view model")
    }
    
    func testNumberOfNotes_AfterAddingNotes_ReturnsCorrectCount() throws {
        // Given
        let note1 = Note(title: "Note 1", body: "Body 1")
        let note2 = Note(title: "Note 2", body: "Body 2")
        
        // When
        viewModel.addNote(note1)
        viewModel.addNote(note2)
        
        // Then
        XCTAssertEqual(viewModel.numberOfNotes(), 2, "Expected 2 notes after adding two notes")
    }
    
    // MARK: - Test addNote
    
    func testAddNote_AddsNoteSuccessfully() throws {
        // Given
        let note = Note(title: "Test Note", body: "Test Body")
        
        // When
        viewModel.addNote(note)
        
        // Then
        XCTAssertEqual(viewModel.numberOfNotes(), 1)
        XCTAssertEqual(viewModel.note(at: 0)?.title, "Test Note")
        XCTAssertEqual(viewModel.note(at: 0)?.body, "Test Body")
    }
    
    func testAddNote_TriggersCallback() throws {
        // Given
        let note = Note(title: "Test Note", body: "Test Body")
        let expectation = expectation(description: "onNotesUpdated callback should be called")
        
        viewModel.onNotesUpdated = {
            expectation.fulfill()
        }
        
        // When
        viewModel.addNote(note)
        
        // Then
        waitForExpectations(timeout: 1.0)
    }
    
    // MARK: - Test updateNote
    
    func testUpdateNote_WithValidIndex_UpdatesNote() throws {
        // Given
        let originalNote = Note(title: "Original", body: "Original Body")
        viewModel.addNote(originalNote)
        
        let updatedNote = Note(title: "Updated", body: "Updated Body")
        
        // When
        viewModel.updateNote(updatedNote, at: 0)
        
        // Then
        XCTAssertEqual(viewModel.numberOfNotes(), 1, "Should still have only 1 note")
        XCTAssertEqual(viewModel.note(at: 0)?.title, "Updated")
        XCTAssertEqual(viewModel.note(at: 0)?.body, "Updated Body")
    }
    
    func testUpdateNote_WithInvalidIndex_DoesNothing() throws {
        // Given
        let originalNote = Note(title: "Original", body: "Original Body")
        viewModel.addNote(originalNote)
        
        let updatedNote = Note(title: "Updated", body: "Updated Body")
        
        // When
        viewModel.updateNote(updatedNote, at: 5)
        
        // Then
        XCTAssertEqual(viewModel.numberOfNotes(), 1, "Should still have only 1 note")
        XCTAssertEqual(viewModel.note(at: 0)?.title, "Original", "Original note should be unchanged")
    }
    
    func testUpdateNote_TriggersCallback() throws {
        // Given
        let originalNote = Note(title: "Original", body: "Original Body")
        viewModel.addNote(originalNote)
        
        let updatedNote = Note(title: "Updated", body: "Updated Body")
        let expectation = expectation(description: "onNotesUpdated callback should be called")
        
        viewModel.onNotesUpdated = {
            expectation.fulfill()
        }
        
        // When
        viewModel.updateNote(updatedNote, at: 0)
        
        // Then
        waitForExpectations(timeout: 1.0)
    }
    
    // MARK: - Test saveNote
    
    func testSaveNote_WithNilIndex_AddsNewNote() throws {
        // Given
        let note = Note(title: "New Note", body: "New Body")
        
        // When
        viewModel.saveNote(note, at: nil)
        
        // Then
        XCTAssertEqual(viewModel.numberOfNotes(), 1)
        XCTAssertEqual(viewModel.note(at: 0)?.title, "New Note")
    }
    
    func testSaveNote_WithValidIndex_UpdatesExistingNote() throws {
        // Given
        let originalNote = Note(title: "Original", body: "Original Body")
        viewModel.addNote(originalNote)
        
        let updatedNote = Note(title: "Updated", body: "Updated Body")
        
        // When
        viewModel.saveNote(updatedNote, at: 0)
        
        // Then
        XCTAssertEqual(viewModel.numberOfNotes(), 1)
        XCTAssertEqual(viewModel.note(at: 0)?.title, "Updated")
    }
}

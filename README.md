# Notes App

A simple and elegant notes application built with UIKit, demonstrating modern iOS development patterns including MVVM architecture, dependency injection, and protocol-oriented programming.

## Features

- **Create Notes**: Add new notes with a title and body
- **View Notes**: Browse all your notes in a clean, organized list
- **Edit Notes**: Tap on any note to view and edit its contents
- **Modern UI**: Clean interface with SF Symbols and UIKit components
- **MVVM Architecture**: Separation of concerns with view models and protocols

## Architecture

This project follows the **MVVM (Model-View-ViewModel)** pattern with protocol-oriented design:

### Components

- **Model** (`Note.swift`): Simple data structure for notes
  - `title`: String
  - `body`: String

- **ViewModel** (`NoteViewModel.swift`): Business logic and data management
  - Protocol-driven design with `NoteViewModelProtocol`
  - CRUD operations for notes
  - Data binding through closures

- **View** (`HomeVC.swift`, `NoteDetailVC.swift`): UI layer
  - `HomeVC`: List view displaying all notes
  - `NoteDetailVC`: Detail view for creating/editing notes

### Design Patterns

- ✅ **Dependency Injection**: View models are injected into view controllers
- ✅ **Protocol-Oriented Programming**: Views communicate with view models through protocols
- ✅ **Closure-Based Communication**: Data flow between view controllers using closures
- ✅ **Memory Safety**: Proper use of `[weak self]` to prevent retain cycles

## Example

![Simulator Screen Recording - iPhone 17 Pro - 2026-02-20 at 12 02 52](https://github.com/user-attachments/assets/f3717e12-3aa2-4865-8bcd-958e63e16375)


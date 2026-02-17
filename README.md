# Offline-First Task Manager App

This is a Flutter mobile application that allows users to manage tasks with full offline support.  
The app focuses on clean architecture, proper state management, and a polished user experience.



## Objective

The goal of this project is to demonstrate:

- Clean Architecture principles
- Proper separation of concerns (Data, Domain, Presentation)
- Offline-first functionality using local storage
- Structured state management using BLoC
- Clean, maintainable, and scalable code



## Features

### Task Management
- Create tasks
- Edit tasks
- Delete tasks
- Mark tasks as completed
- Each task includes:
    - Title (required)
    - Description (optional)
    - Due date (optional)
    - Priority (Low / Medium / High)
    - Completion status



### Offline Support
- All tasks are stored locally on the device
- Data persists between app launches
- Local storage implemented using **Hive** 



### Filtering
- View All tasks
- View Completed tasks
- View Pending tasks



### UI / UX
- Task list screen with visual priority indicators
- Checkbox/toggle for completion
- Add/Edit task screen with form validation (title required)
- Proper empty state when no tasks exist
- Subtle animation for task insertion/removal



## Additional Enhancements

- Search tasks by title
- Swipe to delete with Undo (SnackBar)



## Architecture

The project follows **Clean Architecture** principles with clear separation of layers.


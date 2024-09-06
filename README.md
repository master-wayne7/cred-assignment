# Flutter Assignment 2024

This project is a two-page category selection app, developed as part of the **CRED Assignment**. It implements responsive design for mobile devices, leverages **Bloc** and **Cubit** for state management, and uses **Dio** for network calls.

## Objective

The objective of this assignment is to implement an interactive category selection app with two pages:

- **Page 1** (Home Page): Displays the selected category from Page 2, or a placeholder if no category is selected.
- **Page 2** (Categories Page): Allows the user to toggle between grid and list views and select a category, which is then passed back to Page 1.

## Features

1. **State Management**:
   - The app uses **Bloc** and **Cubit** to handle state management efficiently.
   - The selected category is managed using Cubit.

2. **Network Calls**:
   - **Dio** is used to handle network requests. The app fetches data for the categories page from an API.

3. **Responsive Design**:
   - The app layout is designed to be fully responsive, adjusting to various mobile device screen sizes.

4. **Grid and List Animation**:
   - The categories page includes a toggle switch to transition between grid and list layouts with smooth animations.

5. **Navigation**:
   - Page navigation is implemented between the home and categories pages. After selecting a category, the user is redirected back to the home page with the selected category displayed.

## Technical Details

### 1. Home Page (Page 1)

- Displays the **selected category** or a placeholder if no category has been chosen yet.
- Contains a **button** to navigate to the categories page.

### 2. Categories Page (Page 2)

- Displays categories under subcategories.
- Contains a **toggle button** to switch between grid and list layouts, with animation.
- Clicking a category closes the page and sends the selected category back to the home page.

## Network Integration

The app uses the **Dio** package to make a network call to fetch categories. Here's the sample API endpoint used:
`https://api.mocklets.com/p6839/explore-cred`

## State Management

State management is handled using **Cubit** (from `flutter_bloc` package), which manages the current selected category and layout state (grid or list).

### Dependencies

This project uses the following dependencies:

- `flutter_bloc`: For state management using Bloc and Cubit.
- `dio`: For making network calls.
- `equatable`: To simplify state comparison in Bloc.

## How to Run

### 1. Clone the Repository

```bash
git clone https://github.com/master-wayne7/cred-assignment.git
cd cred-assignment
```

### 2. Install depedencies

```bash
flutter pub get
```

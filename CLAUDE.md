# Quasar Project Guidelines

## Project Overview
Quasar is a mobile application built with Flutter, targeting iOS and Android platforms.

## Code Style Guidelines

### Comments Policy
- **DO NOT write code-level comments** in the source code
- Code should be self-explanatory through clear naming and structure
- If code needs explanation, refactor it to be more readable instead of adding comments
- Only exception: Complex algorithms or business logic that absolutely requires documentation

### Code Quality
- Use descriptive variable and function names that explain their purpose
- Keep functions small and focused on a single responsibility
- Prefer clean, readable code over clever or complex solutions

## Project Structure
- `lib/` - Main Dart source code
- `ios/` - iOS native platform code
- `android/` - Android native platform code

### Standards Reference
- Follow Flutter project structure standards from: https://changjoo-park.github.io/learn-flutter/part1/project-structure/#%EA%B3%84%EC%B8%B5%EB%B3%84-%EA%B5%AC%EC%A1%B0-layer-first

## UI/UX Guidelines

### Design System
- Use Material Design 3 components and patterns
- Follow Material Design guidelines for consistency across the app

### Button Design
- **All buttons must use iOS flat design style**
- Remove elevation/shadow from buttons (`elevation: 0`)
- Use flat colors without depth effects
- Prefer simple, clean button styles without Material-style shadows

### Input Field Design
- **Follow iOS flat design style for all input fields**
- Background color must match the theme's scaffold background color
- Use `filled: true` with `fillColor: Theme.of(context).scaffoldBackgroundColor`
- Apply subtle borders using `OutlineInputBorder()`
- For TextField:
  ```dart
  TextField(
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      filled: true,
      fillColor: Theme.of(context).scaffoldBackgroundColor,
    ),
  )
  ```
- For InputDecorator (date/time pickers):
  ```dart
  InputDecorator(
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      filled: true,
      fillColor: Theme.of(context).scaffoldBackgroundColor,
    ),
  )
  ```
- Avoid heavy shadows or Material-style elevation effects
- Keep input fields clean and minimal

### Pull-to-Refresh
- All list pages should implement pull-to-refresh functionality
- Use `RefreshIndicator` widget wrapping scrollable content
- The refresh action should reload the data and update the UI

## Development Notes
- App name: Quasar
- Package: com.quasar.quasar
- Supported platforms: iOS and Android only

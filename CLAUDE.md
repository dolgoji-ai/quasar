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

## Development Notes
- App name: Quasar
- Package: com.quasar.quasar
- Supported platforms: iOS and Android only

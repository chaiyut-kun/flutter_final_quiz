# Project Description
This project is making for final quiz in Native Mobile subject

# Assignments
- [ ] Making `To-Do list app` that store data on localstorage
- [ ] This app must have `CRUD of to-do` function
- [ ] checkbox for `done task` and strikethrough text after check
- [ ] Data of app (to-do task, status of task) must still on storage event app is close
- [ ] Display seperate by status (to-do, in-progress, done)

# Things Agent can do
- following by # Assignments. as main to do things 
- planning for concept and tools (library, UI tools, storage) that fit with this project
- alway remember that project is Mobile-Based App (must be run in android correctly)
- Design UI that fits with # Assignments.

# Rule
- you can clean code but make sure the code is easy to read first.
- Comment as human comment (try not to overcomment with emoji)

# Testing (Following Flutter Testing Standards)
Instruction for Gemini Agent: When generating or refactoring tests for this Flutter project, you must strictly adhere to the following guidelines and architectural patterns.

🎯 1. General Testing Principles
AAA Pattern: Every test must follow the Arrange-Act-Assert structure for clarity.
Descriptive Naming: Test descriptions must clearly state the expected behavior (e.g., should emit [Loading, Success] when data is fetched successfully).
olation: Never use real network calls or local databases. Always use Mocks or Fakes.

Single Responsibility: Each test case should focus on testing one specific behavior or edge case.

2. Unit Testing (Logic & State)
Mocking Library: Prefer mocktail over mockito to avoid code generation (build_runner) dependency.
Target Areas: Focus on Business Logic in Repositories, Use Cases, and State Management (BLoC, Riverpod, or Cubit).
Error Handling: Always include test cases for failure scenarios (e.g., throws Exception, returns ErrorState).
Streams/Futures: Use emitsInOrder or bloc_test to verify asynchronous state sequences.

3. Widget Testing (UI Components)
Viewport Consistency: Assume a standard mobile resolution (e.g., 1080x1920) unless otherwise specified.
Frame Pumping: Use tester.pumpAndSettle() to wait for animations and microtasks to complete.
Finders: Use specific finders like find.byKey() for critical elements and find.text() for content verification.
Accessibility: Ensure key interactive elements have valid Semantics (labels, hints, etc.).

4. Code Style & Structure
Grouping: Use group() to categorize tests by method name or feature set.
Setup/Teardown: Utilize setUp() for common initializations and tearDown() to clean up mocks.
Clean Code: Avoid hardcoding strings or magic numbers; use constants or shared mock data factories.
Matchers: Use appropriate matchers such as isA<Type>(), contains(), or equals().

5. Deliverables & Communication
Explanation: Briefly explain the "Why" behind complex test scenarios.
Refactoring: If the existing code is "untestable" (e.g., tight coupling), suggest specific Dependency Injection improvements before writing the test.
Coverage: Aim for high logic coverage, prioritizing critical user paths.
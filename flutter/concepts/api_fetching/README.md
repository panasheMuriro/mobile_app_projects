# Networking in Flutter
- In this lesson, you’ll learn how to fetch data from REST APIs using Flutter. 
- Networking is essential for apps that need dynamic data from external sources like a server or database. 
- By the end of the lesson, you'll build a simple app that fetches and displays data from a public API.


## Objective:
- Understand how to make HTTP requests in Flutter using the http package and parse JSON data. 
- Learn best practices for error handling and displaying fetched data in a user-friendly way.


## Best Practices for Networking

1. Error Handling:
-  Always check statusCode in HTTP responses.
- Handle exceptions using try-catch blocks to prevent app crashes.

2. Decoupling Logic:
- Keep networking code in a separate service file (like api_service.dart) for cleaner and more maintainable code.

3. Optimizing API Calls:
- Cache responses when possible to reduce redundant API calls.
- Avoid frequent calls by implementing debounce logic for input fields.

// Purpose: This part of the program is responsible for creating strings.
// It provides a method to either take user input or generate a random string.
// This is used for creating status messages in the InfiniVerse game.

import 'dart:math';
import 'dart:io';

class StringEngine {
  // Method to create a string based on user input or random selection
  String createString(String userInput) {
    if (userInput.isNotEmpty) {
      return userInput;  // If user provides input, use it as the string
    } else {
      // If user input is empty, generate a random string
      List<String> randomStrings = [
        "Hello, InfiniVerse!",
        "This is so much fun!",
        "Infinite possibilities await!",
        "Coding is magic!",
        "I love Dart programming!",
      ];

      return randomStrings[Random().nextInt(randomStrings.length)];
    }
  }
}

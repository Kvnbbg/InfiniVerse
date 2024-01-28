// Purpose: This part of the program simulates the InfiniVerse game.
// It has a class `InfiniVerse` with methods to add names, share statuses,
// and print the current status of the InfiniVerse. It handles error cases
// and ensures smooth sharing of statuses between clients.

class InfiniVerse {
  // Map to store names and their corresponding statuses
  Map<String, List<String>> data = {};

  // Method to share a status from one client to another
  void shareStatus(String fromName, String toName, String status) {
    if (!data.containsKey(fromName)) {
      // Handle the case where the sender's name is not in InfiniVerse
      print("Oops! $fromName doesn't exist in InfiniVerse. Try another name!");
      return;
    }

    if (!data.containsKey(toName)) {
      // Handle the case where the receiver's name is not in InfiniVerse
      print("Oh no! $toName is not part of InfiniVerse. Choose someone else!");
      return;
    }

    data[toName] ??= [];
    data[toName].add("$fromName shares: $status");
    print("Status shared successfully from $fromName to $toName: $status");
  }

  // Method to print the current status of InfiniVerse
  void printStatus() {
    print("\nInfiniVerse Status:");
    if (data.isEmpty) {
      print("InfiniVerse is empty. Add some names and messages!");
    } else {
      for (var entry in data.entries) {
        print("${entry.key}: ${entry.value.join(', ')}");
      }
    }
    print("\n");
  }
}

import 'package:flutter/material.dart';

// Purpose: This is the main program that integrates the three parts.
// It includes user interaction, name addition, status sharing, and status
// transformation. The main program uses instances of the StringEngine,
// InfiniVerse, and StatusTransformer classes to create, share, and transform
// statuses within the InfiniVerse game.

void main() {
  // Instantiate the StringEngine, InfiniVerse, and StatusTransformer
  StringEngine stringEngine = StringEngine();
  InfiniVerse infiniVerse = InfiniVerse();
  StatusTransformer statusTransformer = StatusTransformer();
  Random random = Random();

  print("Welcome to InfiniVerse - The Infinite Fun Game!");

  // User interaction loop
  while (true) {
    print("\nWhat would you like to do?");
    print("1. Add a name");
    print("2. Share a message");
    print("3. See InfiniVerse status");
    print("4. Quit");

    String choice = stdin.readLineSync() ?? "";

    switch (choice) {
      // Case 1: Add a name to InfiniVerse
      case "1":
        print("Enter a name:");
        String name = stdin.readLineSync()!;
        infiniVerse.data[name] = [];
        print("Welcome, $name! You are now part of InfiniVerse!");
        break;

      // Case 2: Share a status between clients
      case "2":
        if (infiniVerse.data.isEmpty) {
          print("InfiniVerse is empty. Add some names before sharing messages!");
        } else {
          print("Enter sender's name:");
          String fromName = stdin.readLineSync()!;
          print("Enter receiver's name:");
          String toName = stdin.readLineSync()!;

          print("Do you want to create your own status? (y/n)");
          String createStatusChoice = stdin.readLineSync()?.toLowerCase() ?? "n";
          String status = "";

          if (createStatusChoice == "y") {
            print("Enter your status:");
            status = stdin.readLineSync()!;
          } else {
            status = stringEngine.createString("");
          }

          // Share the original status
          infiniVerse.shareStatus(fromName, toName, status);

          // Transform the status before sharing it to others
          String transformedStatus = statusTransformer.transformStatus(status);

          // Share the transformed status with other random clients
          List<String> otherClients = infiniVerse.data.keys.where((name) => name != toName).toList();
          if (otherClients.isNotEmpty) {
            String randomClient = otherClients[random.nextInt(otherClients.length)];
            infiniVerse.shareStatus(fromName, randomClient, transformedStatus);
          }
        }
        break;

      // Case 3: Print the current status of InfiniVerse
      case "3":
        infiniVerse.printStatus();
        break;

      // Case 4: Quit the program
      case "4":
        print("Exiting InfiniVerse. Thank you for playing! Come back soon!");
        return;

      // Default case: Handle invalid choices
      default:
        print("Invalid choice. Please try again.");
        break;
    }
  }

  runApp(MyApp());
}

class ImageProcessor {
  Future<String> scrapeImage() async {
    // Simulated delay for demonstration purposes
    await Future.delayed(Duration(seconds: 2));
    // Simulated scraped image data
    return 'Scraped image data';
  }

  // Pixilize function would go here to perform image processing
  // void pixilize(String imageData) {
  //   // Simulates pixilation process
  //   // ...
  // }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Puzzle Piece Animation',
      theme: ThemeData(
	primarySwatch: Colors.blue,
	visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
	future: ImageProcessor().scrapeImage(),
	builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
	  if (snapshot.connectionState == ConnectionState.waiting ||
	      !snapshot.hasData) {
	    return LoadingScreen(); // Show loading animation
	  } else if (snapshot.hasError) {
	    return Scaffold(
	      appBar: AppBar(
		title: Text('Error'),
	      ),
	      body: Center(
		child: Text('Error: ${snapshot.error}'),
	      ),
	    );
	  } else {
	    // Process the image data and return the animated widget
	    // ImageProcessor().pixilize(snapshot.data);
	    return PuzzlePieceAnimation();
	  }
	},
      ),
    );
  }
}

class PuzzlePieceAnimation extends StatefulWidget {
  @override
  _PuzzlePieceAnimationState createState() => _PuzzlePieceAnimationState();
}

class _PuzzlePieceAnimationState extends State<PuzzlePieceAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    _controller.repeat(reverse: true); // Auto-reverse the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
	title: Text('Puzzle Piece Animation'),
      ),
      body: Center(
	child: AnimatedBuilder(
	  animation: _animation,
	  builder: (BuildContext context, Widget child) {
	    return Opacity(
	      opacity: _animation.value,
	      child: Container(
		width: 200,
		height: 200,
		color: Colors.blue, // Placeholder color
		child: Center(
		  child: Text(
		    'Pixilizing...',
		    style: TextStyle(
		      fontSize: 20,
		      color: Colors.white,
		    ),
		  ),
		),
	      ),
	    );
	  },
	),
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
	title: Text('Loading...'),
      ),
      body: Center(
	child: CircularProgressIndicator(),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
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

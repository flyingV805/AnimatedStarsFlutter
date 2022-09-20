
# AnimatedStarsView

AnimatedStarsView for Flutter 

Pure Dart implementation of [AnimatedStarsView](https://github.com/sofakingforever/animated-stars-android)

## Getting Started

### Step 1
Add library to your pubspec.yaml

```yaml
dependencies:
  starsview: '^0.0.1'
```

### Step 2
Add StarsView to your widget tree

```dart
@override  
Widget build(BuildContext context) {  
  return MaterialApp(  
    home: Scaffold(  
      body: SafeArea(  
	child: Stack(  
	  children: <Widget>[  
	    Container(  
	      decoration: const BoxDecoration(  
	        gradient: LinearGradient(  
		  begin: Alignment.topRight,  
		  end: Alignment.bottomLeft,  
		  colors: <Color>[  
		    Colors.red,  
		    Colors.blue,  
		  ],  
		)  
	      )  
	    ),  
	    StarsView(  
	      fps: 60,  
	    )  
	  ],  
	),  
      ),  
    ),  
  );  
}
```

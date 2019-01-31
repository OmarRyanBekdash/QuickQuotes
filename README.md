# QuickQuotes
**IMPORTANT
When Downloading, the cocoapods will throw errors.
Go through the motions: Install the cocoapods through terminal.
The podfile should be ready to go, just do "pod install" in the correct
directory.
THEN, go to the project and comment ONLY the parts of the project that 
are throwing compile errors, and nothing else
If you comment out the right parts, then the code is intact
but the constraints for one ViewController aren't set up
(So the PreferencesViewController is useless basically). When the code is 
intact, you can successfully build it. AFTER BUILDING:
don't press anything. Go back to the code and uncomment 
everything you commented before. Building the project should
have allowed the cocoapods to be recognized. Now the app is usable.

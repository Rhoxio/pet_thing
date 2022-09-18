## Intro Pet Program

Pet should be able to:  
 - Eat
 - Play
 - Sleep

### Kevin's Changes MK I
I went ahead and set up the correct environment load paths and set up spec_helper to autoload the models and utlities needed for all of the tests. I also set up a 'run.rb' file to keep starting the app outside of the scope of modeling the app. This was also required to make sure that the files didn't end up being double-loaded. 

### Kevin's Changes MK II
Dried up the validator code, removed parends on method names, fixed tests, and set global variables for reference as well as dynamic access to energy limits in the app using symbol-based class name lookups. Moves energy references in pet.rb to global values. Changed 'sleep' and 'rest' vernacular to match up with expected uses of 'sleep' and 'rest' in the context of the Ruby ecosystem. Pets 'rest', Ruby 'sleep's. 

### Kevin's Changes MK III
Fixed up logging and added clarity to the naming conventions around actions. Switched 'menu' to a return to menu action and made it into the 'foods' command instead. Added more explicit logging and the option to escape from the food making process by typing 'exit'. Added 'bars' for spacing clarity. 
//Mohammad and Niklas DDU. Genetic Algorithm Project

//Amount of Combinations to be done
int correctCombinations, babiesProduced = 0;
int currentGeneration = 1;
int population = 500;
int chooseParentSize = population*4; 
int generationsCreated = 100;
float mutationRate = 0.01;
boolean TestCombiCheck, continueRunning = true;
float zoomX, zoomY, scaledZoom, rectWidth, averageFitness;

//Array for itemList
Items[] itemList = new Items[24];
int[][] validItemCombis = new int[population][24];
int[][] newGeneration = new int[population][24];


//Name of the item objects (there are a lot, and they all have unique values, like their names, so we have to make each one)
Items Map;
Items Compas;
Items Water;
Items Sandwich;
Items Sugar;
Items Cannedfood;
Items Banana;
Items Apple;
Items Cheese;
Items Beer;
Items Sunscreen;
Items Camera;
Items TShirt;
Items Pants;
Items Parasol;
Items WaterproofPants;
Items WaterproofOuterwear;
Items Wallet;
Items Sunglasses;
Items Towel;
Items Socks;
Items Book;
Items Notebook;
Items Tent;

void setup() {
  size(500, 500);
  background(255);
  frameRate(120);
  zoomX = width/generationsCreated;
  zoomY = height/12;
  scaledZoom = width/generationsCreated;
  rectWidth = zoomX;


  //Constructing the items with Name, Weight and Value
  Map = new Items("Map", 90, 150);
  itemList[0] = Map;

  Compas = new Items("Compas", 130, 35);
  itemList[1] = Compas;

  Water =  new Items("Water", 1530, 200);
  itemList[2] = Water;

  Sandwich = new Items("Sandwich", 500, 160);
  itemList[3] = Sandwich;

  Sugar = new Items("Sugar", 150, 60);
  itemList[4] = Sugar;

  Cannedfood = new Items("Cannedfood", 680, 45);
  itemList[5] = Cannedfood;

  Banana = new Items("Banana", 270, 60);
  itemList[6] = Banana;

  Apple = new Items("Apple", 390, 40);
  itemList[7] = Apple;

  Cheese = new Items("Cheese", 230, 30);
  itemList[8] = Cheese;

  Beer = new Items("Beer", 520, 10);
  itemList[9] = Beer;

  Sunscreen = new Items("Sunscreen", 110, 70);
  itemList[10] = Sunscreen;

  Camera = new Items("Camera", 320, 30);
  itemList[11] = Camera;

  TShirt = new Items("TShirt", 240, 15);
  itemList[12] = TShirt;

  Pants = new Items("Pants", 480, 10);
  itemList[13] = Pants;

  Parasol = new Items("Parasol", 730, 40);
  itemList[14] = Parasol;

  WaterproofPants = new Items("WaterproofPants", 420, 70);
  itemList[15] = WaterproofPants;

  WaterproofOuterwear = new Items("WaterproofOuterwear", 430, 75);
  itemList[16] = WaterproofOuterwear;

  Wallet = new Items("Wallet", 220, 80);
  itemList[17] = Wallet;

  Sunglasses = new Items("Sunglasses", 70, 20);
  itemList[18] = Sunglasses;

  Towel = new Items("Towel", 180, 12);
  itemList[19] = Towel;

  Socks = new Items("Socks", 40, 50);
  itemList[20] = Socks;

  Book = new Items("Book", 300, 10);
  itemList[21] = Book;

  Notebook = new Items("Notebook", 900, 1);
  itemList[22] = Notebook;

  Tent = new Items("Tent", 2000, 150);
  itemList[23] = Tent;

  TestCombiCheck = false;
}



void draw() {
  translate(0, height);
  frame();

  if (continueRunning) {
    //for (int i = 0; i < CombAmount; i++) {
    while (correctCombinations < population) {
      Combinations TestCombi = new Combinations(0);

      //Prints all the correct combinations where weight is below the limit
      if (correctCombinations < population) {
        if (TestCombi.getWeight() < 5001) { 
          //TestCombi.printCombi();
          //println("Value: " + TestCombi.getValue());
          //println("Weight: " +  TestCombi.getWeight());
          TestCombiCheck = true;

          //Stores the correct combinations into a new array with the name validItemCombis.
          for (int x = 0; x < 24; x++) {
            validItemCombis[correctCombinations][x] = TestCombi.combination[x];
          }
          //println();  //used throughout the code to create a little space between elements in the console
          correctCombinations++;
        }
      }

      //Doesnt print anything if the weight over the limit
      if (TestCombi.getWeight() > 5000) {
        TestCombiCheck = false;
      }
    }


    ////Prints all combinations inside the array validItemCombis
    ////Also prints the Value, Weight, Fitness and the Fitness ratio
    //for (int i = 0; i < 24; i++) {
    //  for (int x = 0; x < 24; x++) {
    //    print(validItemCombis[i][x]);
    //    //println();
    //  }
    //  println();
    //  println("Value: " + getValue(i, validItemCombis));
    //  println("Weight: " + getWeight(i, validItemCombis));
    //  println("Fitness is: " + getValue(i, validItemCombis));
    //  println("scaledFitness is: " + getScaledFitness(i, population, validItemCombis));
    //  println();
    //}
    println();
    println();
    println();
    println();
    println();

    //Prints the Generation number and the total fitness
    //for first generation
    averageFitness = getTotalFitness(population, validItemCombis)/population;
    println("Current Generation: " + currentGeneration);
    println("The average fitness for Current Generation: " + averageFitness);
    graphFirst(-averageFitness);
    println();
    
    //for second generation
    crossover(validItemCombis, newGeneration);
    averageFitness = getTotalFitness(population, newGeneration)/population;
    println("Current Generation: " + currentGeneration);
    println("The average fitness for Current Generation: " + averageFitness);
    graphSecond(-averageFitness);
    println();

    int generationSwitcher = 0;
    for (int i = 0; i < generationsCreated-2; i++) {
      crossover(newGeneration, newGeneration);
      averageFitness = getTotalFitness(population, newGeneration)/population;
      println("Current Generation: " + currentGeneration);
      println("The average fitness for Current Generation: " + averageFitness);
      graphRemaining(i*rectWidth + rectWidth*2, -averageFitness);

      //println("Current Generation: " + currentGeneration);
      //if (generationSwitcher == 0) {
      //  crossover(newGeneration, validItemCombis);
      //  generationSwitcher = 1;
      //  println("The average fitness for Current Generation: " + getTotalFitness(population, validItemCombis)/population);
      //} else {
      //  crossover(validItemCombis, newGeneration);
      //  generationSwitcher = 0;
      //  println("The average fitness for Current Generation: " + getTotalFitness(population, newGeneration)/population);
      //}

      println();
    }

    println();
    println();

    ////Prints all combinations inside the array newGeneration
    ////Also prints the Value, Weight, Fitness and the Fitness ratio
    //for (int i = 0; i < 24; i++) {
    //  for (int x = 0; x < 24; x++) {
    //    print(newGeneration[i][x]);
    //    //println();
    //  }
    //  println();
    //  println("Value: " + getValue(i, newGeneration));
    //  println("Weight: " + getWeight(i, newGeneration));
    //  println("Fitness is: " + getValue(i, newGeneration));
    //  println("scaledFitness is: " + getScaledFitness(i, population, newGeneration));
    //  println();
    //}  
    println("Average Fitness: " + getTotalFitness(population, newGeneration)/population);
    println("Current Generation: " + currentGeneration);
    //println(chooseParent());
    //println(correctCombinations);
    
    continueRunning = false;
  }
}

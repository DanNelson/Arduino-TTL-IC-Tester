//Include header file
#include "ChipTester.h"

void setup() {
	//Init LCD
	lcd.begin(16, 2);
	//Init button for lcd
	pinMode(LCDScrollButton, INPUT);
	//Start test button
	pinMode(startTestButton, INPUT);
	//Print to LCD
	lcd.setCursor(0,0);
	lcd.print("Select a Gate:");
	lcd.setCursor(0,1);
	lcd.print(choices[currentSelection]);
}

//Main loop
void loop() {
	//Go to next test and do not advance testing
	if ((digitalRead(LCDScrollButton) == HIGH) && enableDisable) {
		//Go to next menu item
		menu();
		delay(100);
	}
	//Start test button press
	else if (digitalRead(startTestButton) == HIGH) {
		//Disable second button
		enableDisable = false;
		//Start test
		beginTest();
		//Print results of test
		printResults();
		//Re-enable scroll button
		enableDisable = true;

	}
	delay(50);
}
void menu(){
	//Erase LCD
	lcd.clear();
	//If at the end of choices array and not returning from a test
	if(currentSelection == 8 && !returnTest){
		//Reset choice to 0
		currentSelection = 0;
		lcd.setCursor(0,0);
		lcd.print("Select a Gate:");
		lcd.setCursor(0,1);
		//Print current choice
		lcd.print(choices[currentSelection]);
	}
	//If at the end of choices array and not returning from a test
	else if(currentSelection == 8 && returnTest){
		returnTest = false;
		lcd.setCursor(0,0);
		lcd.print("Select a Gate:");
		lcd.setCursor(0,1);
		lcd.print(choices[currentSelection]);
	}
	//If returning from a test but not at end of choices
	else if(returnTest){
		returnTest = false;
		lcd.setCursor(0,0);
		lcd.print("Select a Gate:");
		lcd.setCursor(0,1);
		lcd.print(choices[currentSelection]);
	}
	//If not returning from a test but no at end of choices
	else{
		currentSelection++;
		lcd.setCursor(0,0);
		lcd.print("Select a Gate:");
		lcd.setCursor(0,1);
		lcd.print(choices[currentSelection]);
	}

}



void beginTest(){
	//Clear LCD and set text
	lcd.clear();
	lcd.setCursor(0,0);
	lcd.print("Beginning Test:");
	lcd.setCursor(0,1);
	lcd.print(choices[currentSelection]);
	switch(currentSelection){
	//7400
	case 0:
		pinSetup(LS7400Read,LS7400Write);
		testingEngine2(LS7400Read,LS7400Write,LS7400Out);
		break;
		//74002
	case 1:
		pinSetup(LS7402Read,LS7402Write);
		testingEngine2(LS7402Read,LS7402Write,LS7402Out);
		break;
		//7404
	case 2:
		pinSetup(LS7404Read,LS7404Write);
		testingEngine1(LS7404Read,LS7404Write,LS7404Out);
		break;
		//7408
	case 3:
		pinSetup(LS7408Read,LS7408Write);
		testingEngine2(LS7408Read,LS7408Write,LS7408Out);
		break;
		//7410
	case 4:
		pinSetup(LS7410Read,LS7410Write);
		testingEngine3(LS7410Read,LS7410Write,LS7410Out);
		break;
		//7420
	case 5:
		pinSetup(LS7420Read,LS7420Write);
		testingEngine4(LS7420Read,LS7420Write,LS7420Out);
		break;
		//7427
	case 6:
		pinSetup(LS7427Read,LS7427Write);
		testingEngine3(LS7427Read,LS7427Write,LS7427Out);
		break;
		//7432
	case 7:
		pinSetup(LS7432Read,LS7432Write);
		testingEngine2(LS7432Read,LS7432Write,LS7432Out);
		break;
		//7486
	case 8:
		pinSetup(LS7486Read,LS7486Write);
		testingEngine2(LS7486Read,LS7486Write,LS7486Out);
		break;
	}
}

void pinSetup(int readA[],int writeA[]){
	//Clear LCD and set text
	lcd.clear();
	lcd.setCursor(0,0);
	lcd.print("Step 1 of 2:");
	lcd.setCursor(0,1);
	lcd.print("Initializing Pins");
	int i = 0;
	//Init input pins
	while(readA[i] != NULL){
		pinMode(readA[i],INPUT);
		delay(50);
		i++;
	}
	i = 0;
	//Init output pins
	while(writeA[i] != NULL){
		pinMode(writeA[i],OUTPUT);
		delay(50);
		i++;
	}

}

void testingEngine1(int readA[],int writeA[],int outA[]){
	//Clear LCD and set text
	lcd.clear();
	lcd.setCursor(0,0);
	lcd.print("Step 2 of 2:");
	lcd.setCursor(0,1);
	lcd.print("Testing Chip");
	int number = 0;
	int i = 0;
	int j = 0;
	int k = 0;
	//Incrament number
	for(i = 0; i<2; i++){
		lcd.setCursor(12,1);
		//Incrament through gates on chip
		for(j = 0;j<6; j++){
			number = i;
			if (number == 0) {
				digitalWrite(writeA[j],LOW);
				lcd.setCursor(12,1);
				lcd.print("0");
			}
			else {
				digitalWrite(writeA[j],HIGH);
				lcd.setCursor(12,1);
				lcd.print("1");
			}
		}

		delay(250);
		//Check to see if expected output matched
		for(k = 0; k<6; k++){
			delay(100);
			int result = digitalRead(readA[k]);
			delay(125);
			if(result != outA[i]){
				//Find the actual gate number on IC
				int realGate = k;
				realGate++;
				badGates = badGates + realGate;
			}
			else{
				int realGate = k;
				realGate++;
				goodGates = goodGates + realGate;
			}
		}
	}

	//Temp string
	String badGate = "";
	String goodGate = "";
	for(k = 1; k<7; k++){
		if(badGates.indexOf(String(k)) == -1){
			goodGate = goodGate + String(k);

		}
		else{
			badGate = badGate + String(k);
		}
	}
	//Set real string to temp string
	badGates = badGate;
	goodGates = goodGate;
}


void testingEngine2(int readA[],int writeA[],int outA[]){
	//Clear LCD and set text
	lcd.clear();
	lcd.setCursor(0,0);
	lcd.print("Step 2 of 2:");
	lcd.setCursor(0,1);
	lcd.print("Testing Chip");
	int number = 0;
	int i = 0;
	int j = 0;
	int k = 0;
	int msb[4] = {};
	int lsb[4] = {};

	//Iterate through pins to find MSB and LSB
	for(j = 0; j<8;j++){
		if(j%2 == 0){
			msb[i] = writeA[j];
		}
		else{
			lsb[i] = writeA[j];
			i++;
		}
	}
	//Incrament through numbers
	for(i = 0; i<4; i++){
		lcd.setCursor(12,1);
		//Incrament through gates on chip
		for(j = 0;j<4; j++){
			number = i;
			if (number/2) {
				number = number - 2 ;
				digitalWrite(msb[j],HIGH);
				lcd.setCursor(12,1);
				lcd.print("1");
			}
			else {
				digitalWrite(msb[j],LOW);
				lcd.setCursor(12,1);
				lcd.print("0");
			}
			if (number/1) {
				number = number - 1 ;
				digitalWrite(lsb[j],HIGH);
				lcd.setCursor(13,1);
				lcd.print("1");
			}
			else {
				digitalWrite(lsb[j],LOW);
				lcd.setCursor(13,1);
				lcd.print("0");
			}
		}

		delay(250);
		//Read outputs after applying inputs
		for(k = 0; k<4; k++){
			delay(100);
			int result = digitalRead(readA[k]);
			delay(125);
			if(result != outA[i]){
				int realGate = k;
				realGate++;
				badGates = badGates + String(realGate);
			}
			else{
				int realGate = k;
				realGate++;
				goodGates = goodGates + String(realGate);
			}
		}

	}
	//Temp string
	String badGate = "";
	String goodGate = "";
	//Find broken gates
	for(k = 1; k<5; k++){
		if(badGates.indexOf(String(k)) == -1){
			goodGate = goodGate + String(k);

		}
		else{
			badGate = badGate + String(k);
		}
	}
	badGates = badGate;
	goodGates = goodGate;
}
void testingEngine3(int readA[],int writeA[],int outA[]){
	//Clear LCD and set text
	lcd.clear();
	lcd.setCursor(0,0);
	lcd.print("Step 2 of 2:");
	lcd.setCursor(0,1);
	lcd.print("Testing Chip");
	int number = 0;
	int i = 0;
	int j = 0;
	int k = 0;

	//Most significant bit
	int msb[3] = {writeA[0],writeA[3],writeA[8]};
	//Intermediate significance bit
	int isb[3] = {writeA[1],writeA[4],writeA[7]};
	//Least significant bit
	int lsb[3] = {writeA[2],writeA[5],writeA[6]};
	//Iterate through numbers
	for(i = 0; i<8; i++){
		lcd.setCursor(12,1);
		for(j = 0;j<3; j++){
			number = i;
			if (number/4) {
				number = number - 4 ;
				digitalWrite(msb[j],HIGH);
				lcd.setCursor(12,1);
				lcd.print("1");
			}
			else {
				digitalWrite(msb[j],LOW);
				lcd.setCursor(12,1);
				lcd.print("0");
			}
			if (number/2) {
				number = number - 2 ;
				digitalWrite(isb[j],HIGH);
				lcd.setCursor(13,1);
				lcd.print("1");
			}
			else {
				digitalWrite(isb[j],LOW);
				lcd.setCursor(13,1);
				lcd.print("0");
			}
			if (number/1) {
				number = number - 1 ;
				digitalWrite(lsb[j],HIGH);
				lcd.setCursor(14,1);
				lcd.print("1");
			}
			else {
				digitalWrite(lsb[j],LOW);
				lcd.setCursor(14,1);
				lcd.print("0");
			}
		}



		delay(250);
		//Read outputs after applying inputs
		for(k = 0; k<3; k++){
			delay(100);
			int result = digitalRead(readA[k]);
			delay(125);
			if(result != outA[i]){
				int realGate = k;
				realGate++;
				badGates = badGates + String(realGate);
			}
			else{
				int realGate = k;
				realGate++;
				goodGates = goodGates + String(realGate);
			}
		}
	}
	//Temp string
	String badGate = "";
	String goodGate = "";
	//Find broken gates
	for(k = 1; k<4; k++){
		if(badGates.indexOf(String(k)) == -1){
			goodGate = goodGate + String(k);

		}
		else{
			badGate = badGate + String(k);
		}
	}
	badGates = badGate;
	goodGates = goodGate;
}

void testingEngine4(int readA[],int writeA[],int outA[]){
	//Clear LCD and set text
	lcd.clear();
	lcd.setCursor(0,0);
	lcd.print("Step 2 of 2:");
	lcd.setCursor(0,1);
	lcd.print("Testing Chip");
	int number = 0;
	int i = 0;
	int j = 0;
	int k = 0;
	//Most significant bit
	int msb[2] = {writeA[0],writeA[4]};
	//Medium significant bit
	int mmsb[2] = {writeA[1],writeA[5]};
	//Least medium significant bit
	int lmsb[2] = {writeA[2],writeA[6]};
	//Least significant bit
	int lsb[2] = {writeA[5],writeA[9]};
	//Iterate through numbers
	for(i = 0; i<16; i++){
		lcd.setCursor(12,1);
		//Iterate through gates
		for(j = 0; j<2; j++){
			number = i;
			if (number/8) {
				number = number - 8 ;
				digitalWrite(msb[j],HIGH);
				lcd.print("1");
			}
			else {
				digitalWrite(msb[j],LOW);
				lcd.print("0");
			}
			if (number/4) {
				number = number - 4 ;
				digitalWrite(mmsb[j],HIGH);
				lcd.print("1");
			}
			else {
				digitalWrite(mmsb[j],LOW);
				lcd.print("0");
			}

			if (number/2) {
				number = number - 2 ;
				digitalWrite(lmsb[j],HIGH);
				lcd.print("1");
			}
			else {
				digitalWrite(lmsb[j],LOW);
				lcd.print("0");
			}
			if (number/1) {
				number = number - 1 ;
				digitalWrite(lsb[j],HIGH);
				lcd.print("1");
			}
			else {
				digitalWrite(lsb[j],LOW);
				lcd.print("0");
			}

			delay(250);
			//Read outputs after applying inputs
			for(k = 0; k<2; k++){
				delay(100);
				int result = digitalRead(readA[k]);
				delay(100);
				if(result != outA[i]){
					int realGate = k;
					realGate++;
					badGates = badGates + realGate;
				}
				else{
					int realGate = k;
					realGate++;
					goodGates = goodGates + realGate;
				}
			}
		}
		//Temp string
		String badGate = "";
		String goodGate = "";
		//Find broken gates
		for(k = 1; k<3; k++){
			if(badGates.indexOf(String(k)) == -1){
				goodGate = goodGate + String(k);

			}
			else{
				badGate = badGate + String(k);
			}
		}
		badGates = badGate;
		goodGates = goodGate;

	}
}

void releasePins(){
	//Set all pins to output and low
	int i = 0;
	while(allPins[i] != NULL){
		pinMode(allPins[i],INPUT);
		delay(100);
		i++;
	}

}
void printResults(){
	//Set pins all to low
	releasePins();
	//Clear LCD
	lcd.clear();
	lcd.setCursor(0,0);
	lcd.print("Releasing Pins");
	//Clear LCD
	lcd.clear();
	lcd.setCursor(0,0);
	//Print bad gates
	lcd.print("Bad Gates:");
	lcd.print(badGates);
	//Print gates that passed
	lcd.setCursor(0,1);
	lcd.print("OK Gates:");
	lcd.print(goodGates);
	//Uninitialized strings of good and bad gates
	goodGates = "";
	badGates = "";
	//Release test button
	returnTest = true;
}

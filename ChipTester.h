#ifndef ChipTester_H_
#define ChipTester_H_

#include "Arduino.h"
#include <SPI.h>
#include <LiquidCrystal.h>

#ifdef __cplusplus
extern "C" {
#endif
#ifdef __cplusplus
} // extern "C"
#endif


//constants
const int LCDScrollButton = 17;
const int startTestButton = A4;
const int pin1 = 8;
const int pin2 = 9;
//POSSIBLE FIXconst int pin3 = 12;
const int pin3 = A5;
const int pin4 = A0;
const int pin5 = A1;
const int pin6 = A2;
const int pin8 = 7;
const int pin9 = 6;
const int pin10 = 5;
const int pin11 = 4;
const int pin12 = 3;
const int pin13 = 2;


//Initialize the LCD library with the number of the sspin
LiquidCrystal lcd(10);
//Current menu choice
int currentSelection = 0;
//Gate choices
const String choices[9] = {"7400 2 Input NAND", "7402 2 Input XOR", "7404 1 Input NOT", "7408 2 Input AND",  "7410 3 Input NAND", "7420 4 Input NAND", "7427 3 Input XOR", "7432 2 Input OR",  "7486 2 Input NOR"};
//Gates
String badGates = "";
String goodGates = "";
//Disable button
boolean enableDisable = true;
//Return to same test
boolean returnTest = false;
//Clear pins
int allPins[] = {pin1,pin2,pin3,pin4,pin5,pin6,pin8,pin9,pin10,pin11,pin12,pin13,NULL};

/*********************************************
 *
 *IO Families
 *
 **********************************************/
//7400
int LS7400Read[] = {pin3,pin6,pin8,pin11,NULL};
int LS7400Write[] = {pin1,pin2,pin4,pin5,pin9,pin10,pin12,pin13,NULL};
//7402
int LS7402Read[] = {pin1,pin4,pin10,pin13,NULL};
int LS7402Write[] = {pin2,pin3,pin5,pin6,pin8,pin9,pin11,pin12,NULL};
//7404
int LS7404Read[] = {pin2,pin4,pin6,pin8,pin10,pin12,NULL};
int LS7404Write[] = {pin1,pin3,pin5,pin9,pin11,pin13,NULL};
//7408
int LS7408Read[] = {pin3,pin6,pin8,pin11,NULL};
int LS7408Write[] = {pin1,pin2,pin4,pin5,pin9,pin10,pin12,pin13,NULL};
//7410
int LS7410Read[] = {pin12,pin6,pin8,NULL};
int LS7410Write[] = {pin1,pin2,pin13,pin3,pin4,pin5,pin9,pin10,pin11,NULL};
//7420
int LS7420Read[] = {pin6,pin8,NULL};
int LS7420Write[]= {pin1,pin2,pin4,pin5,pin9,pin10,pin12,pin13,NULL};
//7427
int LS7427Read[] = {pin12,pin6,pin8,NULL};
int LS7427Write[] = {pin1,pin2,pin13,pin3,pin4,pin5,pin9,pin10,pin11,NULL};
//7432
int LS7432Read[] = {pin3,pin6,pin8,pin11,NULL};
int LS7432Write[] = {pin1,pin2,pin4,pin5,pin9,pin10,pin12,pin13,NULL};
//7486
int LS7486Read[] = {pin3,pin6,pin8,pin11,NULL};
int LS7486Write[] = {pin1,pin2,pin4,pin5,pin9,pin10,pin12,pin13,NULL};

/*********************************************
 *
 *Expected output familes
 *
 **********************************************/
//7400
int LS7400Out[] = {HIGH,HIGH,HIGH,LOW,NULL};
//7402
int LS7402Out[] = {HIGH,LOW,LOW,LOW,NULL};
//7404
int LS7404Out[] = {HIGH,LOW,NULL};
//7408
int LS7408Out[] = {LOW,LOW,LOW,HIGH,NULL};
//7410
int LS7410Out[] = {HIGH,HIGH,HIGH,HIGH,HIGH,HIGH,HIGH,LOW,NULL};
//7420
int LS7420Out[] = {HIGH,HIGH,HIGH,HIGH,HIGH,HIGH,HIGH,HIGH,HIGH,HIGH,HIGH,HIGH,HIGH,HIGH,HIGH,HIGH,LOW,NULL};
//7427
int LS7427Out[] = {HIGH,LOW,LOW,LOW,LOW,LOW,LOW,LOW,NULL};
//7432
int LS7432Out[] = {LOW,HIGH,HIGH,HIGH,NULL};
//7486
int LS7486Out[] = {LOW,HIGH,HIGH,LOW,NULL};

void pinSetup(int readA[],int writeA[]);
void testingEngine1(int readA[],int writeA[],int outA[]);
void testingEngine2(int readA[],int writeA[],int outA[]);
void testingEngine3(int readA[],int writeA[],int outA[]);
void testingEngine4(int readA[],int writeA[],int outA[]);
void beginTest();
void menu();
void releasePins();
void printResults();
void loop();
void setup();

#endif

/*! @file pin_def.h
This file contain the pinout connection.
 @author Ing. M.Lampugnani
 @par Company:
 MyCompany
 @version 0.0.1-RF brach
 @date 9th august 2011 */
#ifndef	PIN_DEF_H
#define	PIN_DEF_H

//! Pin di segnalazione POWER On/Off.
/*! Sul pin13 della scheda, dove spesso e' gia' connesso un led
NON e'possibile collegarsi, in quanto usato dal chip ethernet.
*/
#define STATUS_PIN 5
//!< @param MCU pin

/*! @name Weather Data Connection
 Definizione delle Connessioni dei sensori ambientali
 @param MCU pin  */
//@{
//! Pin LDR - light depending diode
#define LDR_PIN    14    //!<Analog In 5

//!  Data wire is plugged into pin 4 on the Arduino
#define ONE_WIRE_BUS 4
//!  Usata per la creazione della struct (WeatherController.h)
#define ONE_WIRE_NUM_SENS  2

//!  Rain sensor is plugged into pin 8 on the arduino
#define RAIN_PIN 8

//@}

/*! @name OUTPUT RGB PinOut
 	Definizione delle Connessioni dei tre anodi del led RGB
 @param MCU pin  */
//@{

//IR TSOP1838
//#define RED_PIN 10 	//!< Pin dell'MCU al quale e' connesso l'anodo Rosso (R) - OUTPUT 
//#define GREEN_PIN 9 	//!< Pin dell'MCU al quale e' connesso l'anodo Verde (G) - OUTPUT
//#define BLUE_PIN 5 	//!< Pin dell'MCU al quale e' connesso l'anodo Blu (B)   - OUTPUT

// 433 RF MODULE
#define RED_PIN 11  	//!< anodo Rosso (R)
#define GREEN_PIN 3	//!< anodo Verde (G)
#define BLUE_PIN 6 	//!< anodo Blu (B)

//ARDUINO-mega TEST 
//#define RED_PIN 8  	//!< anodo Rosso (R)
//#define GREEN_PIN 4	//!< anodo Verde (G)
//#define BLUE_PIN 7 	//!< anodo Blu (B)

//@}



#endif



/*! @file AWC.pde
 @author Ing. M.Lampugnani
 @par Company:
 MyCompany
 @version 0.0.1-RF brach
 @date 27th july 2011 */
#include <Metro.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <SPI.h>
#include <Ethernet.h>
#include "WebServer.h"
#include "pin_def.h"
#include "global.h"
#include "AWC.h"
#include "timing.h"
#include "Debug.h"

void setup() {

  //!Start-up porta seriale e ricevitore IR
  Serial.begin(COM_BPS);
  initETH(); 
  Serial.println("Awning Weather Controller v "FW_VER);
  //delay(30);
  //Serial.println("Bootup..");
  //DBGp_INIT(0,"Booting Up %s\n",FW_VER);
  Serial.println("Booting up..");
  //DBGp_INIT(0,"DBGlvl: %u\n", debugL);
  //DBGp_INIT(0,"Almost Ready!! %s\n",com_data);

  /*! Settaggio dei pin di OUTPUT */
//  pinMode(RED_PIN, OUTPUT);		
//  pinMode(GREEN_PIN, OUTPUT);		
//  pinMode(BLUE_PIN, OUTPUT);

  initLDR();
  initRAIN();
  initBusTemp();
  //!Accensione del LED di stato def::STATUS_PIN
  digitalWrite(STATUS_PIN,HIGH);	

  //!Invio sulla porta del messaggio "Ready!!"
  //DBGp_INIT(0,"Ready!! %s\n",com_data);
  Serial.println("Ready!!");
  //  p("Decimal a: %l\nDecimal unsigned a: %lu\n", millis(), millis()); 	

}


void loop() {

  if (FastTask.check() == 1) {
    FastTask.reset();
    TSKfast();
  } 
  else {
    PSprocess();
    ETHprocess();
  }

  if (SlowTask.check() == 1) {
    SlowTask.reset();
    TSKslow();
  }

  if (LogTask.check() == 1) {
    LogTask.reset();
    TSKlog();
  }

}



/*! @file senseRAIN.pde
 @author Ing. M.Lampugnani
 @par Company:
 MyCompany
 @version 0.0.2-scrolling branch
 @date 11 August 2011 */
 
 //! Inizializing RAIN sensor
void initRAIN(){
  pinMode(RAIN_PIN, INPUT);
  //digitalWrite(RAIN_PIN, HIGH);  
}

//!ritorna la lettura del sensore di pioggia
bool readRAIN(){
  bool RainState = digitalRead(RAIN_PIN);
  return RainState;
}

//!salva la lettura del sensore di pioggia nella struttura dati
/*! Il dato sara' disponibile rapidamente dal resto del sistema.*/
void storeRAIN(){
  ActWth.isRaining = digitalRead(RAIN_PIN);
}



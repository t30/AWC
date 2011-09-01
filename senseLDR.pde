/*! @file senseLDR.pde
 @author Ing. M.Lampugnani
 @par Company:
 MyCompany
 @version 0.0.1-RF brach
 @date 10 AUgust 2011 */

//! Inizializing LDR sensor
/*! A Light Dependign Resistor is a resistor that change its Resistance according with lum condition.\n
I expect near 1 Mohm with deep dark and near 0 with sun light.*/
void initLDR(){
  pinMode(LDR_PIN, INPUT);
  digitalWrite(LDR_PIN, HIGH);  
}

//!ritorna la lettura dell'LDR
unsigned int readLDR(){
  unsigned int LDRval = analogRead(LDR_PIN);
  return LDRval;
}

//!salva la lettura dell'LDR nella struttura dati
/*! Il dato sara' disponibile rapidamente dal resto del sistema.*/
void storeLDR(){
  ActWth.LDR = analogRead(LDR_PIN);
}






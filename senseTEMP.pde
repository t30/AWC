/*! @file senseTEMP.pde
 @author Ing. M.Lampugnani
 @par Company:
 MyCompany
 @version 0.0.2-scrolling branch
 @date 11 August 2011 */

/*!  @name  Digital Temperature Sensor (DS18B20)
 Declaration of bus sensor object
 */
//@{
//! Setup a oneWire instance to communicate with any OneWire devices.
/*!  (not just Maxim/Dallas temperature ICs)  
 -  def::ONE_WIRE_BUS  Pin connection for OneWire bus.*/
OneWire oneWire(ONE_WIRE_BUS);
//! Pass our oneWire reference to Dallas Temperature. 
DallasTemperature sensors(&oneWire);
//@}

//!Start OneWire Bus.
void initBusTemp(){
  sensors.begin();
}

//! Esegue una richiesta di lettura sul bus
void requestTemp(){
  DBGp_TEMP(9,"Requesting temperatures...\n", ActWth.Temp);
  sensors.requestTemperatures(); // Send the command to get temperatures
  DBGp_TEMP(9,"DONE\n", ActWth.Temp);
}

//! Ritorna la temperatura del sensore con l'indice passato in argomento.
/*!  @param [in] sensNr indice del sensore sul quale agire.  */
float readTemp(int sensNr){
  float Temperature = sensors.getTempCByIndex(sensNr);
  //Actual.Temp=Temperature;
  return Temperature;
}

//!Salva nella struttura dati Ambiente il valore del sensore con l'indice passato in argomento
/*!  @param [in] sensNr indice del sensore sul quale agire.  */
void storeTemp(int sensNr){
  ActWth.Temp[sensNr] = sensors.getTempCByIndex(sensNr);
}

//!salva nella struttura dati Ambiente tutti i valori dei sensori presenti sul bus
void storeAllTemp(){
  for(int sensNr = 0; sensNr < ONE_WIRE_NUM_SENS; sensNr++){
    ActWth.Temp[sensNr] = sensors.getTempCByIndex(sensNr);
  }
}






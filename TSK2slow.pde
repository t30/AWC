/*! @file TSK2slow.pde
 Routine lanciata da loop(). E' eseguita ogni var::slowPeriod ms (all'incirca).\n
 @author Ing. M.Lampugnani
 @par Company:
 MyCompany
 @version 0.0.1-RF brach
 @date 12 August 2011 */
void TSKslow(){
  //storeTemp(0);
  requestTemp();
  storeAllTemp();
  //Serial.print(Actual.Temp[0]);
  //Serial.print(" ");
  //Serial.println(Actual.Temp[1]);
  //Serial.println(Actual.isRaining);

  dtostrf(ActWth.Temp[0], 5, 2, TMPTpmStr[0]);
  dtostrf(ActWth.Temp[1], 5, 2, TMPTpmStr[1]);
  DBGp_LDR(5,"LDR value: %u - Temp0: %s Temp1: %s - isRaining %u \n",ActWth.LDR, TMPTpmStr[0], TMPTpmStr[1], ActWth.isRaining);
}


/*! @file TSK1fast.pde
Routine lanciata da loop(). E' eseguita ogni var::fastPeriod ms (all'incirca).\n

 @author Ing. M.Lampugnani
 @par Company:
 MyCompany
 @version 0.0.1-RF brach
 @date 12 August 2011 */
void TSKfast(){
  blinkStatus();
  switch(system_stat){
  case STAT_STATIC:
    storeLDR();
    storeRAIN();
    break;
  case STAT_RAND:
    break;
  case STAT_FLASH:
    break;
  case STAT_UFO:
    break;
  }
}


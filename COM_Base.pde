/*! @file COM_Base.pde
 This file contain the function need to processing data from all kind of comunication protocol.\n
 All data was put by adhoc function in data_com array.\n
 With the content of this file let's process it!
 @author Ing. M.Lampugnani
 @par Company:
 MyCompany
 @version 0.0.1-RF brach
 @date 31th july 2011 */

//#include "Debug.h"

//!  Converte un esadecimale char in un integer
int HEXcharTOint(char base){
  unsigned int color;
  if(base>='0' && base<='9'){
    color = int(base)-'0';
  }
  else if(base>='a' && base<='f'){
    color = int(base)-'a'+10;
  }
  else if(base>='A' && base<='F'){
    color = int(base)-'A'+10;
  }
  return color;
}

unsigned int HEXtoPeriod(char first,char second, char third){
  int final = 0;
  char value[]={
    third, second, first       };
  for(int i = 0; i < 3; i++){
    final = final + ( HEXcharTOint(value[i]) << (4*i) ); 
  }
  //return constrain(final, 0, 255);
  return final;
}

//! Processa i dati presenti nel buffer di ricezione
/*! I dati provenienti dalle comunicazioni che possono essere disponibili sul dispositivo vengono parcheggiati nel buffer var::com_data .\n
Le funzioni di processing dei vari protocolli (eg. PSProcess) dopo aver completato l'aggiornamento del buffer, chiamano questa funzione per l'esecuzione condizionata dei comandi.\n  */
void COMprocess(){
  //DBGp_COM(7,"%s#EOL\n",com_data);

  //Set period for clock task
  if(com_data[0] == 'c' && com_data[1] == 'l' && com_data[2] == 'k'){
    DBGp_COM(0,"clock setting=> clk: %c\n", com_data[4]);
    switch(com_data[4]){
    case'0':      
      //fast task res 1ms (from 1 to 4097 msec)
      fastPeriod = (HEXtoPeriod(com_data[5],com_data[6],com_data[7]) + 1) ;
      DBGp_COM(0,"NewPeriodFast setting (ms)=> clk: %u\n", fastPeriod);
      FastTask.interval(fastPeriod);
      break;
    case'1':      
      //slow task  res 1s (1000ms) (from 1 to 4097 sec)
      slowPeriod = ((HEXtoPeriod(com_data[5],com_data[6],com_data[7]) + 1)*1000) ;
      DBGp_COM(0,"NewPeriodSlow setting (ms)=> clk: %u\n", slowPeriod);
      SlowTask.interval(slowPeriod);
      break;
    case'2':      
      //slow task  res 1s (1000ms) (from 1 to 4097 sec)
      logPeriod = ((HEXtoPeriod(com_data[5],com_data[6],com_data[7]) + 1)*1000) ;
      DBGp_COM(0,"NewPeriodLog setting (ms)=> clk: %u\n", logPeriod);
      LogTask.interval(logPeriod);
      break;
    default:
      DBGp_ERR(1,"ERR clk=> char not recognized: %c\n", com_data[4]);
    }
  }

  //Set new debug level. 0 < debugL < 9
  if(com_data[0] == 'd' && com_data[1] == 'b' && com_data[2] == 'g'){
    DBGp_COM(0,"DGB=> lvl: %c\n", com_data[4]);
    debugL = constrain( com_data[4]-'0', 0, 9);    
  }

  //Set dynamic color state
  if(com_data[0] == 'p' && com_data[1] == 'r' && com_data[2] == 'g'){
    DBGp_COM(0,"program=> set: %c\n", com_data[4]);
    switch(com_data[4]){
    case'R':      
      system_stat = STAT_RAND;
      break;
    case'F':      
      system_stat = STAT_FLASH;
      break;
    case'U':      
      system_stat = STAT_UFO;
      break;
    default:
      DBGp_ERR(1,"ERR prg=> char not recognized: %c\n", com_data[4]);
    }

  }

  //Set new Static state
  if(com_data[0] == 's' && com_data[1] == 'e' && com_data[2] == 't'){
    DBGp_COM(0,"setting=> system_stat: %c\n", com_data[4]);
    if(com_data[4] == '1') {
      system_stat = STAT_STATIC;
    }
    if(com_data[4] == '0') {
      system_stat = STAT_OFF;
    }
    if(com_data[4] == 'R') {
      void(* resetFunc) (void) = 0; //declare reset function @ address 0
      resetFunc();  //call reset
    }
  }

  //Set pure color
  if(com_data[0] == 't' && com_data[1] == 'r' && com_data[2] == 'i'){
    system_stat = 1;
    DBGp_COM(0,"tricolor=> set: %c\n", com_data[4]);
    switch(com_data[4]){
    case'r':      
      break;
    case'g':      
      break;
    case'b':      
      break;
    case'w':      
      break;
    default:
      DBGp_ERR(1,"ERR tri=> char not recognized: %c\n", com_data[4]);
    }
  }

  //strcpy(com_data,"000000000");
}


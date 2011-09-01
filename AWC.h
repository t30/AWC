/*! @file AWC.h
 @author Ing. M.Lampugnani
 @par Company:
 MyCompany
 @version 0.0.1-RF brach
 @date 11 August 2011 */
#ifndef	WEATHERCONTROLLER_H
#define	WEATHERCONTROLLER_H

//!Struttura dati Ambiente
/*! Contiene dati relativi alle condizioni abientali.  */
struct environment {
  int LDR;                              //!<dato luminosita'
  float Temp[ONE_WIRE_NUM_SENS];        //!<matrice per contenere piu' sensori di temperatura
  int Wind;                             //!<dato vento
  //bool isRaining;                       
  int  isRaining;          //!<sta piovendo?
} 
//Actual Weather
/*! Dati relativi ai sensori ambientali utilizzati per
 la valutazione delle azioni da compiere  */
ActWth = {
  0, {
    0.0, 0.0              }
  , 0, 0};

//!Stati di una tenda
enum awningState { 
  rise,                 //!<salita
  stop,                 //!<ferma
  fall                  //!<discesa
};

//!Posizione presunta della tenda
/*! E' presunta in quanto non è possibile conoscere la posizione all'avvio
 e nemmeno deopo un intervento sui controlli manuali  */
enum awningPosition {
  up,                    //!<chiusa
  unk,                   //!<sconosciuta
  down                   //!<aperta
};

//!Struttura dati delle tende
struct awning {
  bool isEnabled[AWNING_NR];              //!<Questa tenda è abilitata?
  awningState State[AWNING_NR];           //!<Stato della tenda
  bool isMoving[AWNING_NR];               //!<Si sta muovendo ora?
  awningPosition Pos[AWNING_NR];          //!<Posizione presunta della tenda
}
//!Actual Awning
ActAwn = { 
  {
    0, 0          }
  ,
  {
    stop, stop                                    }
  , {
    0, 0                                      }
  , {
    unk, unk                    } 
};

//!Variabile di appoggio per il dato temperatura trasformato in Stringa (da float)
char TMPTpmStr[ONE_WIRE_NUM_SENS][6] = {
  '00.000', '00.000'};

#endif





































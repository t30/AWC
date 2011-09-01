/*! @file global.h
 @author Ing. M.Lampugnani
 @par Company:
 MyCompany
 @version 0.0.1-RF brach
 @date 27th july 2011 */
#ifndef	GLOBAL_H
#define	GLOBAL_H

//! Versione Firmware
#define FW_VER  "0.001"
//! BPS comunicazione seriale
#define COM_BPS 115200
//#define RF

/*!  @name  State 
 Variabili e definizioni utilizzate per la gestione degli stati del sistema.  */
//@{

//!  Numero massimo di stati in cui si puo' trovare il sistema.
/*!  Questa variabile e' usata per gestire i cicli fra gli stati, ad esempio
 con il tasto di un telecomando ir "AV/TV/VCR"   */
#define MAX_STATUS 4
/*!  Da tenere presente che sebbene lo stato 0 indichi il LED spento.
 Anche lo 0 e' uno stato a tutti gli effetti  */
#define STAT_OFF       0x00    //!<  0 = off                    @todo  Da vedere
#define STAT_STATIC    0x01    //!<  1 = static color           @todo  Da vedere
#define STAT_RAND      0x02    //!<  2 = rand_col function      @todo  Da vedere
#define STAT_FLASH     0x03    //!<  3 = flash function         @todo  Da vedere
#define STAT_UFO       0x04    //!<  4 = ufo function

//! Codice stato attuale in cui si trova il sistema
int system_stat = STAT_STATIC; //!< La variabile dovra' assumere solo valori predefiniti dalle define STAT_*
//@}


/*!  @name Variaibli di appoggio
 Varibili di appoggio utilizzate per la comunicazione seriale e RF (se presente).  */
//@{

//! Array da 11 colonne in cui viene appoggiato il comando proveniente dalla comunicazione
/*! Le comunicazioni presenti sul dispositivo appoggiano il comando in questo buffer per la successiva elaborazione.\n
 //  Le prime 3 posizioni sono il comando
 //  La quarta no è usata
 //  sette posizioni usate per l'agomento piu' terminatore */
char com_data[] = {
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};  //!<  @todo verificare perche' devo usare un elemento in piu' nell'array
//diversamente da come fatto nella versione IR

//! Variabile di parcheggio per l'ultimo byte arrivato dalla porta seriale
int incomingByte = 0;

//@}

//! Numero di dispositivi gestibili (WeatherController.h)
/*! Tipicamente tende da sole  */
#define AWNING_NR    2

#endif



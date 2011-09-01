/*! @file timing.h
 @author Ing. M.Lampugnani
 @par Company:
 MyCompany
 @version 0.0.1-RF brach
 @date 27th july 2011 */
#ifndef	TIMING_H
#define	TIMING_H

/*!  @name  Task timing function definition
 //  Creazione degli oggetti timer utilizzati per le chiamate ai task  */
//@{
//!Setting up execution frequency f[Hz]= 1000/period[msec]
unsigned int fastPeriod = 4000;
//!  Task Veloce.
/*!  Utilizzato per mantenere aggiornate le varibili interne del sistema. (FastFunc.pde) */
Metro FastTask = Metro(fastPeriod);

//!Setting up execution frequency f[Hz]= 1000/period[msec]
unsigned int slowPeriod = 30000;
//unsigned int slowPeriod = 8000;
//!  Task Lento.
/*!  Utilizzato per mantenere aggiornato lo stato dei sensori e componenti lenti
 //  in risposta o nella variazione del loro segnale. (SlowFunc.pde) */
Metro SlowTask = Metro(slowPeriod); 

//!Setting up execution frequency f[Hz]= 1000/period[msec]
unsigned long logPeriod = 600000L;
//unsigned long logPeriod = 10000L;
//!  Task di log.
/*!  Utilizzato per eseguire eventuali operazioni logging su dispositivi remoti. (LogFunc.pde) */
Metro LogTask = Metro(logPeriod); 
//@}

#endif



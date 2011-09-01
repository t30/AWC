/*! @file Debug.h
 This file contain all the function and all the definition about debug.\n
 The definition are used to call the main funcion limited to its contest.\n
 Commenting definition you should disable debug.\n
 @todo  split this file into Debug.pde + Debug.h (if necessary).
 @author Ing. M.Lampugnani
 @par Company:
 MyCompany
 @version 0.0.1-RF brach
 @date 31th july 2011 */
#ifndef	DEBUG_H
#define	DEBUG_H


#define DBGp(lvlDBG, fmt, ... )                      p(lvlDBG, fmt, __VA_ARGS__ )
#define DBGp_ERR(lvlDBG, fmt, ... )                  DBGp(lvlDBG, fmt, __VA_ARGS__ )

#define DBGp_COM(lvlDBG, fmt, ... )                  DBGp(lvlDBG, fmt, __VA_ARGS__ )
#define DBGp_PS(lvlDBG, fmt, ... )                   DBGp(lvlDBG, fmt, __VA_ARGS__ )
#define DBGp_ETH(lvlDBG, fmt, ... )                  DBGp(lvlDBG, fmt, __VA_ARGS__ )

#define DBGp_LDR(lvlDBG, fmt, ... )                  DBGp(lvlDBG, fmt, __VA_ARGS__ )
#define DBGp_TEMP(lvlDBG, fmt, ... )                 DBGp(lvlDBG, fmt, __VA_ARGS__ )

//!  Definition of  default level debug
#define DEBUG  9

//!  Actual system level debug
/*!  This can be changed on the fly using serial command.\n
 eg.  dbg_l00000.\n
 0 < l < 9  */
extern unsigned int debugL; // = DEBUG;

extern void p(unsigned int lvlDBG, char *fmt, ... );



#endif


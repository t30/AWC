/*! @file TSK3log.pde
 Routine lanciata da loop(). E' eseguita ogni var::slowPeriod ms (all'incirca).\n
 Function of this file is log your data.\n
 You can chose data to log and protocol used to remote logging.
 @author Ing. M.Lampugnani
 @par Company:
 MyCompany
 @version 0.0.1-RF brach
 @date 12 August 2011 */
 void TSKlog(){
        DBGp_ETH(1,"TSKlog => log to remote system\n", com_data[4]);
        HTTPlog(ActWth.Temp[0], ActWth.Temp[1]);
}

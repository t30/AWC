/*! @file COM_EH.pde
 Function for TCP/IP Ethernet connection (incoming cmd & outcoming log).
 @author Ing. M.Lampugnani
 @par Company:
 MyCompany
 @version 0.0.1
 @date 29th august 2011 */

//! mac address of local embedded device
byte mac[] = { 
  0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
//! ip address of local embedded device
byte ip[] = { 
  192, 168, 1, 125 };
//! ip address remote logging server
/*! Needed a php script for logging data */
byte dest[] = { 
  192, 168, 1, 2 };

#define ETH_NAMELEN 4
#define ETH_VALUELEN 6

// ROM-based messages used by the application
// These are needed to avoid having the strings use up our limited
//    amount of RAM.

//! print html header with title tag.
P(Page_start) = "<html><head><title>AWC web - " FW_VER "</title></head><body>\n";
//! print html footer with version and sign
P(Page_end) = "<br><br>AWC web - v." FW_VER"<br>Matteo Lampugnani production <br></body></html>";
P(Get_head) = "<h1>GET from ";
//P(Post_head) = "<h1>POST to ";
P(Unknown_head) = "<h1>UNKNOWN request for ";
P(Default_head) = "unidentified URL requested.</h1><br>\n";
//P(Raw_head) = "raw.html requested.</h1><br>\n";
P(Parsed_head) = "cmd.html requested.</h1><br>\n";
P(Good_tail_begin) = "URL tail = '";
P(Bad_tail_begin) = "INCOMPLETE URL tail = '";
P(Tail_end) = "'<br>\n";
P(Parsed_tail_begin) = "URL parameters:<br>\n";
P(Parsed_item_separator) = " = '";
P(Params_end) = "End of parameters<br>\n";
//P(Post_params_begin) = "Parameters sent by POST:<br>\n";
P(Line_break) = "<br>\n";

Client logging(dest, 80);

/*! This creates an instance of the webserver.  By specifying a prefix
 * of "", all pages will be at the root of the server. */
#define PREFIX ""
WebServer webserver(PREFIX, 80);

//! Remote logging
void HTTPlog(float arg0, float arg1) {
  //DBGp_ETH(7,"HTTPlog enter \n", arg0, arg1);
  if (logging.connect()) {
    logging.print("GET /logger_data.php?");
    //  sensors.getTempCByIndex(0)
    //    logging.println("GET /testETH?sensors.getTempCByIndex(0) HTTP/1.0");
    logging.print("t0=");
    logging.print(arg0);
    logging.print("&t1=");
    logging.print(arg1);
    logging.print("&t2=");
    logging.print(ActWth.LDR);
    logging.println(" HTTP/1.0");
    logging.println();
    logging.stop();
  } 
  /*
  else {
   void(* resetFunc) (void) = 0; //declare reset function @ address 0
   resetFunc();  //call reset
   }
   */
}

/*! Forwarding data from ETH buffer ( var::url_tail )
to COM buffer ( var::com_data )  */
void ETHdata(char *url_called){
  for (int i = 0; i < 10; i++){
    com_data[i] = url_called[i];
    //com_data[i+1] = '\0';
  }
  //posiziono il terminatore di stringa per non avere "sporcizia"
  com_data[10] = '\0';
  DBGp_ETH(8,"ETH data==> %s\n",com_data);
  COMprocess();
}

//! Function called when command page is called
void PAGEcmd(WebServer &server, WebServer::ConnectionType type, char *url_tail, bool tail_complete)
{
  DBGp_ETH(7,"Start Parsing ethDATA => %s len= %u\n", url_tail, strlen(url_tail));
  URLPARAM_RESULT rc;
  char name[ETH_NAMELEN];
  int  name_len;
  char value[ETH_VALUELEN];
  int value_len;

  /* this line sends the standard "we're all OK" headers back to the
   browser */
  server.httpSuccess();

  /* if we're handling a GET or POST, we can output our data here.
   For a HEAD request, we just stop after outputting headers. */
  if (type == WebServer::HEAD)
    return;

  server.printP(Page_start);
  switch (type)
  {
    case WebServer::GET:
    server.printP(Get_head);
    break;
  default:
    server.printP(Unknown_head);
  }

  server.printP(Parsed_head);
  server.printP(tail_complete ? Good_tail_begin : Bad_tail_begin);
  server.print(url_tail);
  server.printP(Tail_end);

  ETHdata(url_tail);
  
  if (strlen(url_tail))
  {
    server.printP(Parsed_tail_begin);
    while (strlen(url_tail))
    {
      rc = server.nextURLparam(&url_tail, name, ETH_NAMELEN, value, ETH_VALUELEN);
      if (rc == URLPARAM_EOS)
        server.printP(Params_end);
      else
      {
        server.print(name);
        server.printP(Parsed_item_separator);
        server.print(value);
        server.printP(Tail_end);
        if(name[0]=='C' && name[1]=='M' && name[2]=='D') {
          server.print("comando\n<br>");
          switch(value[0]){
          case 'R' : 
            {
              void(* resetFunc) (void) = 0; //declare reset function @ address 0
              resetFunc();  //call reset
              break;
            }

          case 'A' : 
            {

            }          
          default :
            {
              server.print("default<br>\n");
              break;
            }
          }
        }
        else server.print("nulla");
      }
    }
  }
  server.printP(Page_end);
  DBGp_ETH(7,"Ending Parsing ethDATA => len= %u\n", strlen(url_tail));
}

//! This is the reply for root webserver.
void PAGEdefault(WebServer &server, WebServer::ConnectionType type, char *url_tail, bool tail_complete){
  DBGp_ETH(7,"Start default page ethDATA => %s len= %u\n", url_tail, strlen(url_tail));
  URLPARAM_RESULT rc;
  char name[ETH_NAMELEN];
  int  name_len;
  char value[ETH_VALUELEN];
  int value_len;

  /* this line sends the standard "we're all OK" headers back to the
   browser */
  server.httpSuccess();

  /* if we're handling a GET or POST, we can output our data here.
   For a HEAD request, we just stop after outputting headers. */
  if (type == WebServer::HEAD)
    return;

  server.printP(Page_start);
  switch (type)
  {
    case WebServer::GET:
    server.printP(Get_head);
    break;
  default:
    server.printP(Unknown_head);
  }

  server.printP(Parsed_head);
  server.printP(tail_complete ? Good_tail_begin : Bad_tail_begin);
  server.print(url_tail);
  server.printP(Tail_end);

  ETHdata(url_tail);
  
  if (strlen(url_tail))
  {
    server.printP(Parsed_tail_begin);
    while (strlen(url_tail))
    {
      rc = server.nextURLparam(&url_tail, name, ETH_NAMELEN, value, ETH_VALUELEN);
      if (rc == URLPARAM_EOS)
        server.printP(Params_end);
      /*
      else
      {
        server.print(name);
        server.printP(Parsed_item_separator);
        server.print(value);
        server.printP(Tail_end);
        if(name[0]=='C' && name[1]=='M' && name[2]=='D') {
          server.print("comando\n<br>");
          switch(value[0]){
          case 'R' : 
            {
              void(* resetFunc) (void) = 0; //declare reset function @ address 0
              resetFunc();  //call reset
              break;
            }

          case 'A' : 
            {

            }          
          default :
            {
              server.print("default<br>\n");
              break;
            }
          }
        }
        else server.print("nulla");
      }
      */
    }
  }
  server.printP(Page_end);
  DBGp_ETH(7,"Ending default page ethDATA => len= %u\n", strlen(url_tail));
}

//! Processa i dati disponibili nel buffer ethernet.
/*!Se ci sono dati disponibili li elabora, chiama COMprocess() e manda i dati da visualizzare sul web .\n
//Per essere produttiva, la funzione deve essere chiamata di continuo dal firmware nei momenti in cui non risulta impegnato da altre esecuzioni.*/
void ETHprocess(){
  char buff[128];
  int len = 128;

  /* process incoming connections one at a time */
  webserver.processConnection(buff, &len);
}

//! Init TCP/IP Ethernet bi-directional protocol
void initETH(){
  // start the Ethernet connection:
  Ethernet.begin(mac, ip);

  webserver.setDefaultCommand(&PAGEdefault);
  // webserver.setFailureCommand(&my_failCmd);
  webserver.addCommand("cmd.html", &PAGEcmd);
  /* start the webserver */
  webserver.begin();
}





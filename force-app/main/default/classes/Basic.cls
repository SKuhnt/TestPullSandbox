/**
 @Company : aquilliance GmbH
 @description : Testhelper with many creations.
  
 ********************************* Modification Log ***********************************
Modified by					Modified on				Ticket No.					Comments
Andre Mergen				%%%%%%%%%%%				%%%%%%%%%%					initial version
Torben Sieber				07/01/2019				AQUINT-98					integrated in the test helper 
*/
public with sharing class Basic {

    /**
    * @description 
    * @return 
    */ 
    public static Integer doIt(){
        System.debug('hi');
        return 2;
    }  
    public static Integer doIt2(){
        Integer i = 0;
        if(true){
            i++;
            return i;
        } else {
            i--;
            return i;
        }
    } 
} 

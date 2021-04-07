/**
  @Company : aquilliance GmbH
  @Purpose : Interface containing methods Trigger Handlers must implement to enforce best practice and bulkification of triggers.
 
 ***************************************** Modification Log *****************************************
  Modified By					Modified on					Ticket No.					Comments
  Bhushan Patil					01-05-2019					--------					inital version
  Simon Kuhnt					06-04-2021					--------					Improved Comments
*/
public interface AP_ITrigger {
    
    /**
	* @description bulkBefore: 
    * This method is called prior to execution of a BEFORE trigger. 
    * Use this to cache any data required into maps prior execution of the trigger.
	*/ 
    void bulkBefore();
    void beforeInsert();
    void beforeUpdate();
    void beforeDelete();
        
    /**
	* @description bulkAfter: 
    * This method is called prior to execution of a AFTER trigger. 
    * Use this to cache any data required into maps prior execution of the trigger.
	*/ 
    void bulkAfter();
    void afterInsert();
    void afterUpdate();
    void afterDelete();
    void afterUndelete();
    
    /**
    * @description andFinally:
    * This method is called once all records have been processed by the trigger. Use this 
    * method to accomplish any final operations such as creation or updates of other records.
    */
    void andFinally();
}
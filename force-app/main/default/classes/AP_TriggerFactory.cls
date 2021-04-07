/**
  @Company : aquilliance GmbH
  @Purpose : Trigger factory to instantiate trigger handler based on sobject type. 
 
 ***************************************** Modification Log *****************************************
  Modified By					Modified on					Ticket No.					Comments
  Bhushan P.					23-10-2016					----------					Original Version
  Simon Kuhnt					07-04-2021					----------					Reworked for Package
*/ 
public with sharing class AP_TriggerFactory {

    public static System.TriggerOperation currentOperation;
    public static Boolean isBefore; 
    
    /**
	* @description To control the execution of the handler
    * @param handler - A Trigger Handler to execute
	*/
     public static void execute(AP_ITrigger handler){
        // static variables are used for testing. local variables are need for them to not be overriden.
		System.TriggerOperation currentOperationLocal = currentOperation;
		Boolean isBeforeLocal = isBefore;   
        if (Trigger.isExecuting) {
            currentOperationLocal = Trigger.operationType;
            isBeforeLocal = Trigger.isBefore;
        }

        //-- trigger bypass logic using hierarchical custom setting
        if(Run_Logic__c.getInstance().Bypass_Trigger__c || currentOperationLocal == null || isBeforeLocal == null || handler == null){
            return;
        }

        if(isBeforeLocal){
            // Call the bulk before to handle any caching of data and enable bulkification
            handler.bulkBefore();
        }else{
            handler.bulkAfter();
        }
        
        switch on currentOperationLocal{
            when BEFORE_INSERT {
                //set value on record create
                handler.beforeInsert();
            }
            when BEFORE_UPDATE {
                //set value on record create
                handler.beforeUpdate();
            }
            when BEFORE_DELETE {
                //set value on record create
                handler.beforeDelete();
            }
            when AFTER_INSERT{
                //create related records
                handler.afterInsert();
            }
            when AFTER_UPDATE {
                //set value on record create
                handler.afterUpdate();
            }
            
            when AFTER_DELETE {
                //prevent deletion of sensitive data
                handler.afterDelete();
            }
            when AFTER_UNDELETE{
                //do nothing for AFTER_UNDELETE, BEFORE_DELETE, or BEFORE_UPDATE
                handler.afterUndelete();
            }
        }
        
        // Perform any post processing
        handler.andFinally();
    }
}
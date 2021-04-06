/**
  @Company : aquilliance GmbH
  @Purpose : Trigger factory Tests. 
 
 ***************************************** Modification Log *****************************************
  Modified By					Modified on					Ticket No.					Comments
  Bhushan P.					23-10-2016					----------					Original Version
  Simon Kuhnt					06-04-2021					----------					Added to a new all in 1 Package
*/
@isTest
public with sharing class TriggerFactoryTest {

    @isTest
    public static void TriggerFactoryTest() {
        TriggerFactory.isBefore = false;
        for (System.TriggerOperation currentOperation : System.TriggerOperation.values()) {
            TriggerFactory.currentOperation = currentOperation;
            TriggerFactory.execute(new TriggerHandler());
        }
        TriggerFactory.isBefore = true;
        TriggerFactory.execute(new TriggerHandler());
    }

    public class TriggerHandler implements ITrigger{

    /**
     * bulkBefore
     *
     * This method is called prior to execution of a BEFORE trigger. Use this to cache
     * any data required into maps prior execution of the trigger.
     */
    public void bulkBefore(){}

    public void bulkAfter(){}
        
    public void beforeInsert(){}
    
    public void beforeUpdate(){}
      
    public void beforeDelete(){}
    
    public void afterInsert(){}
    
    public void afterUpdate(){}
    
    public void afterDelete(){}
    
    public void afterUndelete(){}
    
    /**
     * andFinally
     *
     * This method is called once all records have been processed by the trigger. Use this 
     * method to accomplish any final operations such as creation or updates of other records.
     */
    public void andFinally(){}

    }
    
}
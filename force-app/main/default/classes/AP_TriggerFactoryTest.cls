/**
  @Company : aquilliance GmbH
  @Purpose : Trigger factory Tests. 
 
 ***************************************** Modification Log *****************************************
  Modified By					Modified on					Ticket No.					Comments
  Bhushan P.					23-10-2016					----------					Original Version
  Simon Kuhnt					07-04-2021					----------					Reworked for Package
*/
@isTest
public class AP_TriggerFactoryTest {

    /**
	* @description Test the execute Function of the Trigger Factory
	*/
    @isTest
    public static void TriggerFactoryTest() {
        AP_TriggerFactory.execute(null);
        AP_TriggerFactory.execute(new TriggerHandler());
        AP_TriggerFactory.isBefore = false;
        for (System.TriggerOperation currentOperation : System.TriggerOperation.values()) {
            AP_TriggerFactory.currentOperation = currentOperation;
            AP_TriggerFactory.execute(new TriggerHandler());
        }
        AP_TriggerFactory.isBefore = true;
        AP_TriggerFactory.execute(new TriggerHandler());
        Run_Logic__c runLogic = Run_Logic__c.getInstance();
    }

    public class TriggerHandler implements AP_ITrigger{

    public void bulkBefore(){}

    public void bulkAfter(){}
        
    public void beforeInsert(){}
    
    public void beforeUpdate(){}
      
    public void beforeDelete(){}
    
    public void afterInsert(){}
    
    public void afterUpdate(){}
    
    public void afterDelete(){}
    
    public void afterUndelete(){}
    
    public void andFinally(){}

    }
    
}
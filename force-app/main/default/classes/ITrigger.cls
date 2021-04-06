/**
 * Interface containing methods Trigger Handlers must implement to enforce best practice and bulkification of triggers.
 */
global interface ITrigger {
    
    //bulkBefore:This method is called prior to execution of a BEFORE trigger. Use this to cache any data required into   maps prior execution of the trigger.
    
    void bulkBefore();
    void beforeInsert();
    void beforeUpdate();
    void beforeDelete();
        
    //bulkAfter:This method is called prior to execution of a AFTER trigger. Use this to cache any data required into   maps prior execution of the trigger.
    void bulkAfter();
    void afterInsert();
    void afterUpdate();
    void afterDelete();
    void afterUndelete();
    
    /**
     * andFinally
     * This method is called once all records have been processed by the trigger. Use this 
     * method to accomplish any final operations such as creation or updates of other records.
     */
    void andFinally();
}
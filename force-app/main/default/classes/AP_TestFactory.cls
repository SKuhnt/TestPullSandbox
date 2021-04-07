/*
  @Company : aquilliance GmbH
  @Purpose : Test Factory to create Test DataFast
 
 ***************************************** Modification Log *****************************************
  Modified By					Modified on					Ticket No.					Comments
  Simon Kuhnt					02-08-2019					----------					inital version
  Simon Kuhnt					07-04-2021				    ----------					Reworked for Package
*/ 
public class AP_TestFactory {
    private static Integer counter = 0;

    /**
	* @description used to Count the records up and retrun the value
	* @return counter - current value of the Counter
	*/
    private static Integer countUp(){
        return ++counter;
    }

    /**
	* @description Create a new List of SObjects with the required fields filled (except lookups)
    * Overloaded with alot of methods. 
    * always needs (Schema.SObjectType sObjectType, Boolean isInsert). 
    * All other parameters are optional.
    * Syntax: getRecords(Schema.SObjectType sObjectType, Boolean isInsert, 
    * \<String recordTypeDeveloperName=''\>, \<Integer rows=1\>, 
    * \<List SObject|List Id|Set Id related=[], Schema.SObjectField sObjectField=null\>)
    * @param sObjectType SObject Type of the Records.
    * @param isInsert Whether the Records should be inserted.
    * @param recordTypeDeveloperName Developername of the RecordType ID to be filled.
    * @param rows Number of Records to be created.
    * @param relatedSObjectIds Record Ids to which the Records should be related.
    * @param sObjectField Schema.SObjectField of the field via which the related Records are related.
	* @return List<SObject> The prepared Records
	*/
    public static List<SObject> getRecords(Schema.SObjectType sObjectType, Boolean isInsert, String recordTypeDeveloperName, Integer rows, Set<Id> relatedSObjectIds, Schema.SObjectField sObjectField){
        Map<String, Schema.DescribeFieldResult> requiredFieldMap = AP_Functions.getRequiredFields(sObjectType);
        Id recordTypeId = AP_Functions.getRecordTypeIdByDevName(sObjectType, recordTypeDeveloperName);
        List<SObject> sObjects = new List<SObject>();
        for (Integer i = 0; i < rows; i++) {
            if(relatedSObjectIds.isEmpty() || sObjectField == null){
               sObjects.add(getPreparedSObject(sObjectType, recordTypeId, requiredFieldMap));
            } else {
                for (Id relatedId : relatedSObjectIds) {
                    SObject newSObject = getPreparedSObject(sObjectType, recordTypeId, requiredFieldMap);
                    newSObject.put(sObjectField, relatedId);
                    sObjects.add(newSObject);
                }
            }
        }
        if(isInsert){
            AP_CrudUtil.insertRecords(sObjects, true);
        }
        return sObjects;
    }

    /**
	* @description Create a new List of SObjects with the required fields filled (except lookups)
    * Overloaded with alot of methods. 
    * always needs (Schema.SObjectType sObjectType, Boolean isInsert). 
    * All other parameters are optional.
    * Syntax: getRecords(Schema.SObjectType sObjectType, Boolean isInsert, 
    * \<String recordTypeDeveloperName=''\>, \<Integer rows=1\>, 
    * \<List SObject|List Id|Set Id related=[], Schema.SObjectField sObjectField=null\>)
    * @param sObjectType SObject Type of the Records.
    * @param isInsert Whether the Records should be inserted.
	* @return List<SObject> The prepared Records
	*/
    public static List<SObject> getRecords(Schema.SObjectType sObjectType, Boolean isInsert){
        return getRecords(sObjectType, isInsert, '', 1, new Set<Id>(), null);
    }

    /**
	* @description Create a new List of SObjects with the required fields filled (except lookups)
    * Overloaded with alot of methods. 
    * always needs (Schema.SObjectType sObjectType, Boolean isInsert). 
    * All other parameters are optional.
    * Syntax: getRecords(Schema.SObjectType sObjectType, Boolean isInsert, 
    * \<String recordTypeDeveloperName=''\>, \<Integer rows=1\>, 
    * \<List SObject|List Id|Set Id related=[], Schema.SObjectField sObjectField=null\>)
    * @param sObjectType SObject Type of the Records.
    * @param isInsert Whether the Records should be inserted.
    * @param recordTypeDeveloperName Developername of the RecordType ID to be filled.
	* @return List<SObject> The prepared Records
	*/
    public static List<SObject> getRecords(Schema.SObjectType sObjectType, Boolean isInsert, String recordTypeDeveloperName){
        return getRecords(sObjectType, isInsert, recordTypeDeveloperName, 1, new Set<Id>(), null);
    }

    /**
	* @description Create a new List of SObjects with the required fields filled (except lookups)
    * Overloaded with alot of methods. 
    * always needs (Schema.SObjectType sObjectType, Boolean isInsert). 
    * All other parameters are optional.
    * Syntax: getRecords(Schema.SObjectType sObjectType, Boolean isInsert, 
    * \<String recordTypeDeveloperName=''\>, \<Integer rows=1\>, 
    * \<List SObject|List Id|Set Id related=[], Schema.SObjectField sObjectField=null\>)
    * @param sObjectType SObject Type of the Records.
    * @param isInsert Whether the Records should be inserted.
    * @param rows Number of Records to be created.
	* @return List<SObject> The prepared Records
	*/
    public static List<SObject> getRecords(Schema.SObjectType sObjectType, Boolean isInsert, Integer rows){
        return getRecords(sObjectType, isInsert, '', rows, new Set<Id>(), null);
    }

    /**
	* @description Create a new List of SObjects with the required fields filled (except lookups)
    * Overloaded with alot of methods. 
    * always needs (Schema.SObjectType sObjectType, Boolean isInsert). 
    * All other parameters are optional.
    * Syntax: getRecords(Schema.SObjectType sObjectType, Boolean isInsert, 
    * \<String recordTypeDeveloperName=''\>, \<Integer rows=1\>, 
    * \<List SObject|List Id|Set Id related=[], Schema.SObjectField sObjectField=null\>)
    * @param sObjectType SObject Type of the Records.
    * @param isInsert Whether the Records should be inserted.
    * @param recordTypeDeveloperName Developername of the RecordType ID to be filled.
    * @param rows Number of Records to be created.
	* @return List<SObject> The prepared Records
	*/
    public static List<SObject> getRecords(Schema.SObjectType sObjectType, Boolean isInsert, String recordTypeDeveloperName, Integer rows){
        return getRecords(sObjectType, isInsert, recordTypeDeveloperName, rows, new Set<Id>(), null);
    }

    /**
	* @description Create a new List of SObjects with the required fields filled (except lookups)
    * Overloaded with alot of methods. 
    * always needs (Schema.SObjectType sObjectType, Boolean isInsert). 
    * All other parameters are optional.
    * Syntax: getRecords(Schema.SObjectType sObjectType, Boolean isInsert, 
    * \<String recordTypeDeveloperName=''\>, \<Integer rows=1\>, 
    * \<List SObject|List Id|Set Id related=[], Schema.SObjectField sObjectField=null\>)
    * @param sObjectType SObject Type of the Records.
    * @param isInsert Whether the Records should be inserted.
    * @param relatedSObjects Records to which the Records should be related.
    * @param sObjectField Schema.SObjectField of the field via which the related Records are related.
	* @return List<SObject> The prepared Records
	*/
    public static List<SObject> getRecords(Schema.SObjectType sObjectType, Boolean isInsert, List<SObject> relatedSObjects, Schema.SObjectField sObjectField){
        return getRecords(sObjectType, isInsert, '', 1, relatedSObjects, sObjectField);
    }

    /**
	* @description Create a new List of SObjects with the required fields filled (except lookups)
    * Overloaded with alot of methods. 
    * always needs (Schema.SObjectType sObjectType, Boolean isInsert). 
    * All other parameters are optional.
    * Syntax: getRecords(Schema.SObjectType sObjectType, Boolean isInsert, 
    * \<String recordTypeDeveloperName=''\>, \<Integer rows=1\>, 
    * \<List SObject|List Id|Set Id related=[], Schema.SObjectField sObjectField=null\>)
    * @param sObjectType SObject Type of the Records.
    * @param isInsert Whether the Records should be inserted.
    * @param relatedSObjectIds Record Ids to which the Records should be related.
    * @param sObjectField Schema.SObjectField of the field via which the related Records are related.
	* @return List<SObject> The prepared Records
	*/
    public static List<SObject> getRecords(Schema.SObjectType sObjectType, Boolean isInsert, Set<Id> relatedSObjectIds, Schema.SObjectField sObjectField){
        return getRecords(sObjectType, isInsert, '', 1, relatedSObjectIds, sObjectField);
    }

    /**
	* @description Create a new List of SObjects with the required fields filled (except lookups)
    * Overloaded with alot of methods. 
    * always needs (Schema.SObjectType sObjectType, Boolean isInsert). 
    * All other parameters are optional.
    * Syntax: getRecords(Schema.SObjectType sObjectType, Boolean isInsert, 
    * \<String recordTypeDeveloperName=''\>, \<Integer rows=1\>, 
    * \<List SObject|List Id|Set Id related=[], Schema.SObjectField sObjectField=null\>)
    * @param sObjectType SObject Type of the Records.
    * @param isInsert Whether the Records should be inserted.
    * @param relatedSObjectIds Record Ids to which the Records should be related.
    * @param sObjectField Schema.SObjectField of the field via which the related Records are related.
	* @return List<SObject> The prepared Records
	*/
    public static List<SObject> getRecords(Schema.SObjectType sObjectType, Boolean isInsert, List<Id> relatedSObjectIds, Schema.SObjectField sObjectField){
        return getRecords(sObjectType, isInsert, '', 1, relatedSObjectIds, sObjectField);
    }

    /**
	* @description Create a new List of SObjects with the required fields filled (except lookups)
    * Overloaded with alot of methods. 
    * always needs (Schema.SObjectType sObjectType, Boolean isInsert). 
    * All other parameters are optional.
    * Syntax: getRecords(Schema.SObjectType sObjectType, Boolean isInsert, 
    * \<String recordTypeDeveloperName=''\>, \<Integer rows=1\>, 
    * \<List SObject|List Id|Set Id related=[], Schema.SObjectField sObjectField=null\>)
    * @param sObjectType SObject Type of the Records.
    * @param isInsert Whether the Records should be inserted.
    * @param recordTypeDeveloperName Developername of the RecordType ID to be filled.
    * @param relatedSObjects Records to which the Records should be related.
    * @param sObjectField Schema.SObjectField of the field via which the related Records are related.
	* @return List<SObject> The prepared Records
	*/
    public static List<SObject> getRecords(Schema.SObjectType sObjectType, Boolean isInsert, String recordTypeDeveloperName, List<SObject> relatedSObjects, Schema.SObjectField sObjectField){
        return getRecords(sObjectType, isInsert, recordTypeDeveloperName, 1, relatedSObjects, sObjectField);
    }

    
    /**
	* @description Create a new List of SObjects with the required fields filled (except lookups)
    * Overloaded with alot of methods. 
    * always needs (Schema.SObjectType sObjectType, Boolean isInsert). 
    * All other parameters are optional.
    * Syntax: getRecords(Schema.SObjectType sObjectType, Boolean isInsert, 
    * \<String recordTypeDeveloperName=''\>, \<Integer rows=1\>, 
    * \<List SObject|List Id|Set Id related=[], Schema.SObjectField sObjectField=null\>)
    * @param sObjectType SObject Type of the Records.
    * @param isInsert Whether the Records should be inserted.
    * @param recordTypeDeveloperName Developername of the RecordType ID to be filled.
    * @param relatedSObjectIds Record Ids to which the Records should be related.
    * @param sObjectField Schema.SObjectField of the field via which the related Records are related.
	* @return List<SObject> The prepared Records
	*/
    public static List<SObject> getRecords(Schema.SObjectType sObjectType, Boolean isInsert, String recordTypeDeveloperName, Set<Id> relatedSObjectIds, Schema.SObjectField sObjectField){
        return getRecords(sObjectType, isInsert, recordTypeDeveloperName, 1, relatedSObjectIds, sObjectField);
    }

    
    /**
	* @description Create a new List of SObjects with the required fields filled (except lookups)
    * Overloaded with alot of methods. 
    * always needs (Schema.SObjectType sObjectType, Boolean isInsert). 
    * All other parameters are optional.
    * Syntax: getRecords(Schema.SObjectType sObjectType, Boolean isInsert, 
    * \<String recordTypeDeveloperName=''\>, \<Integer rows=1\>, 
    * \<List SObject|List Id|Set Id related=[], Schema.SObjectField sObjectField=null\>)
    * @param sObjectType SObject Type of the Records.
    * @param isInsert Whether the Records should be inserted.
    * @param recordTypeDeveloperName Developername of the RecordType ID to be filled.
    * @param relatedSObjectIds Record Ids to which the Records should be related.
    * @param sObjectField Schema.SObjectField of the field via which the related Records are related.
	* @return List<SObject> The prepared Records
	*/
    public static List<SObject> getRecords(Schema.SObjectType sObjectType, Boolean isInsert, String recordTypeDeveloperName, List<Id> relatedSObjectIds, Schema.SObjectField sObjectField){
        return getRecords(sObjectType, isInsert, recordTypeDeveloperName, 1, relatedSObjectIds, sObjectField);
    }

    
    /**
	* @description Create a new List of SObjects with the required fields filled (except lookups)
    * Overloaded with alot of methods. 
    * always needs (Schema.SObjectType sObjectType, Boolean isInsert). 
    * All other parameters are optional.
    * Syntax: getRecords(Schema.SObjectType sObjectType, Boolean isInsert, 
    * \<String recordTypeDeveloperName=''\>, \<Integer rows=1\>, 
    * \<List SObject|List Id|Set Id related=[], Schema.SObjectField sObjectField=null\>)
    * @param sObjectType SObject Type of the Records.
    * @param isInsert Whether the Records should be inserted.
    * @param rows Number of Records to be created.
    * @param relatedSObjects Records to which the Records should be related.
    * @param sObjectField Schema.SObjectField of the field via which the related Records are related.
	* @return List<SObject> The prepared Records
	*/
    public static List<SObject> getRecords(Schema.SObjectType sObjectType, Boolean isInsert, Integer rows, List<SObject> relatedSObjects, Schema.SObjectField sObjectField){
        return getRecords(sObjectType, isInsert, '', rows, new Map<Id, SObject>(relatedSObjects).keySet(), sObjectField);
    }

    /**
	* @description Create a new List of SObjects with the required fields filled (except lookups)
    * Overloaded with alot of methods. 
    * always needs (Schema.SObjectType sObjectType, Boolean isInsert). 
    * All other parameters are optional.
    * Syntax: getRecords(Schema.SObjectType sObjectType, Boolean isInsert, 
    * \<String recordTypeDeveloperName=''\>, \<Integer rows=1\>, 
    * \<List SObject|List Id|Set Id related=[], Schema.SObjectField sObjectField=null\>)
    * @param sObjectType SObject Type of the Records.
    * @param isInsert Whether the Records should be inserted.
    * @param rows Number of Records to be created.
    * @param relatedSObjectIds Record Ids to which the Records should be related.
    * @param sObjectField Schema.SObjectField of the field via which the related Records are related.
	* @return List<SObject> The prepared Records
	*/
    public static List<SObject> getRecords(Schema.SObjectType sObjectType, Boolean isInsert, Integer rows, List<Id> relatedSObjectIds, Schema.SObjectField sObjectField){
        return getRecords(sObjectType, isInsert, '', rows, new Set<Id>(relatedSObjectIds), sObjectField);
    }

    /**
	* @description Create a new List of SObjects with the required fields filled (except lookups)
    * Overloaded with alot of methods. 
    * always needs (Schema.SObjectType sObjectType, Boolean isInsert). 
    * All other parameters are optional.
    * Syntax: getRecords(Schema.SObjectType sObjectType, Boolean isInsert, 
    * \<String recordTypeDeveloperName=''\>, \<Integer rows=1\>, 
    * \<List SObject|List Id|Set Id related=[], Schema.SObjectField sObjectField=null\>)
    * @param sObjectType SObject Type of the Records.
    * @param isInsert Whether the Records should be inserted.
    * @param rows Number of Records to be created.
    * @param relatedSObjectIds Record Ids to which the Records should be related.
    * @param sObjectField Schema.SObjectField of the field via which the related Records are related.
	* @return List<SObject> The prepared Records
	*/
    public static List<SObject> getRecords(Schema.SObjectType sObjectType, Boolean isInsert, Integer rows, Set<Id> relatedSObjectIds, Schema.SObjectField sObjectField){
        return getRecords(sObjectType, isInsert, '', rows, relatedSObjectIds, sObjectField);
    }

    
    /**
	* @description Create a new List of SObjects with the required fields filled (except lookups)
    * Overloaded with alot of methods. 
    * always needs (Schema.SObjectType sObjectType, Boolean isInsert). 
    * All other parameters are optional.
    * Syntax: getRecords(Schema.SObjectType sObjectType, Boolean isInsert, 
    * \<String recordTypeDeveloperName=''\>, \<Integer rows=1\>, 
    * \<List SObject|List Id|Set Id related=[], Schema.SObjectField sObjectField=null\>)
    * @param sObjectType SObject Type of the Records.
    * @param isInsert Whether the Records should be inserted.
    * @param recordTypeDeveloperName Developername of the RecordType ID to be filled.
    * @param rows Number of Records to be created.
    * @param relatedSObjects Record Ids to which the Records should be related.
    * @param sObjectField Schema.SObjectField of the field via which the related Records are related.
	* @return List<SObject> The prepared Records
	*/
    public static List<SObject> getRecords(Schema.SObjectType sObjectType, Boolean isInsert, String recordTypeDeveloperName, Integer rows, List<SObject> relatedSObjects, Schema.SObjectField sObjectField){
        return getRecords(sObjectType, isInsert, recordTypeDeveloperName, rows, new Map<Id, SObject>(relatedSObjects).keySet(), sObjectField);
    }

    
    /**
	* @description Create a new List of SObjects with the required fields filled (except lookups)
    * Overloaded with alot of methods. 
    * always needs (Schema.SObjectType sObjectType, Boolean isInsert). 
    * All other parameters are optional.
    * Syntax: getRecords(Schema.SObjectType sObjectType, Boolean isInsert, 
    * \<String recordTypeDeveloperName=''\>, \<Integer rows=1\>, 
    * \<List SObject|List Id|Set Id related=[], Schema.SObjectField sObjectField=null\>)
    * @param sObjectType SObject Type of the Records.
    * @param isInsert Whether the Records should be inserted.
    * @param recordTypeDeveloperName Developername of the RecordType ID to be filled.
    * @param rows Number of Records to be created.
    * @param relatedSObjectIds Record Ids to which the Records should be related.
    * @param sObjectField Schema.SObjectField of the field via which the related Records are related.
	* @return List<SObject> The prepared Records
	*/
    public static List<SObject> getRecords(Schema.SObjectType sObjectType, Boolean isInsert, String recordTypeDeveloperName, Integer rows, List<Id> relatedSObjectIds, Schema.SObjectField sObjectField){
        return getRecords(sObjectType, isInsert, recordTypeDeveloperName, rows, new Set<Id>(relatedSObjectIds), sObjectField);
    }

    /**
	* @description creates a prepared SObject
    * @param sObjectType the SObject for which a new SObject instace shall be created.
    * @param recordTypeId the recordTypeId if null it will not be set
    * @param requiredFieldMap a Map of required fields which have to be filled
	* @retrun SObject the new prepared SObject
	*/
    private static SObject getPreparedSObject(Schema.SObjectType sObjectType, Id recordTypeId, Map<String, Schema.DescribeFieldResult> requiredFieldMap){
        sObject sObj = sObjectType.newSObject();
        AP_Functions.setRequiredFields(sObj, requiredFieldMap, countUp());
        if(recordTypeId != null){
            sObj.put('RecordTypeId', recordTypeId);
        }
        return sObj;
    }

    /**
	* @description adds a value to a field on a list of Records.
    * @param newRecords List of Records to be filled.
    * @param fieldName Schema.SObjectField of the Field to be filled.
    * @param value the value with which the field should be filled.
	*/
    public static void addFixedValue(List<SObject> newRecords, Schema.SObjectField fieldName, Object value){
        for(SObject newRecord : newRecords){
            newRecord.put(fieldName, value);
        }
    }

    /**
	* @description Iterates through the Records and fills each with a related record Id.
    * @param records List of Records to be filled.
    * @param relatedSObjects the records with which the field should be filled.
    * @param fieldName Schema.SObjectField of the Field to be filled.
	*/
    public static void fillSObjects(List<SObject> records, List<SObject> relatedSObjects, Schema.SObjectField sObjectField){
        Integer mod = relatedSObjects.size();
		for (Integer i = 0; i < records.size(); i++){
			records[i].put(sObjectField, relatedSObjects[Math.mod(i, mod)].Id);
		}
    }

    /**
	* @description Iterates through the Records and fills each with a related record Id.
    * @param records List of Records to be filled.
    * @param relatedSObjectIds the record Ids with which the field should be filled.
    * @param fieldName Schema.SObjectField of the Field to be filled.
	*/
    public static void fillSObjects(List<SObject> records, List<Id> relatedSObjectIds, Schema.SObjectField sObjectField){
        Integer mod = relatedSObjectIds.size();
		for (Integer i = 0; i < records.size(); i++){
			records[i].put(sObjectField, relatedSObjectIds[Math.mod(i, mod)]);
		}
    }

    /**
	* @description Iterates through the Records and fills each with a related record Id.
    * @param records List of Records to be filled.
    * @param relatedSObjectIds the record Ids with which the field should be filled.
    * @param fieldName Schema.SObjectField of the Field to be filled.
	*/
    public static void fillSObjects(List<SObject> records, Set<Id> relatedSObjectIds, Schema.SObjectField sObjectField){
        fillSObjects(records, new List<Id>(relatedSObjectIds), sObjectField);
    }

}
/*
  @Company : aquilliance GmbH
  @Purpose : Test Factory to create Test DataFast
 
 ***************************************** Modification Log *****************************************
  Modified By					Modified on					Ticket No.					Comments
  Simon Kuhnt					02-08-2019					----------					inital version
  Simon Kuhnt					06-04-2021				    ----------					Added to a new all in 1 Package
*/ 
global class AQU_Util_TestFactory {
    private static Integer counter = 0;

    /**
	* @description used to Count the records up and retrun the value
	* @retrun counter - current value of the Counter
	*/
    private static Integer countUp(){
        return ++counter;
    }

    //Overloaded Methods
    //Mthods always need (String sObjectName, Boolean isInsert)
    //all other parameters are optional.
    //Syntax: getSObject(String sObjectName, Boolean isInsert, <String recordTypeDeveloperName=''>, <Integer rows=1>, <List<SObject>|List<Id>|Set<Id> related=new List or Set, String fieldApiName=''>)
    global static List<SObject> getSObject(String sObjectName, Boolean isInsert, String recordTypeDeveloperName, Integer rows, Set<Id> relatedSObjectIds, String fieldApiName){
        Map<String, Schema.DescribeFieldResult> requiredFieldMap = AQU_Util_Functions.getRequiredFields(sObjectName);
        Id recordTypeId = AQU_Util_Functions.getRecordTypeIdByDevName(sObjectName, recordTypeDeveloperName);
        List<SObject> sObjects = new List<SObject>();
        for (Integer i = 0; i < rows; i++) {
            if(relatedSObjectIds.isEmpty() || fieldApiName == ''){
               sObjects.add(getPreparedSObject(sObjectName, recordTypeId, requiredFieldMap));
            } else {
                for (Id relatedId : relatedSObjectIds) {
                    SObject newSObject = getPreparedSObject(sObjectName, recordTypeId, requiredFieldMap);
                    newSObject.put(fieldApiName, relatedId);
                    sObjects.add(newSObject);
                }
            }
        }
        if(isInsert){
            insert sObjects;
        }
        return sObjects;
    }

    global static void addFixedValue(List<SObject> newRecords, Schema.SObjectField fieldName, Object value){
        for(SObject newRecord : newRecords){
            newRecord.put(fieldName, value);
        }
    }

    global static List<SObject> getSObject(String sObjectName, Boolean isInsert){
        return getSObject(sObjectName, isInsert, '', 1, new Set<Id>(), '');
    }

    global static List<SObject> getSObject(String sObjectName, Boolean isInsert, String recordTypeDeveloperName){
        return getSObject(sObjectName, isInsert, recordTypeDeveloperName, 1, new Set<Id>(), '');
    }

    global static List<SObject> getSObject(String sObjectName, Boolean isInsert, Integer rows){
        return getSObject(sObjectName, isInsert, '', rows, new Set<Id>(), '');
    }

    global static List<SObject> getSObject(String sObjectName, Boolean isInsert, String recordTypeDeveloperName, Integer rows){
        return getSObject(sObjectName, isInsert, recordTypeDeveloperName, rows, new Set<Id>(), '');
    }

    //
    global static List<SObject> getSObject(String sObjectName, Boolean isInsert, List<SObject> relatedSObjects, String fieldApiName){
        return getSObject(sObjectName, isInsert, '', 1, relatedSObjects, fieldApiName);
    }

    //
    global static List<SObject> getSObject(String sObjectName, Boolean isInsert, Set<Id> relatedSObjectIds, String fieldApiName){
        return getSObject(sObjectName, isInsert, '', 1, relatedSObjectIds, fieldApiName);
    }

    //
    global static List<SObject> getSObject(String sObjectName, Boolean isInsert, List<Id> relatedSObjectIds, String fieldApiName){
        return getSObject(sObjectName, isInsert, '', 1, relatedSObjectIds, fieldApiName);
    }

    //
    global static List<SObject> getSObject(String sObjectName, Boolean isInsert, String recordTypeDeveloperName, List<SObject> relatedSObjects, String fieldApiName){
        return getSObject(sObjectName, isInsert, recordTypeDeveloperName, 1, relatedSObjects, fieldApiName);
    }

    //
    global static List<SObject> getSObject(String sObjectName, Boolean isInsert, String recordTypeDeveloperName, Set<Id> relatedSObjectIds, String fieldApiName){
        return getSObject(sObjectName, isInsert, recordTypeDeveloperName, 1, relatedSObjectIds, fieldApiName);
    }

    //
    global static List<SObject> getSObject(String sObjectName, Boolean isInsert, String recordTypeDeveloperName, List<Id> relatedSObjectIds, String fieldApiName){
        return getSObject(sObjectName, isInsert, recordTypeDeveloperName, 1, relatedSObjectIds, fieldApiName);
    }

    //
    global static List<SObject> getSObject(String sObjectName, Boolean isInsert, Integer rows, List<SObject> relatedSObjects, String fieldApiName){
        return getSObject(sObjectName, isInsert, '', rows, new Map<Id, SObject>(relatedSObjects).keySet(), fieldApiName);
    }

    //Overload with empty recordTypeDeveloperName
    global static List<SObject> getSObject(String sObjectName, Boolean isInsert, Integer rows, List<Id> relatedSObjectIds, String fieldApiName){
        return getSObject(sObjectName, isInsert, '', rows, new Set<Id>(relatedSObjectIds), fieldApiName);
    }

    //Overload with empty recordTypeDeveloperName
    global static List<SObject> getSObject(String sObjectName, Boolean isInsert, Integer rows, Set<Id> relatedSObjectIds, String fieldApiName){
        return getSObject(sObjectName, isInsert, '', rows, relatedSObjectIds, fieldApiName);
    }

    //Overload to Set of Ids
    global static List<SObject> getSObject(String sObjectName, Boolean isInsert, String recordTypeDeveloperName, Integer rows, List<SObject> relatedSObjects, String fieldApiName){
        return getSObject(sObjectName, isInsert, recordTypeDeveloperName, rows, new Map<Id, SObject>(relatedSObjects).keySet(), fieldApiName);
    }

    //Overload to Set of Ids
    global static List<SObject> getSObject(String sObjectName, Boolean isInsert, String recordTypeDeveloperName, Integer rows, List<Id> relatedSObjectIds, String fieldApiName){
        return getSObject(sObjectName, isInsert, recordTypeDeveloperName, rows, new Set<Id>(relatedSObjectIds), fieldApiName);
    }

    /**
	* @description creates a prepared SObject
    * @param sObjectName the Name of the SObject for which a new SObject instace shall be created.
    * @param recordTypeId the recordTypeId if null it will not be set
    * @param requiredFieldMap a Map of required fields which have to be filled
	* @retrun SObject the new prepared SObject
	*/
    private static SObject getPreparedSObject(String sObjectName, Id recordTypeId, Map<String, Schema.DescribeFieldResult> requiredFieldMap){
        sObject sObj = Schema.getGlobalDescribe().get(sObjectName).newSObject();
        AQU_Util_Functions.setRequiredFields(sObj, requiredFieldMap, countUp());
        if(recordTypeId != null){
            sObj.put('RecordTypeId', recordTypeId);
        }
        return sObj;
    }

    global static void fillSObjects(List<SObject> records, List<SObject> relatedSObjects, String fieldApiName){
        Integer mod = relatedSObjects.size();
		for (Integer i = 0; i < records.size(); i++){
			records[i].put(fieldApiName, relatedSObjects[Math.mod(i, mod)].Id);
		}
    }

    global static void fillSObjects(List<SObject> records, List<Id> relatedSObjectIds, String fieldApiName){
        Integer mod = relatedSObjectIds.size();
		for (Integer i = 0; i < records.size(); i++){
			records[i].put(fieldApiName, relatedSObjectIds[Math.mod(i, mod)]);
		}
    }

    global static void fillSObjects(List<SObject> records, Set<Id> relatedSObjectIds, String fieldApiName){
        fillSObjects(records, new List<Id>(relatedSObjectIds), fieldApiName);
    }

}
/**
 @Company : aquilliance GmbH
 @Purpose : Functions to Convert Strings and Schemas back and forth
  
 ********************************* Modification Log ***********************************
Modified by					Modified on				Ticket No.					Comments
Simon Kuhnt					07-04-2021				----------					initial version
*/
public class AP_SchemaUtil {
	/**
	 * @description generates the SObject Name for the given Id
	 * @param relevantId Id Of Any SObject
	 * @return String SObject Name for the given Id
	*/
	public static String getSObjectName(Id relevantId) {
		return relevantId.getSObjectType().getDescribe().getName();
	}

	/**
	 * @description generates the SObject Name for the given SObject
	 * @param record Any SObject
	 * @return String SObject Name for the given SObject
	*/
	public static String getSObjectName(SObject record) {
		return record.getSObjectType().getDescribe().getName();
	}

	/**
	 * @description generates the SObject Name for the given SObjectType
	 * @param recordSObjectType Any SObjectType like: Account.getSObjectType()
	 * @return String SObject Name for the Schema
	*/
	public static String getSObjectName(Schema.SObjectType recordSObjectType) {
        //recordSObjectType.getDescribe().getSObjectType();
		return recordSObjectType.getDescribe().getName();
	}

	/**
	 * @description generates the Field Name for the Field Schema
	 * @param sObjectField Any SObjectField like: Account.Description
	 * @return String Field Name for the Field Schema
	*/
	public static String getFieldName(Schema.SObjectField sObjectField){
		return sObjectField.getDescribe().getName();
	}

	/**
	 * @description converts a String into an SObjectType.
	 * most of the time Object.getSObjectType() is better for example Account.getSObjectType()
	 * @param objectName Name of an Object
	 * @return Schema.SObjectType for the Object Name
	*/
	public static Schema.SObjectType getSObjectType(String objectName){
		Schema.SObjectType sObjectType = Schema.getGlobalDescribe().get(objectName);
		if (sObjectType == null) {
			throw new AP_Functions.aqCustomException('Object Name [' + objectName + '] wasn\'t found!');
		}
		return sObjectType; 
	}

	/**
	 * @description generates the Field Schema from Object & Field
	 * most of the time Object.field is better for example Account.Name
	 * @param sObjectType Schema.SObjectType of the Object
	 * @param fieldName API Name of the field
	 * @return Schema.SObjectField Field Schema
	*/
	public static Schema.SObjectField getSObjectField(Schema.SObjectType sObjectType, String fieldName){
        Schema.SObjectField sObjectField = sObjectType.getDescribe().fields.getMap().get(fieldName);
		if (sObjectField == null) {
			throw new AP_Functions.aqCustomException('Field Name [' + fieldName + '] on the Object [' + getSObjectName(sObjectType) + '] wasn\'t found!');
		}
		return sObjectField;
	}

    
	/**
	 * @description generates the Field Schema from Object & Field
	 * most of the time Object.field is better for example Account.Name
	 * @param objectName Name of the Object
	 * @param fieldName API Name of the field
	 * @return Schema.SObjectField Field Schema
	*/
	public static Schema.SObjectField getSObjectField(String objectName, String fieldName){
		return getSObjectField(getSObjectType(objectName), fieldName);
	}
}
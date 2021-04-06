/*
 @Company : aquilliance GmbH
 @Purpose : Helper AQU_Util_Functions for everyday usage, a swiss army knife so to speak
  
 ********************************* Modification Log ***********************************
Modified by					Modified on				Ticket No.					Comments
Simon Kuhnt					%%%%%%%%%%%				%%%%%%%%%%					initial version
Torben Sieber				01-07-2019				AQUINT-98					integrated in the test helper
Simon Kuhnt					30-07-2019				----------					Package version
Simon Kuhnt					19-08-2019				----------					Updated for first test Release Version
Simon Kuhnt					06-04-2021				----------					Added to a new all in 1 Package
*/
global class AQU_Util_Functions {
	
	global class aqCustomException extends Exception { 
		global String CONTACT_ADMIN = 'Sorry, something went wrong while executing the commands. Please contact your administrator.';
		global String DEFAULT_MESSAGE = 'Sorry, something went wrong.';
	}

	/**
	 * @description generates the SObject Name for the given Id
	 * @param relevantId Id Of Any SObject
	 * @return String SObject Name for the given Id
	*/
	global static String getSObjectName(Id relevantId) {
		return relevantId.getSObjectType().getDescribe().getName();
	}

	/**
	 * @description generates the SObject Name for the given SObject
	 * @param record Any SObject
	 * @return String SObject Name for the given SObject
	*/
	global static String getSObjectName(SObject record) {
		return record.getSObjectType().getDescribe().getName();
	}

	/**
	 * @description generates the SObject Name for the given SObjectType
	 * @param recordSObjectType Any SObjectType like: Account.getSObjectType()
	 * @return String SObject Name for the Schema
	*/
	global static String getSObjectName(Schema.SObjectType recordSObjectType) {
		return recordSObjectType.getDescribe().getName();
	}

	/**
	 * @description generates the Field Name for the Field Schema
	 * @param sObjectField Any SObjectField like: Account.Description
	 * @return String Field Name for the Field Schema
	*/
	global static String getFieldName(Schema.SObjectField sObjectField){
		return sObjectField.getDescribe().Name;
	}

	/**
	 * @description generates a String with all Fields concat for an ObjectName
	 * @param objectName The Name of a SObject
	 * @return String with Fields concatted
	*/
	global static String generateFieldsForQuery(String objectName) {
		String fields = '';
		Boolean next = false;
		for (String field : getDescribeSObjectResult(objectName).fields.getMap().keySet()) {
			if (next) {
				fields += ', ' + field;
			}
			else {
				next = true;
				fields += field;
			}
		}
		return fields;
	}

	/**
	 * @description generates a String with all Fields concat and a prefix for an ObjectName
	 * @param objectName The Name of a SObject
	 * @param prefix prefix for the Object
	 * @return String with Fields and prefix concatted
	 */
	global static String generateFieldsForQuery(String objectName, String prefix) {
		String fields = '';
		Boolean next = false;
		for (String field : getDescribeSObjectResult(objectName).fields.getMap().keySet()) {
			if (next) {
				fields += ', ' + prefix + '.' + field;
			}
			else {
				next = true;
				fields += prefix + '.' + field;
			}
		}
		return fields;
	}

	/**
	* @description Will get all possible picklist values
	* @param objectName Name of the Object of the field whose values we want to know
	* @param fieldName Name of the Field from that we want to get the values
	* @return List with all picklist values
	*/ 
	global static List<String> getPickListValues(String objectName, String fieldName) {
		List<String> pickListValuesList = new List<String> ();
		Schema.DescribeFieldResult fieldResult = getDescribeFieldResult(getDescribeSObjectResult(objectName), fieldName);
		for (Schema.PicklistEntry picklistEntry : fieldResult.getPicklistValues()) {
			pickListValuesList.add(picklistEntry.getValue());
		}
		return pickListValuesList;
	}

	/**
	* @description Will get all labels from a picklist field
	* @param objectName Name of the Object of the field whose labels we want to know
	* @param fieldName Name of the Field from that we want to get the values
	* @return List with all picklist labels
	*/ 
	global static List<String> getPickListLabels(String objectName, String fieldName) {
		List<String> pickListLabelList = new List<String> ();
		Schema.DescribeFieldResult fieldResult = getDescribeFieldResult(getDescribeSObjectResult(objectName), fieldName);
		for (Schema.PicklistEntry picklistEntry : fieldResult.getPicklistValues()) {
			pickListLabelList.add(picklistEntry.getValue());
		}
		return pickListLabelList;
	}

	/**
	* @description Will return a map from picklist label to picklist value
	* @param objectName Name of the Object of the field whose labels we want to know
	* @param fieldName Name of the Field from that we want to get the values
	* @return Map with LABEL -> VALUE Pairs
	*/ 
	global static Map<String, String> getPickListLabelValueMap(String objectName, String fieldName) {
		Map<String, String> picklistLabelValueMap = new Map<String, String> ();
		Schema.DescribeFieldResult fieldResult = getDescribeFieldResult(getDescribeSObjectResult(objectName), fieldName);
		for (Schema.PicklistEntry picklistEntry : fieldResult.getPicklistValues()) {
			picklistLabelValueMap.put(picklistEntry.getLabel(), picklistEntry.getValue());
		}
		return picklistLabelValueMap;
	}

	/**
	* @description Will return a map from picklist value to label
	* @param objectName Name of the Object of the field whose labels we want to know
	* @param fieldName Name of the Field from that we want to get the values
	* @return Map with VALUE -> LABEL Pairs
	*/ 
	global static Map<String, String> getPickListValueLabelMap(String objectName, String fieldName) {
		Map<String, String> picklistLabelValueMap = new Map<String, String> ();
		Schema.DescribeFieldResult fieldResult = getDescribeFieldResult(getDescribeSObjectResult(objectName), fieldName);
		for (Schema.PicklistEntry picklistEntry : fieldResult.getPicklistValues()) {
			picklistLabelValueMap.put(picklistEntry.getValue(), picklistEntry.getLabel());
		}
		return picklistLabelValueMap;
	}

	/**
	* @description Will return a getDescribe sObject Result of the given Object
	* @param objectName The object from which we want to know the result
	* @return Describe SObject Result of the given Object 
	*/ 
	global static Schema.DescribeSObjectResult getDescribeSObjectResult(String objectName) {
		Schema.SObjectType objectResult = Schema.getGlobalDescribe().get(objectName);
		if (objectResult == null) {
			//throw exception
			throw new aqCustomException('Object Name [' + objectName + '] wasn\'t found!');
		}
		return objectResult.getDescribe();
	}

	/**
	* @description Will return a description of the given field 
	* @param objectResult sObjectResult from which we want to know everything, use getDescribeSObjectResult
	* @param fieldName The field from which we want to get the field result
	* @return Describe SObject Result of the given Field
	*/ 
	global static Schema.DescribeFieldResult getDescribeFieldResult(Schema.DescribeSObjectResult objectResult, String fieldName) {
		Schema.SObjectField fieldResult = objectResult.fields.getMap().get(fieldName);
		if (fieldResult == null) {
			//throw exception
			throw new aqCustomException('Field Name [' + fieldName + '] wasn\'t found!');
		}
		return fieldResult.getDescribe();
	}

	
	/**
	 * @description Returns the RecordTypeId of the given DeveloperName.
	 * @param objectName The Name of a SObject
	 * @param rtDevName DeveloperName of a RecordType
	 * @return Id RecordTypeId
	 */
	global static Id getRecordTypeIdByDevName(String objectName, String rtDevName) {
		if (String.isBlank(objectName) || String.isBlank(rtDevName)) {
			return null;
		}
		Schema.RecordTypeInfo recordTypeInfo = getDescribeSObjectResult(objectName).getRecordTypeInfosByDeveloperName().get(rtDevName);
		if(recordTypeInfo == null){
			//throw exception
			throw new aqCustomException('Record Type DevloperName [' + rtDevName + '] wasn\'t found!');
		}
		return recordTypeInfo.getRecordTypeId();
	}

	/**
	* @description Gets all required fields from the given object and returns them as a map
	* @param objectName the object from which we want to get the required Fields
	* @return Map of Field Name and FieldDescription
	*/ 
	global static Map<String, Schema.DescribeFieldResult> getRequiredFields(String objectName) {
		Map<String, Schema.DescribeFieldResult> requiredFieldMap = new Map<String, Schema.DescribeFieldResult> ();
		Map<String, Schema.SObjectField> fieldMap =getDescribeSObjectResult(objectName).fields.getMap();
		for (String fieldName : fieldMap.KeySet()) {
			Schema.SObjectField fieldSchema = fieldMap.get(fieldName);
			Schema.DescribeFieldResult fieldDescription = fieldSchema.getDescribe();
			if ((!fieldDescription.isNillable()) && (!fieldDescription.isCalculated()) && (!fieldDescription.isAutoNumber()) && (!fieldDescription.isDefaultedOnCreate()) && (fieldDescription.isAccessible()) && (!fieldDescription.isDeprecatedAndHidden()) && (fieldDescription.isUpdateable())) {
				requiredFieldMap.put(fieldName, fieldDescription);
			}
		}
		
		return requiredFieldMap;
	}

	/**
	* @description creates a Random String with a defined length
	* @param length The length the new random String should have
	* @return Random String
	*/ 
    global static String generateRandomString(Integer length) {

        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String randStr = '';
        while (randStr.length() <length) {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), 62);
            randStr += chars.substring(idx, idx + 1);
        }
        return randStr;
    }

	/**
	* @description Will check if the exception you got was the one you expected
	* @param exceptionYouExpected Name of the Exception you expected as a String
	* @param actualException The actual exception you got from running your test code
	* @return TRUE if they are equal / FALSE if they are not
	*/ 
	global static Boolean compareExceptionName(String exceptionYouExpected, Exception actualException) {
		return exceptionYouExpected.equalsIgnoreCase(actualException.getTypeName());
	}

	/**
	* @description Will set all required fields on the given object and write them
	* @param record The record where we want to set the required fields
	* @param requiredFieldMap a map with the field name and the field description (use getRequiredFields for right format)
	*/ 
	global static void setRequiredFields(SObject record, Map<String, Schema.DescribeFieldResult> requiredFieldMap) {
		setRequiredFields(record, requiredFieldMap, 0);
	}
	
	/**
	* @description Will set all required fields on the given object and write them
	* @param record The record where we want to set the required fields
	* @param requiredFieldMap a map with the field name and the field description (use getRequiredFields for right format)
	* @param num current number of the account for example that should be set
	*/ 
	global static void setRequiredFields(SObject record, Map<String, Schema.DescribeFieldResult> requiredFieldMap, Integer num) {
		String objectName = getSObjectName(record);
		for (String fieldName : requiredFieldMap.KeySet()) {
			Schema.DescribeFieldResult fieldDescriebed = requiredFieldMap.get(fieldName);
			Schema.DisplayType fieldDisplayType = fieldDescriebed.getType();
			switch on fieldDisplayType {
				when BASE64 {
					record.put(fieldName, blob.valueOf(String.valueOf(num)));
				}
				when BOOLEAN {
					record.put(fieldName, false);
				}
				when Combobox {
					record.put(fieldName, String.valueOf(num));
				}
				when Currency {
					record.put(fieldName, num);
				}
				when Date {
					record.put(fieldName, Date.today());
				}
				when DateTime {
					record.put(fieldName, DateTime.now());
				}
				when Double {
					record.put(fieldName, num);
				}
				when Email {
					record.put(fieldName, generateRandomString(5) + 'test' + generateRandomString(5) + '@test.com');
				}
				when EncryptedString {
					record.put(fieldName, String.valueOf(num));
				}
				when Integer {
					record.put(fieldName, num);
				}
				when MultiPicklist {
					record.put(fieldName, String.valueOf(num));
				}
				when Percent {
					record.put(fieldName, num);
				}
				when Phone {
					record.put(fieldName, '123');
				}
				when Picklist {
					record.put(fieldName, getPickListValues(objectName, fieldName).size() > 0 ? getPickListValues(objectName, fieldName).get(0) : String.valueOf(num));
				}
				when String {
					Integer fieldLength = fieldDescriebed.getLength() - 2;
					String text;
					if (fieldLength < 30) {
						text = (fieldLength > 4 ? generateRandomString(5) : generateRandomString(1));
					} else {
						text = generateRandomString(15);
						if(fieldName == 'Username'){
							text = generateRandomString(5) + 'test' + generateRandomString(5) + '@test.com';
						}
					}
					record.put(fieldName, text);
				}
				when TextArea {
					record.put(fieldName, String.valueOf(num));
				}
				when Time {
					record.put(fieldName, Time.newInstance(0, 0, 0, 0));
				}
				when URL {
					record.put(fieldName, 'http://test' + String.valueOf(num) + '.com');
				}
				when REFERENCE {
					//references can't be filled on the fly
				}
				when else {
					System.debug('Unhandled field type ' + fieldDisplayType);
				}
			}
		}
	}

}
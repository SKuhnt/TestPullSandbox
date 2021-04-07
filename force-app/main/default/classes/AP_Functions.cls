/**
 @Company : aquilliance GmbH
 @Purpose : Functions for generell Features
  
 ********************************* Modification Log ***********************************
Modified by					Modified on				Ticket No.					Comments
Simon Kuhnt					----------				----------					initial version
Torben Sieber				01-07-2019				AQUINT-98					integrated in the test helper
Simon Kuhnt					07-04-2021				----------					Reworked for Package
*/
public class AP_Functions {
	
	/**
	 * @description Custom Error Class
	*/
	public class aqCustomException extends Exception { 
		public String CONTACT_ADMIN = 'Sorry, something went wrong while executing the commands. Please contact your administrator.';
		public String DEFAULT_MESSAGE = 'Sorry, something went wrong.';
	}

	/**
	* @description generates a String with all Fields concat and a prefix for an ObjectName
	* @param sObjectType Schema.SObjectType of the Object
	* @param prefix prefix for the Object in the Querry
	* @return String with Fields and prefix concatted
	*/
	public static String generateFieldsForQuery(Schema.SObjectType sObjectType, String prefix) {
		String fields = '';
		String prefixString = (prefix == '' ? '' : prefix + '.');
		Boolean next = false;
		for (String field : sObjectType.getDescribe().fields.getMap().keySet()) {
			if (next) {
				fields += ', ' + prefixString + field;
			}
			else {
				next = true;
				fields += prefixString + field;
			}
		}
		return fields;
	}

	/**
	* @description generates a String with all Fields concat for an ObjectName
	* @param sObjectType Schema.SObjectType of the Object
	* @return String with Fields concatted
	*/
	public static String generateFieldsForQuery(Schema.SObjectType sObjectType) {
		return generateFieldsForQuery(sObjectType, '');
	}

	/**
	* @description get all possible picklist values
	* @param sObjectField sObjectField from which the values are taken
	* @return List with all picklist values
	*/ 
	public static List<String> getPickListValues(Schema.SObjectField sObjectField) {
		List<String> pickListValuesList = new List<String> ();
		for (Schema.PicklistEntry picklistEntry : sObjectField.getDescribe().getPicklistValues()) {
			pickListValuesList.add(picklistEntry.getValue());
		}
		return pickListValuesList;
	}
	
	/**
	* @description get all labels from a picklist field
	* @param sObjectField SObjectField from which the labels are taken
	* @return List with all picklist labels
	*/ 
	public static List<String> getPickListLabels(Schema.SObjectField sObjectField) {
		List<String> pickListLabelList = new List<String> ();
		for (Schema.PicklistEntry picklistEntry : sObjectField.getDescribe().getPicklistValues()) {
			pickListLabelList.add(picklistEntry.getLabel());
		}
		return pickListLabelList;
	}

	/**
	* @description get a map from picklist label to picklist value
	* @param sObjectField SObjectField from which the labels and values are taken
	* @return Map with LABEL -> VALUE Pairs
	*/ 
	public static Map<String, String> getPickListLabelValueMap(Schema.SObjectField sObjectField) {
		Map<String, String> picklistLabelValueMap = new Map<String, String> ();
		for (Schema.PicklistEntry picklistEntry : sObjectField.getDescribe().getPicklistValues()) {
			picklistLabelValueMap.put(picklistEntry.getLabel(), picklistEntry.getValue());
		}
		return picklistLabelValueMap;
	}

	/**
	* @description get a map from picklist value to label
	* @param sObjectField SObjectField from which the labels and values are taken
	* @return Map with VALUE -> LABEL Pairs
	*/ 
	public static Map<String, String> getPickListValueLabelMap(Schema.SObjectField sObjectField) {
		Map<String, String> picklistLabelValueMap = new Map<String, String> ();
		for (Schema.PicklistEntry picklistEntry : sObjectField.getDescribe().getPicklistValues()) {
			picklistLabelValueMap.put(picklistEntry.getValue(), picklistEntry.getLabel());
		}
		return picklistLabelValueMap;
	}
	
	/**
	 * @description gets the RecordTypeId for the given DeveloperName.
	 * @param sObjectType of the SObject
	 * @param rtDevName DeveloperName of the RecordType
	 * @return Id RecordTypeId
	 */
	public static Id getRecordTypeIdByDevName(Schema.SObjectType sObjectType, String rtDevName) {
		if (String.isBlank(rtDevName)) {
			return null;
		}
		Schema.RecordTypeInfo recordTypeInfo = sObjectType.getDescribe().getRecordTypeInfosByDeveloperName().get(rtDevName);
		if(recordTypeInfo == null){
			//throw exception
			throw new aqCustomException('Record Type DevloperName [' + rtDevName + '] wasn\'t found!');
		}
		return recordTypeInfo.getRecordTypeId();
	}

	/**
	* @description Gets all required fields from the given object and returns them as a map
	* @param sObjectType the object from which we want to get the required Fields
	* @return Map of Field Name and FieldDescription
	*/ 
	public static Map<String, Schema.DescribeFieldResult> getRequiredFields(Schema.SObjectType sObjectType) {
		Map<String, Schema.DescribeFieldResult> requiredFieldMap = new Map<String, Schema.DescribeFieldResult> ();
		Map<String, Schema.SObjectField> fieldMap = sObjectType.getDescribe().fields.getMap();
		for (String fieldName : fieldMap.KeySet()) {
			Schema.SObjectField sObjectField = fieldMap.get(fieldName);
			Schema.DescribeFieldResult fieldDescription = sObjectField.getDescribe();
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
    public static String generateRandomString(Integer length) {
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
	public static Boolean compareExceptionName(String exceptionYouExpected, Exception actualException) {
		return exceptionYouExpected.equalsIgnoreCase(actualException.getTypeName());
	}
	
	/**
	* @description Will set all required fields on the given object and write them
	* @param record The record where we want to set the required fields
	* @param requiredFieldMap a map with the field name and the field description (use getRequiredFields for right format)
	* @param num current number of the account for example that should be set
	*/ 
	public static void setRequiredFields(SObject record, Map<String, Schema.DescribeFieldResult> requiredFieldMap, Integer num) {
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
					List<String> picklistValues = getPickListValues(fieldDescriebed.getSobjectField());
					record.put(fieldName, picklistValues.size() > 0 ? picklistValues.get(0) : String.valueOf(num));
				}
				when String {
					Integer fieldLength = fieldDescriebed.getLength() - 2;
					String text;
					if (fieldLength < 30) {
						text = (fieldLength >= 5 ? generateRandomString(5) : generateRandomString(1));
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
	
	/**
	* @description Will set all required fields on the given object and write them
	* @param record The record where we want to set the required fields
	* @param requiredFieldMap a map with the field name and the field description (use getRequiredFields for right format)
	*/ 
	public static void setRequiredFields(SObject record, Map<String, Schema.DescribeFieldResult> requiredFieldMap) {
		setRequiredFields(record, requiredFieldMap, 0);
	}
}
/**
 @Company : aquilliance GmbH
 @Purpose : Functions Class Tests
  
 ********************************* Modification Log ***********************************
Modified by					Modified on				Ticket No.					Comments
Torben Sieber				09-01-2019				AQUINT-98					Init 
Simon Kuhnt					07-04-2021				----------					Reworked for Package
*/
@isTest 
private class AP_FunctionsTest {

	/**
	* @description tests the getPicklist Functions
	*/ 
	@isTest
	private static void getPicklistTests() {
		// Get a Map from VALUE -> Label, and check if the Picklist Values are as expected 
		System.assert(AP_Functions.getPickListValueLabelMap(Account.Rating).size() > 0, 'Picklist Value should at least exist');
		// Get a Map from LABEL -> VALUE, and check if the Picklist Labels are as expected
		System.assert(AP_Functions.getPickListLabelValueMap(Account.Rating).size() > 0, 'Picklist Label should at least exist');
		// Get a List of LABELS and check if the Picklist Labels are as expected
		System.assert(AP_Functions.getPickListLabels(Account.Rating).size() > 0, 'Picklist Label List should at least exist');
		// Get a List of VALUES and check if the Picklist values are as expected
		System.assert(AP_Functions.getPickListValues(Account.Rating).size() > 0, 'Picklist Label List should at least exist');
	}
	
	/**
	* @description tests the query Fields Function
	*/ 
	@isTest
	private static void generateFieldsTest() {
		System.assert(AP_Functions.generateFieldsForQuery(Lead.getSObjectType()).containsIgnoreCase('id,'), 'the "id," should be included.');
		System.assert(AP_Functions.generateFieldsForQuery(Lead.getSObjectType(), 'aq').containsIgnoreCase('aq.id,'), 'the "aq.id," should be included.');
	}

	/**
	* @description tests whether at least the Name field of the Account is found as required.
	*/ 
	@isTest
	private static void getRequiredFieldsTest(){
		Map<String, Schema.DescribeFieldResult> requiredFieldMap = AP_Functions.getRequiredFields(Account.getSObjectType());
		System.assert(requiredFieldMap.containsKey('name'), 'The Name Field should be a required Field on Account.');
	}

	/**
	* @description tests whether all the required fields get filled.
	*/ 
	@isTest
	private static void setRequiredFieldsTest(){
		Map<String, Schema.DescribeFieldResult> requiredFieldMap = new Map<String, Schema.DescribeFieldResult>();
		Account acc = new Account();
		Map<String, Schema.SObjectField> fieldMap = Account.getSObjectType().getDescribe().fields.getMap();
		//String
		requiredFieldMap.put('Name', fieldMap.get('Name').getDescribe());
		//Picklist
		requiredFieldMap.put('Industry', fieldMap.get('Industry').getDescribe());
		//Integer
		requiredFieldMap.put('NumberOfEmployees', fieldMap.get('NumberOfEmployees').getDescribe());
		//TextArea
		requiredFieldMap.put('Description', fieldMap.get('Description').getDescribe());
		//URL Website
		requiredFieldMap.put('Website', fieldMap.get('Website').getDescribe());
		//Phone Phone
		requiredFieldMap.put('Phone', fieldMap.get('Phone').getDescribe());
		//Fax (Phone) Fax
		requiredFieldMap.put('Fax', fieldMap.get('Fax').getDescribe());
		//Currency AnnualRevenue
		requiredFieldMap.put('AnnualRevenue', fieldMap.get('AnnualRevenue').getDescribe());
		//Content (String) TickerSymbol 
		requiredFieldMap.put('TickerSymbol', fieldMap.get('TickerSymbol').getDescribe());
		AP_Functions.setRequiredFields(acc, requiredFieldMap);
		System.assertNotEquals(null, acc.Name, 'Account.Name was expected to have a value');
		System.assertNotEquals(null, acc.Industry, 'Account.Industry was expected to have a value');
		System.assertNotEquals(null, acc.NumberOfEmployees, 'Account.NumberOfEmployees was expected to have a value');
		System.assertNotEquals(null, acc.Description, 'Account.Description was expected to have a value');
		System.assertNotEquals(null, acc.Website, 'Account.Website was expected to have a value');
		System.assertNotEquals(null, acc.Phone, 'Account.Phone was expected to have a value');
		System.assertNotEquals(null, acc.Fax, 'Account.Fax was expected to have a value');
		System.assertNotEquals(null, acc.AnnualRevenue, 'Account.AnnualRevenue was expected to have a value');
		System.assertNotEquals(null, acc.TickerSymbol, 'Account.TickerSymbol was expected to have a value');
		
		Contact con = new Contact();
		fieldMap = Contact.getSObjectType().getDescribe().fields.getMap();
		requiredFieldMap.clear();
		//Reference AccountId
		requiredFieldMap.put('AccountId', fieldMap.get('AccountId').getDescribe());
		//Date Birthdate
		requiredFieldMap.put('Birthdate', fieldMap.get('Birthdate').getDescribe());
		//Checkbox (Boolean) HasOptedOutOfEmail
		requiredFieldMap.put('HasOptedOutOfEmail', fieldMap.get('HasOptedOutOfEmail').getDescribe());
		//Email Email
		requiredFieldMap.put('Email', fieldMap.get('Email').getDescribe());
		AP_Functions.setRequiredFields(con, requiredFieldMap);
		System.assertEquals(null, con.AccountId, 'Contact.AccountId was NOT expected to have a value since it is a Reference');
		System.assertNotEquals(null, con.Birthdate, 'Contact.Birthdate was expected to have a value');
		System.assertNotEquals(null, con.HasOptedOutOfEmail, 'Contact.HasOptedOutOfEmail was expected to have a value');
		System.assertNotEquals(null, con.Email, 'Contact.Email was expected to have a value');

		OpportunityLineItem oli = new OpportunityLineItem();
		fieldMap = OpportunityLineItem.getSObjectType().getDescribe().fields.getMap();
		requiredFieldMap.clear();
		//Double Quantity
		requiredFieldMap.put('Quantity', fieldMap.get('Quantity').getDescribe());
		//Percent Discount
		requiredFieldMap.put('Discount', fieldMap.get('Discount').getDescribe());
		AP_Functions.setRequiredFields(oli, requiredFieldMap);
		System.assertNotEquals(null, oli.Quantity, 'OpportunityLineItem.Quantity was expected to have a value');
		System.assertNotEquals(null, oli.Discount, 'OpportunityLineItem.Discount was expected to have a value');
	}

	
	/**
	* @description tests the Record Type by DevName Function
	*/ 
	@isTest
	private static void recordTypeIdByDevNameTests() {
		System.assertEquals(null, AP_Functions.getRecordTypeIdByDevName(null, null), 'expected the recordTypeId null');

		Boolean errorThrown = false;
		try {
			AP_Functions.getRecordTypeIdByDevName(Account.getSObjectType(), '_NOT_AN_ACTUALL_RT_DEV_NAME!!__312');
		} catch (AP_Functions.aqCustomException ae) {
			errorThrown = true;
		}
		System.assert(errorThrown, 'Looked for a RecordType that should not exist');
	}
}
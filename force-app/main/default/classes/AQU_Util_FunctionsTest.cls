/*
 @Company : aquilliance GmbH
 @Purpose : Test the AQU_Util_Functions.
  
 ********************************* Modification Log ***********************************
Modified by					Modified on				Ticket No.					Comments
Torben Sieber				09/01/2019				AQUINT-98					Init 
Simon Kuhnt					30-07-2019				---------					Reworked for Package use
Simon Kuhnt					06-04-2021				----------					Added to a new all in 1 Package
*/
@isTest 
private class AQU_Util_FunctionsTest {

	/**
	* @description Will test if the Function to get the SObject-Name of IDs/Objects
	*/ 
	@isTest
	private static void test_getSObjectName() {
		// Call with the Schema
		System.assertEquals('Account', AQU_Util_Functions.getSObjectName(Account.getSObjectType()));
		Account testAccount = genAccount(false);
		// Call with the complete SObject
		System.assertEquals('Account', AQU_Util_Functions.getSObjectName(testAccount));
        insert testAccount;
		// Call with the Id of the SObject
		System.assertEquals('Account', AQU_Util_Functions.getSObjectName(testAccount.Id));
	}


	/**
	* @description Will test if the getPicklist Values functions work
	*/ 
	@isTest
	private static void test_getPicklist() {
		// Get a Map from VALUE -> Label, and check if the Picklist Values are as expected 
		System.assert(AQU_Util_Functions.getPickListValueLabelMap('Account', 'Rating').size() > 0, 'Picklist Value should at least exist');
		// Get a Map from LABEL -> VALUE, and check if the Picklist Labels are as expected
		System.assert(AQU_Util_Functions.getPickListLabelValueMap('Account', 'Rating').size() > 0, 'Picklist Label should at least exist');
		// Get a List of LABELS and check if the Picklist Labels are as expected
		System.assert(AQU_Util_Functions.getPickListLabels('Account', 'Rating').size() > 0, 'Picklist Label List should at least exist');
	}
	
	/**
	* @description Will test if the function to generate a query with all fields works
	*/ 
	@isTest
	private static void test_generateFields() {
		System.assert(AQU_Util_Functions.generateFieldsForQuery('Lead').containsIgnoreCase('id,'), 'the "id," should be included.');
		System.assert(AQU_Util_Functions.generateFieldsForQuery('Lead', 'aq').containsIgnoreCase('aq.id,'), 'the "aq.id," should be included.');

		Boolean excepted = false;
		try {
			// Make a call with an invalid sObject, to trigger an exception
			AQU_Util_Functions.generateFieldsForQuery('_');
		} catch (AQU_Util_Functions.aqCustomException ae) {
			// If the aqCustomException got called as expected, set the boolean flag true.
			excepted = true;
		}
		
		// If the exception wasnt thrown or an other exception, the test has failed.
		System.assertEquals(true, excepted, 'Looked for an SObject that should not exist');	
	}

	/**
	* @description tests whether at least the Name field of the Account is found as required.
	*/ 
	@isTest
	private static void testGetRequiredFields(){
		Map<String, Schema.DescribeFieldResult> requiredFieldMap = AQU_Util_Functions.getRequiredFields('Account');
		System.debug(requiredFieldMap);
		System.assert(requiredFieldMap.containsKey('name'), 'The Name Field should be required on Account.');
	}

	@isTest
	private static void testSetRequiredFields(){
		Map<String, Schema.DescribeFieldResult> requiredFieldMap = new Map<String, Schema.DescribeFieldResult>();
		Account acc = new Account();
		Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get('Account').getDescribe().fields.getMap();
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
		AQU_Util_Functions.setRequiredFields(acc, requiredFieldMap);
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
		fieldMap = Schema.getGlobalDescribe().get('Contact').getDescribe().fields.getMap();
		requiredFieldMap.clear();
		//Reference AccountId
		requiredFieldMap.put('AccountId', fieldMap.get('AccountId').getDescribe());
		//Date Birthdate
		requiredFieldMap.put('Birthdate', fieldMap.get('Birthdate').getDescribe());
		//Checkbox (Boolean) HasOptedOutOfEmail
		requiredFieldMap.put('HasOptedOutOfEmail', fieldMap.get('HasOptedOutOfEmail').getDescribe());
		//Email Email
		requiredFieldMap.put('Email', fieldMap.get('Email').getDescribe());
		AQU_Util_Functions.setRequiredFields(con, requiredFieldMap);
		System.assertEquals(null, con.AccountId, 'Contact.AccountId was NOT expected to have a value since it is a Reference');
		System.assertNotEquals(null, con.Birthdate, 'Contact.Birthdate was expected to have a value');
		System.assertNotEquals(null, con.HasOptedOutOfEmail, 'Contact.HasOptedOutOfEmail was expected to have a value');
		System.assertNotEquals(null, con.Email, 'Contact.Email was expected to have a value');

		OpportunityLineItem oli = new OpportunityLineItem();
		fieldMap = Schema.getGlobalDescribe().get('OpportunityLineItem').getDescribe().fields.getMap();
		requiredFieldMap.clear();
		//Double Quantity
		requiredFieldMap.put('Quantity', fieldMap.get('Quantity').getDescribe());
		//Percent Discount
		requiredFieldMap.put('Discount', fieldMap.get('Discount').getDescribe());
		AQU_Util_Functions.setRequiredFields(oli, requiredFieldMap);
		System.assertNotEquals(null, oli.Quantity, 'OpportunityLineItem.Quantity was expected to have a value');
		System.assertNotEquals(null, oli.Discount, 'OpportunityLineItem.Discount was expected to have a value');
	}

	
	/**
	* @description Various other tests. Everything that doesn't deserve its own test gets in here!
	*/ 
	@isTest
	private static void test_various() {
		Boolean excepted = false;

		try {
			// Call DescribeFieldResult with an invalid field name to provoke an exception
			AQU_Util_Functions.getDescribeFieldResult(AQU_Util_Functions.getDescribeSObjectResult('Account'), '_');
		} catch (AQU_Util_Functions.aqCustomException ae) {
			// If the aqCustomException got called = excepted is true and the exception was thrown as expected
			excepted = true;
		}
	
		// Exception should have been thrown, if not or an other -> Error.  
		System.assertEquals(true, excepted, 'Looked for a FieldName that should not exist');
		System.assertEquals(null, AQU_Util_Functions.getRecordTypeIdByDevName('', null), 'expected the recordTypeId null');
		try {
			excepted = false;
			AQU_Util_Functions.getRecordTypeIdByDevName('Account', '_');
		} catch (AQU_Util_Functions.aqCustomException ae) {
			excepted = true;
		}
	
		System.assertEquals(true, excepted, 'Looked for a RecordType that should not exist');
	}

    private static Account genAccount(Boolean isInsert){
        Account acc = new Account();
        try {
            acc.Name = 'xasd75674qwsa Test acc Aquilliance Test fsf651aew12sd'; 
            if(isInsert){
                insert acc;
            }
        } catch (Exception ex) {
            System.debug(ex);
        } finally {
            return acc; 
        }
        return acc;
    }
}
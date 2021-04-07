/**
 @Company : aquilliance GmbH
 @Purpose : SchemaUtil Class Tests
  
 ********************************* Modification Log ***********************************
Modified by					Modified on				Ticket No.					Comments
Simon Kuhnt					07-04-2021				----------					initial version
*/
@isTest 
private class AP_SchemaUtilTest {

    /**
	* @description Tests the Function to get the SObject-Name of IDs/Objects
	*/ 
	@isTest
	private static void getSObjectNameTests() {
		// Call with the Schema
		System.assertEquals('Account', AP_SchemaUtil.getSObjectName(Account.getSObjectType()), 'Expected the same Object Name');
		Account testAccount = genAccount(false);
		// Call with the complete SObject
		System.assertEquals('Account', AP_SchemaUtil.getSObjectName(testAccount), 'Expected the same Object Name');
        insert testAccount;
		// Call with the Id of the SObject
		System.assertEquals('Account', AP_SchemaUtil.getSObjectName(testAccount.Id), 'Expected the same Object Name');
	}

    /**
	* @description Tests the Function to get the FieldName of an sObjectField
	*/ 
	@isTest
	private static void getFieldNameTest() {
		System.assertEquals('Name', AP_SchemaUtil.getFieldName(Account.Name), 'Expected the same Field Name');
	}

    /**
	* @description Tests the Function to get SObject Type From the Object Name
	*/ 
	@isTest
	private static void getSObjectTypeTest() {
		System.assertEquals(Account.getSObjectType(), AP_SchemaUtil.getSObjectType('Account'), 'Expected the same SObject Type');

        Boolean errorThrown = false;
		try {
			AP_SchemaUtil.getSObjectType('__NOT_AN_EXISTING_OBJECT_NAME__23124123');
		} catch (AP_Functions.aqCustomException ae) {
			errorThrown = true;
		}
		System.assert(errorThrown, 'Expected an Error to be thrown since the Object doesnt exist');
	}

    /**
	* @description Tests the Function to get SObject Field From the Object and Field Name
	*/ 
	@isTest
	private static void getSObjectFieldTests() {
		System.assertEquals(Account.Name, AP_SchemaUtil.getSObjectField('Account', 'Name'), 'Expected the same SObject Field');
		System.assertEquals(Account.Name, AP_SchemaUtil.getSObjectField(Account.getSObjectType(), 'Name'), 'Expected the same SObject Field');

        Boolean errorThrown = false;
		try {
			AP_SchemaUtil.getSObjectField(Account.getSObjectType(), '__NOT_AN_EXISTING_FIELD_NAME__23124123');
		} catch (AP_Functions.aqCustomException ae) {
			errorThrown = true;
		}
		System.assert(errorThrown, 'Expected an Error to be thrown since the Field doesnt exist');
	}    

    private static Account genAccount(Boolean isInsert){
        return (Account) AP_TestFactory.getRecords(Account.getSObjectType(), isInsert)[0];
    }
}
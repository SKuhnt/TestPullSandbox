/*
  @Company : aquilliance GmbH
  @Purpose : Test Factory Test the creation of Test Data 
 
 ***************************************** Modification Log *****************************************
  Modified By					Modified on					Ticket No.					Comments
  Simon Kuhnt					02-08-2019					----------					inital version
  Simon Kuhnt					06-04-2021					----------					Added to a new all in 1 Package
*/ 
@isTest 
public class AQU_Util_TestFactoryTest {

    @isTest
	private static void testSetRequiredFields(){
		List<Account> accs = AQU_Util_TestFactory.getSObject('Account', false);
		System.assertNotEquals(null, accs[0].Name, 'Account.Name was expected to have a value');

		accs = AQU_Util_TestFactory.getSObject('Account', true, 2);
		System.assertEquals(2, accs.size(), 'Two Acounts should have been created');
		System.assertNotEquals(null, accs[0].Name, 'Account.Name was expected to have a value');

		List<Contact> cons = AQU_Util_TestFactory.getSObject('Contact', false, accs, 'AccountId');
		System.assertEquals(2, cons.size(), 'Two Contacts should have been created');
		System.assertNotEquals(null, cons[0].LastName, 'Contact.LastName was expected to have a value');

		cons = AQU_Util_TestFactory.getSObject('Contact', false, new Map<Id,Account>(accs).keySet(), 'AccountId');
		System.assertEquals(2, cons.size(), 'Two Contacts should have been created');
		System.assertNotEquals(null, cons[0].LastName, 'Contact.LastName was expected to have a value');

		cons = AQU_Util_TestFactory.getSObject('Contact', false, new List<Id>(new Map<Id,Account>(accs).keySet()), 'AccountId');
		System.assertEquals(2, cons.size(), 'Two Contacts should have been created');
		System.assertNotEquals(null, cons[0].LastName, 'Contact.LastName was expected to have a value');
		
		cons = AQU_Util_TestFactory.getSObject('Contact', false, 2, accs, 'AccountId');
		System.assertEquals(4, cons.size(), 'Two Contacts should have been created');
		System.assertNotEquals(null, cons[0].LastName, 'Contact.LastName was expected to have a value');

		cons = AQU_Util_TestFactory.getSObject('Contact', false, 2, new Map<Id,Account>(accs).keySet(), 'AccountId');
		System.assertEquals(4, cons.size(), 'Two Contacts should have been created');
		System.assertNotEquals(null, cons[0].LastName, 'Contact.LastName was expected to have a value');

		cons = AQU_Util_TestFactory.getSObject('Contact', false, 2, new List<Id>(new Map<Id,Account>(accs).keySet()), 'AccountId');
		System.assertEquals(4, cons.size(), 'Two Contacts should have been created');
		System.assertNotEquals(null, cons[0].LastName, 'Contact.LastName was expected to have a value');
	}

	@isTest
	private static void testSetRequiredFieldsRecordType(){
		//Record Types might not be active in the org so it will not be tested right.
		List<Account> accs = AQU_Util_TestFactory.getSObject('Account', false, '');
		System.assertNotEquals(null, accs[0].Name, 'Account.Name was expected to have a value');

		accs = AQU_Util_TestFactory.getSObject('Account', true, '', 2);
		System.assertEquals(2, accs.size(), 'Two Acounts should have been created');
		System.assertNotEquals(null, accs[0].Name, 'Account.Name was expected to have a value');

		List<Contact> cons = AQU_Util_TestFactory.getSObject('Contact', false, '', accs, 'AccountId');
		System.assertEquals(2, cons.size(), 'Two Contacts should have been created');
		System.assertNotEquals(null, cons[0].LastName, 'Contact.LastName was expected to have a value');

		cons = AQU_Util_TestFactory.getSObject('Contact', false, '', new Map<Id,Account>(accs).keySet(), 'AccountId');
		System.assertEquals(2, cons.size(), 'Two Contacts should have been created');
		System.assertNotEquals(null, cons[0].LastName, 'Contact.LastName was expected to have a value');

		cons = AQU_Util_TestFactory.getSObject('Contact', false, '', new List<Id>(new Map<Id,Account>(accs).keySet()), 'AccountId');
		System.assertEquals(2, cons.size(), 'Two Contacts should have been created');
		System.assertNotEquals(null, cons[0].LastName, 'Contact.LastName was expected to have a value');
	}

	@isTest
	private static void testFillSObject(){
		List<Account> accs = AQU_Util_TestFactory.getSObject('Account', true, '');
		List<Contact> cons = AQU_Util_TestFactory.getSObject('Contact', false, '');
		AQU_Util_TestFactory.fillSObjects(cons, accs, 'AccountId');
		System.assertEquals(accs[0].Id, cons[0].AccountId, 'Contact should now be related to the Account!');

		accs = AQU_Util_TestFactory.getSObject('Account', true, '', 2);
		cons = AQU_Util_TestFactory.getSObject('Contact', false, '', 4);
		AQU_Util_TestFactory.fillSObjects(cons, accs, 'AccountId');
		System.assertEquals(accs[0].Id, cons[0].AccountId, 'Contact should now be related to the Account!');
		System.assertEquals(accs[1].Id, cons[1].AccountId, 'Contact should now be related to the Account!');
		System.assertEquals(accs[0].Id, cons[2].AccountId, 'Contact should now be related to the Account!');
		System.assertEquals(accs[1].Id, cons[3].AccountId, 'Contact should now be related to the Account!');
		
		accs = AQU_Util_TestFactory.getSObject('Account', true, '', 4);
		cons = AQU_Util_TestFactory.getSObject('Contact', false, '', 2);
		AQU_Util_TestFactory.fillSObjects(cons, accs, 'AccountId');
		System.assertEquals(accs[0].Id, cons[0].AccountId, 'Contact should now be related to the Account!');
		System.assertEquals(accs[1].Id, cons[1].AccountId, 'Contact should now be related to the Account!');

		accs = AQU_Util_TestFactory.getSObject('Account', true, '');
		cons = AQU_Util_TestFactory.getSObject('Contact', false, '');
		AQU_Util_TestFactory.fillSObjects(cons, new Set<Id>{accs[0].Id}, 'AccountId');
		System.assertEquals(accs[0].Id, cons[0].AccountId, 'Contact should now be related to the Account!');

		accs = AQU_Util_TestFactory.getSObject('Account', true, '');
		cons = AQU_Util_TestFactory.getSObject('Contact', false, '');
		AQU_Util_TestFactory.fillSObjects(cons, new List<Id>{accs[0].Id}, 'AccountId');
		System.assertEquals(accs[0].Id, cons[0].AccountId, 'Contact should now be related to the Account!');
	}

	@isTest
	private static void testFixedValue(){
		List<Account> accs = new List<Account>();
		Account acc = new Account();
		accs.add(acc);
		AQU_Util_TestFactory.addFixedValue(accs, Account.BillingCity, 'Hamburg');
		System.assertEquals('Hamburg', acc.BillingCity);
	}
}
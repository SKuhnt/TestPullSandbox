/*
  @Company : aquilliance GmbH
  @Purpose : Test Factory Test the creation of Test Data 
 
 ***************************************** Modification Log *****************************************
  Modified By					Modified on					Ticket No.					Comments
  Simon Kuhnt					02-08-2019					----------					inital version
  Simon Kuhnt					07-04-2021					----------					Reworked for Package
*/ 
@isTest
public class AP_TestFactoryTest {

	/**
	* @description Checks whether the getRecords Function creates Records as expected.
	*/ 
    @isTest
	private static void getRecordsTest(){
		List<Account> accs = AP_TestFactory.getRecords(Account.getSObjectType(), false);
		System.assertNotEquals(null, accs[0].Name, 'Account.Name was expected to have a value');

		accs = AP_TestFactory.getRecords(Account.getSObjectType(), true, 2);
		System.assertEquals(2, accs.size(), 'Two Acounts should have been created');
		System.assertNotEquals(null, accs[0].Name, 'Account.Name was expected to have a value');

		List<Contact> cons = AP_TestFactory.getRecords(Contact.getSObjectType(), false, accs, Contact.AccountId);
		test2Contacts(cons, accs);

		cons = AP_TestFactory.getRecords(Contact.getSObjectType(), false, new Map<Id,Account>(accs).keySet(), Contact.AccountId);
		test2Contacts(cons, accs);

		cons = AP_TestFactory.getRecords(Contact.getSObjectType(), false, new List<Id>(new Map<Id,Account>(accs).keySet()), Contact.AccountId);
		test2Contacts(cons, accs);
		
		cons = AP_TestFactory.getRecords(Contact.getSObjectType(), false, 2, accs, Contact.AccountId);
		test4Contacts(cons, accs);

		cons = AP_TestFactory.getRecords(Contact.getSObjectType(), false, 2, new Map<Id,Account>(accs).keySet(), Contact.AccountId);
		test4Contacts(cons, accs);

		cons = AP_TestFactory.getRecords(Contact.getSObjectType(), false, 2, new List<Id>(new Map<Id,Account>(accs).keySet()), Contact.AccountId);
		test4Contacts(cons, accs);

		//Record Types might not be active in the org so it will not be tested right.
		accs = AP_TestFactory.getRecords(Account.getSObjectType(), false, '');
		System.assertNotEquals(null, accs[0].Name, 'Account.Name was expected to have a value');

		accs = AP_TestFactory.getRecords(Account.getSObjectType(), true, '', 2);
		System.assertEquals(2, accs.size(), 'Two Acounts should have been created');
		System.assertNotEquals(null, accs[0].Name, 'Account.Name was expected to have a value');

		cons = AP_TestFactory.getRecords(Contact.getSObjectType(), false, '', accs, Contact.AccountId);
		test2Contacts(cons, accs);

		cons = AP_TestFactory.getRecords(Contact.getSObjectType(), false, '', new Map<Id,Account>(accs).keySet(), Contact.AccountId);
		test2Contacts(cons, accs);

		cons = AP_TestFactory.getRecords(Contact.getSObjectType(), false, '', new List<Id>(new Map<Id,Account>(accs).keySet()), Contact.AccountId);
		test2Contacts(cons, accs);
	}

	/**
	* @description Checks whether the fillSObjects Function fills Relationships as expected.
	*/ 
	@isTest
	private static void fillSObjectTest(){
		List<Account> accs = AP_TestFactory.getRecords(Account.getSObjectType(), true, '');
		List<Contact> cons = AP_TestFactory.getRecords(Contact.getSObjectType(), false, '');
		AP_TestFactory.fillSObjects(cons, accs, Contact.AccountId);
		System.assertEquals(accs[0].Id, cons[0].AccountId, 'Contact should now be related to the Account!');

		accs = AP_TestFactory.getRecords(Account.getSObjectType(), true, '', 2);
		cons = AP_TestFactory.getRecords(Contact.getSObjectType(), false, '', 4);
		AP_TestFactory.fillSObjects(cons, accs, Contact.AccountId);
		test4Contacts(cons, accs);
		
		accs = AP_TestFactory.getRecords(Account.getSObjectType(), true, '', 4);
		cons = AP_TestFactory.getRecords(Contact.getSObjectType(), false, '', 2);
		AP_TestFactory.fillSObjects(cons, accs, Contact.AccountId);
		test2Contacts(cons, accs);

		accs = AP_TestFactory.getRecords(Account.getSObjectType(), true, '');
		cons = AP_TestFactory.getRecords(Contact.getSObjectType(), false, '');
		AP_TestFactory.fillSObjects(cons, new Set<Id>{accs[0].Id}, Contact.AccountId);
		System.assertEquals(accs[0].Id, cons[0].AccountId, 'Contact should now be related to the Account!');

		accs = AP_TestFactory.getRecords(Account.getSObjectType(), true, '');
		cons = AP_TestFactory.getRecords(Contact.getSObjectType(), false, '');
		AP_TestFactory.fillSObjects(cons, new List<Id>{accs[0].Id}, Contact.AccountId);
		System.assertEquals(accs[0].Id, cons[0].AccountId, 'Contact should now be related to the Account!');
	}

	/**
	* @description Checks whether the addFixedValue Function adds a fixed value as expected.
	*/ 
	@isTest
	private static void fixedValueTest(){
		List<Account> accs = new List<Account>();
		Account acc = new Account();
		accs.add(acc);
		AP_TestFactory.addFixedValue(accs, Account.BillingCity, 'Hamburg');
		System.assertEquals('Hamburg', acc.BillingCity);
	}

	/**
	* @description Asserts 2 Contacts with 2 Accounts
	*/ 
	private static void test2Contacts(List<Contact> cons, List<Account> accs){
		System.assertEquals(2, cons.size(), 'Two Contacts should have been created');
		System.assertNotEquals(null, cons[0].LastName, 'Contact.LastName was expected to have a value');
		System.assertEquals(accs[0].Id, cons[0].AccountId, 'Contact should now be related to the Account!');
		System.assertEquals(accs[1].Id, cons[1].AccountId, 'Contact should now be related to the Account!');
	}

	/**
	* @description Asserts 4 Contacts with 2 Accounts
	*/ 
	private static void test4Contacts(List<Contact> cons, List<Account> accs){
		System.assertEquals(4, cons.size(), 'Two Contacts should have been created');
		System.assertNotEquals(null, cons[0].LastName, 'Contact.LastName was expected to have a value');
		System.assertEquals(accs[0].Id, cons[0].AccountId, 'Contact should now be related to the Account!');
		System.assertEquals(accs[1].Id, cons[1].AccountId, 'Contact should now be related to the Account!');
		System.assertEquals(accs[0].Id, cons[2].AccountId, 'Contact should now be related to the Account!');
		System.assertEquals(accs[1].Id, cons[3].AccountId, 'Contact should now be related to the Account!');
	}
}
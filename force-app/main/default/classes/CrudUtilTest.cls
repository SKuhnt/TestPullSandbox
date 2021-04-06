/*
  @Company : aquilliance GmbH
  @Purpose : Utility Class Tests
 
 ***************************************** Modification Log *****************************************
  Modified By					Modified on					Ticket No.					Comments
  Simon Kuhnt					30-07-2019					--------					inital version
*/ 
@isTest 
public with sharing class CrudUtilTest {

	@isTest
	private static void insertPositive() {
		Account acc = new Account(Name = 'Test-j324kl235j');
		Boolean insertSucessfully = CrudUtil.insertRecords(new List<Account>{acc});
		System.assertEquals(true, insertSucessfully, 'please check why the Account was not inserted succesfully');
	}

	@isTest
	private static void insertNegative() {
		Account acc = new Account();
		Boolean insertSucessfully = CrudUtil.insertRecords(new List<Account>{acc}, false);
		System.assertEquals(false, insertSucessfully, 'please check why the Account was not inserted succesfully');
	}
	
	@isTest
	private static void updatePositive() {
		Account acc = new Account(Name = 'Test-j324kl235j');
		Boolean insertSucessfully = CrudUtil.insertRecords(new List<Account>{acc});
		acc.Name = 'Test-j324kl235jv2';
		Boolean updateSucessfully = CrudUtil.updateRecords(new List<Account>{acc});
		System.assertEquals(true, updateSucessfully, 'please check why the Account was not inserted succesfully');
	}

	@isTest
	private static void updateNegative() {
		Account acc = new Account(Name = 'Test-j324kl235j');
		Boolean insertSucessfully = CrudUtil.insertRecords(new List<Account>{acc});
		acc.Name = '';
		Boolean updateSucessfully = CrudUtil.updateRecords(new List<Account>{acc}, false);
		System.assertEquals(false, updateSucessfully, 'please check why the Account was not inserted succesfully');
	}

		
	@isTest
	private static void upsertPositive() {
		Account acc = new Account(Name = 'Test-j324kl235j');
		Boolean insertSucessfully = CrudUtil.upsertRecords(new List<Account>{acc});
		acc.Name = 'Test-j324kl235jv2';
		Boolean updateSucessfully = CrudUtil.upsertRecords(new List<Account>{acc});
		System.assertEquals(true, updateSucessfully, 'please check why the Account was not inserted succesfully');
	}

	@isTest
	private static void upsertNegative() {
		Account acc = new Account(Name = 'Test-j324kl235j');
		Boolean insertSucessfully = CrudUtil.upsertRecords(new List<Account>{acc});
		acc.Name = '';
		Boolean updateSucessfully = CrudUtil.upsertRecords(new List<Account>{acc}, false);
		System.assertEquals(false, updateSucessfully, 'please check why the Account was not inserted succesfully');
	}

			
	@isTest
	private static void deletePositive() {
		Account acc = new Account(Name = 'Test-j324kl235j');
		Boolean insertSucessfully = CrudUtil.upsertRecords(new List<Account>{acc});
		Boolean updateSucessfully = CrudUtil.deleteRecords(new List<Account>{acc});
		System.assertEquals(true, updateSucessfully, 'please check why the Account was not inserted succesfully');
	}
	
	@isTest
	private static void deleteNegative() {
		Account acc = new Account(Name = 'Test-j324kl235j');
		Boolean insertSucessfully = CrudUtil.insertRecords(new List<Account>{acc});
		acc.Id = null;
		Boolean updateSucessfully = CrudUtil.deleteRecords(new List<Account>{acc}, false);
		System.assertEquals(false, updateSucessfully, 'please check why the Account was not inserted succesfully');
	}
    
}
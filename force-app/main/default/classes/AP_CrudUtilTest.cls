/**
  @Company : aquilliance GmbH
  @Purpose : CrudUtil Class Tests
 
 ***************************************** Modification Log *****************************************
  Modified By					Modified on					Ticket No.					Comments
  Simon Kuhnt					30-07-2019					----------					inital version
  Simon Kuhnt					07-04-2021					----------					Reworked for Package
*/ 
@isTest 
private class AP_CrudUtilTest {

	/**
	* @description tests whether an insert with a valid Record returns true.
	*/ 
	@isTest
	private static void insertPositive() {
		List<Account> newRecords = AP_TestFactory.getRecords(Account.getSObjectType(), false);
		Boolean insertSucessfully = AP_CrudUtil.insertRecords(newRecords);
		System.assert(insertSucessfully, 'Expected the Accounts to be inserted sucessfully');
	}

	/**
	* @description tests whether an insert with a invalid Record returns false.
	*/ 
	@isTest
	private static void insertNegative1() {
		Account acc = new Account();
		Boolean insertSucessfully = AP_CrudUtil.insertRecords(new List<Account>{acc}, false);
		System.assert(!insertSucessfully, 'Expected a catched Exception and false returned.');
	}

	/**
	* @description tests whether an insert with a invalid Record throws an Exception.
	*/
	@isTest
	private static void insertNegative2() {
		Boolean errorThrown = false;
		try {
			Account acc = new Account();
			AP_CrudUtil.insertRecords(new List<Account>{acc}, true);
		} catch (Exception ex) {
			errorThrown = true;
		} finally {
			System.assert(errorThrown, 'Expected an Exception to be Thorwn');
		}
	}
	
	/**
	* @description tests whether an update with a valid Record returns true.
	*/ 
	@isTest
	private static void updatePositive() {
		List<Account> newRecords = AP_TestFactory.getRecords(Account.getSObjectType(), true);
		Boolean updateSucessfully = AP_CrudUtil.updateRecords(newRecords);
		System.assert(updateSucessfully, 'Expected the Accounts to be updated sucessfully');
	}

	/**
	* @description tests whether an update with a invalid Record returns false.
	*/ 
	@isTest
	private static void updateNegative1() {
		List<Account> newRecords = AP_TestFactory.getRecords(Account.getSObjectType(), true);
		newRecords[0].Name = '';
		Boolean updateSucessfully = AP_CrudUtil.updateRecords(newRecords, false);
		System.assert(!updateSucessfully, 'Expected a catched Exception and false returned.');
	}
	
	/**
	* @description tests whether an update with a invalid Record throws an Exception.
	*/
	@isTest
	private static void updateNegative2() {
		List<Account> newRecords = AP_TestFactory.getRecords(Account.getSObjectType(), true);
		Boolean errorThrown = false;
		try {
			newRecords[0].Name = '';
			AP_CrudUtil.updateRecords(newRecords, true);
		} catch (Exception ex) {
			errorThrown = true;
		} finally {
			System.assert(errorThrown, 'Expected an Exception to be Thorwn');
		}
	}

	/**
	* @description tests whether an upsert with a valid Record returns true.
	*/ 
	@isTest
	private static void upsertPositive() {
		List<Account> newRecords = AP_TestFactory.getRecords(Account.getSObjectType(), false);
		Boolean upsertSucessfully = AP_CrudUtil.upsertRecords(newRecords);
		System.assert(upsertSucessfully, 'Expected the Accounts to be upserted sucessfully');
	}

	/**
	* @description tests whether an upsert with a invalid Record returns false.
	*/ 
	@isTest
	private static void upsertNegative1() {
		List<Account> newRecords = AP_TestFactory.getRecords(Account.getSObjectType(), true);
		newRecords[0].Name = '';
		Boolean upsertSucessfully = AP_CrudUtil.upsertRecords(newRecords, false);
		System.assert(!upsertSucessfully, 'Expected a catched Exception and false returned.');
	}

	/**
	* @description tests whether an upsert with a invalid Record throws an Exception.
	*/
	@isTest
	private static void upsertNegative2() {
		List<Account> newRecords = AP_TestFactory.getRecords(Account.getSObjectType(), true);
		Boolean errorThrown = false;
		try {
			newRecords[0].Name = '';
			AP_CrudUtil.upsertRecords(newRecords, true);
		} catch (Exception ex) {
			errorThrown = true;
		} finally {
			System.assert(errorThrown, 'Expected an Exception to be Thorwn');
		}
	}

	/**
	* @description tests whether an delete with a valid Record returns true.
	*/ 
	@isTest
	private static void deletePositive() {
		List<Account> newRecords = AP_TestFactory.getRecords(Account.getSObjectType(), true);
		Boolean deleteSucessfully = AP_CrudUtil.deleteRecords(newRecords);
		System.assert(deleteSucessfully, 'Expected the Accounts to be deleted sucessfully');
	}

	/**
	* @description tests whether an delete with a invalid Record returns false.
	*/ 
	@isTest
	private static void deleteNegative1() {
		Account acc = new Account();
		Boolean deleteSucessfully = AP_CrudUtil.deleteRecords(new List<Account>{acc}, false);
		System.assert(!deleteSucessfully, 'Expected a catched Exception and false returned.');
	}

	/**
	* @description tests whether an delete with a invalid Record throws an Exception.
	*/
	@isTest
	private static void deleteNegative2() {
		Boolean errorThrown = false;
		try {
			Account acc = new Account();
			AP_CrudUtil.deleteRecords(new List<Account>{acc}, true);
		} catch (Exception ex) {
			errorThrown = true;
		} finally {
			System.assert(errorThrown, 'Expected an Exception to be Thorwn');
		}
	}
}
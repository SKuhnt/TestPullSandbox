/**
  @Company : aquilliance GmbH
  @Purpose : CrudUtil Class handels insert, update, upsert and delete operations
 
 ***************************************** Modification Log *****************************************
  Modified By					Modified on					Ticket No.					Comments
  Bhushan Patil					01-05-2019					----------					inital version
  Simon Kuhnt					07-04-2021					----------					Reworked for Package
*/ 
public class AP_CrudUtil {

    /**
	* @description Inserts the Records, catches Exceptions and might throw them again.
	* @param records List of Records to be inserted.
	* @param throwException Determines whether the Exception should be thrown.
	* @return Whether the Record was successfully inserted.  
	*/ 
	public static Boolean insertRecords(List<sObject> records, Boolean throwException){
		if(!records.isEmpty()){
			try{
				INSERT records;
				return true;
			} catch(Exception ex){
				doCatch(ex);
				if (throwException){
					throw ex;
				}
			}
		}
		return false;
	}
	
	/**
	* @description Inserts the Records, catches Exceptions and throws them again.
	* @param records List of Records to be inserted.
	* @return Whether the Record was successfully inserted.  
	*/ 
	public static Boolean insertRecords(List<sObject> records){
		return insertRecords(records, true);
	}

    /**
	* @description Updates the Records, catches Exceptions and might throw them again.
	* @param records List of Records to be updated.
	* @param throwException Determines whether the Exception should be thrown.
	* @return Whether the Record was successfully updated.  
	*/ 
	public static Boolean updateRecords(List<sObject> records, Boolean throwException){
		if(!records.isEmpty()){
			try{
				update records;
				return true;
			} catch(Exception ex){
				doCatch(ex);
				if (throwException){
					throw ex;
				}
			}
		}
		return false;
	}

	/**
	* @description Updates the Records, catches Exceptions and throws them again.
	* @param records List of Records to be updated.
	* @return Whether the Record was successfully updated.  
	*/ 
	public static Boolean updateRecords(List<sObject> records){
		return updateRecords(records, true);
	}

    /**
	* @description Upserts the Records, catches Exceptions and might throw them again.
	* @param records List of Records to be upserted.
	* @param throwException Determines whether the Exception should be thrown.
	* @return Whether the Record was successfully upserted.  
	*/ 
	public static Boolean upsertRecords(List<sObject> records, Boolean throwException){
		if(!records.isEmpty()){
			try{
				upsert records;
				return true;
			} catch(Exception ex){
				doCatch(ex);
				if (throwException){
					throw ex;
				}
			}
		}
		return false;
	}

    /**
	* @description Upserts the Records, catches Exceptions and throws them again.
	* @param records List of Records to be upserted.
	* @return Whether the Record was successfully upserted.  
	*/ 
	public static Boolean upsertRecords(List<sObject> records){
		return upsertRecords(records, true);
	}
	
    /**
	* @description Deletes the Records, catches Exceptions and might throw them again.
	* @param records List of Records to be deleted.
	* @param throwException Determines whether the Exception should be thrown.
	* @return Whether the Record was successfully deleted.  
	*/ 
	public static Boolean deleteRecords(List<sObject> records, Boolean throwException){
		if(!records.isEmpty()){
			try{
				delete records;
				return true;
			} catch(Exception ex){
				doCatch(ex);
				if (throwException){
					throw ex;
				}
			}
		}
		return false;
	}

    /**
	* @description Deletes the Records, catches Exceptions and throws them again.
	* @param records List of Records to be deleted.
	* @return Whether the Record was successfully deleted.  
	*/ 
	public static Boolean deleteRecords(List<sObject> records){
		return deleteRecords(records, true);
	}

	/**
	* @description System debug on the Exceptions message
	* @param ex Exception to be logged
	*/ 
    public static void doCatch(Exception ex){
        System.debug(ex.getMessage());
    }
}
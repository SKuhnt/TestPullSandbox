/*
  @Company : aquilliance GmbH
  @Purpose : CrudUtil Class handels insert, update, upsert and delete operations
 
 ***************************************** Modification Log *****************************************
  Modified By					Modified on					Ticket No.					Comments
  Bhushan Patil					01-05-2019					--------					inital version
  Simon Kuhnt					18-07-2019					--------					added package functionallity 
*/ 
public class CrudUtil {

    /**
	* @description Inserts the input records catches the exception and might throw it again
	* @param records 
	* @param throwException 
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
	* @description Inserts the input records catches the exception and throws it again
	* @param records 
	*/ 
	public static Boolean insertRecords(List<sObject> records){
		return insertRecords(records, true);
	}

	/**
	* @description Updates the input records catches the exception and might throw it again
	* @param records 
	* @param throwException
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
	* @description Updates the input records catches the exception and throws it again
	* @param records 
	*/ 
	public static Boolean updateRecords(List<sObject> records){
		return updateRecords(records, true);
	}

	/**
	* @description Upsert the input records catches the exception and might throw it again
	* @param records 
	* @param throwException
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
	* @description Upsert the input records catches the exception and throws it again
	* @param records 
	*/ 
	public static Boolean upsertRecords(List<sObject> records){
		return upsertRecords(records, true);
	}
	
	/**
	* @description Delete the input records catches the exception and might throw it again
	* @param records 
	* @param throwException
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
	* @description Delete the input records catches the exception and throws it again
	* @param records 
	*/ 
	public static Boolean deleteRecords(List<sObject> records){
		return deleteRecords(records, true);
	}

	/**
	* @description Actions after an error was thrown and the exception was caught
	* @param ex catched Exception 
	*/ 
    public static void doCatch(Exception ex){
        System.debug(ex.getMessage());
    }
}
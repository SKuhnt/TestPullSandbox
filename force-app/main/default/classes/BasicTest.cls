@isTest
public class BasicTest {

    @isTest 
    public static void test(){
        System.assertEquals(2, Basic.doIt());
    }
    @isTest 
    public static void test1_2(){
        System.assertEquals(1, Basic.doIt2());
    }
    @isTest 
    public static void test2(){
        System.assertEquals(2, Basic2.doIt());
    }

}
/********************
#Class: kanbanController
#Desc:
**********************/
public class kanbanController{

    /*************
    @methodName: fetchData
    *************/
    @AuraEnabled
    public static Map<string,List<Case>>  fetchData(){
        Map<string,List<Case>> caseStatusMap = new Map<string,List<Case>>();
        for(Case caseRec:[Select Id,CaseNumber,Status,Priority,Subject from Case]){
            if(caseStatusMap.keySet().contains(caseRec.Status)){
                caseStatusMap.get(caseRec.Status).add(caseRec);
            }else{
                List<case> caseList = new List<case>();
                caseList.add(caseRec);
                caseStatusMap.put(caseRec.Status,caseList);
            }
        }
        return caseStatusMap;
    }
    
    /*************
    @methodName: updateCase
    *************/
    @AuraEnabled
    public static void updateCase(Id caseId,String strStatus){
        try{
        Case caseRec = new Case();
        caseRec.Id =caseId;
        caseRec.Status = strStatus;
        update caseRec;
        }catch (DMLException e){
            system.debug(e);
        }
    }

}
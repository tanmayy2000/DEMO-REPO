public class StringOut {
    public static String starOut(String str) {
		List<Schema.PicklistEntry> csList = case.status.getDescribe().getPicklistValues();
        system.debug('csList::'+csList);
        List<Schema.RecordTypeInfo> recordTypes = Opportunity.SObjectType.GetDescribe().getRecordTypeInfos();
        System.debug('recordType::'+recordTypes);
        String str1 = '';
        integer count = 0;
        integer[] x = new integer[str.length()*2];
        boolean v = true;
        if(str.equals('*'))
        {
            return '';
        }
        for(integer i = 0;i<str.length();i++)
        {
            if(str.substring(i,i+1).equals('*'))
            {
                x[count]=i-1;
                x[count+1]=i;
                x[count+2]=i+1;
                count+=3;
            }
        }
        for(integer j = 0;j<str.length();j++)
        {
            for(integer p = 0;p<count;p++)
            {
                if(j==x[p])
                {
                    v = false; 
                }
            }
            if(v)
            {
                str1+=str.substring(j,j+1);
            }
            else{
                v = true;
            }
        }
        system.debug('result is::'+str1);
        return str1;
    }
}
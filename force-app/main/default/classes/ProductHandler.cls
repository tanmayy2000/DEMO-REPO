public class ProductHandler {
    public static void method(List<Product2> prodList){
        System.debug(prodList);
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        Pricebook2 pb = [SELECT Id,Name FROM Pricebook2 WHERE isStandard = true LIMIT 1 ];
        System.debug(pb);
        for(Product2 prod:prodList){
            PricebookEntry pbe = new PricebookEntry(Pricebook2Id = pb.Id,UnitPrice = 1,Product2Id = prod.Id);
            pbeList.add(pbe);
        }
        insert pbeList;
    }
     public static list<Database.SaveResult> Insert_Product( string name, string description, string family)
    {
        list<Product2> prolist= new list<Product2>();
        for(integer i=0;i<10;i++)
        {
            Product2 p=new Product2();
            p.Name = name+i;
            p.Description = description +i*2;
            p.Family = family +i+ family;
            proList.add(p);
            
        }
        
        return Database.insert(proList,false);
        
    }
}
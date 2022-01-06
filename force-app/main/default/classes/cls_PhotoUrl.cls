Public class cls_PhotoUrl
{
     public string Photolink{get;set;}
     Public cls_PhotoUrl()
     {
         User u = [Select u.SmallPhotoUrl, u.FullPhotoUrl 
                     From User u where u.id=:Userinfo.getUserid()];
        Photolink = u.FullPhotoUrl;
     }
}
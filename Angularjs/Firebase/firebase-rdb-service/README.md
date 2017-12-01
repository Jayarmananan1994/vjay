
This Angular service is build on top of already existing angular-fire.js which provides you the angular wrapper to the firebase functionality. 
  However to provide more flexibility ,the service provides various methods to get,update or delete from real time database as well as upload a file in your firebase storage bucket.
  By this way, avoiding injecting multiple firebase dependecy into your controller every time and can separate the firebase logic from your business logic in the controller / Services.
  To include this service, just add the js file in your project and add the Script tag from firebase console to your app.js. Add the dependency 'myfirebase.service' in your module.To make use of the service add 'MyFirebaseService' in your controller or service.This service provides the following method.
   1. addObjectToDBList:
        Pass the table name (node) and the object to be added. For nested path give the path like path/secondpath
        Returns a promise ,which once resolved gives the id of newly added object
   2. getTableRows
        Pass the table name (node) 
        Returns the list of pbjects 
   3. removeRowFromTable
          Pass the table name (node) and the object to be deleted. For nested path give the path like path/secondpath
          Returns a promise ,which once resolved gives true is success or false if failure
   4. uploadFile 
          Pass the folder path,filename and the file Object to be uploaded.
            Eg: uploadFile('pics/nature',myPic.jpeg,file) => uploads the file with path 'pics/nature/myPic.jpeg' in storage bucket.
          Returns a promise ,which once resolved gives the path of uploaded file.
  


Will try to add other feature like authentication in next commit.

  


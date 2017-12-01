(function(){
	angular
	.module('myfirebase.service',['firebase'])
	.factory('MyFirebaseService',MyFirebaseService);
	

	function MyFirebaseService($firebaseArray,$firebaseStorage,$q,$timeout){
		const rootDBRef= firebase.database().ref();
		var  services = {
			addObjectToDBList: addObjectToDBList,
			getTableRows: getTableRows,
			removeRowFromTable: removeRowFromTable,
			uploadFile : uploadFile
		}
		
		return services;
		////////////////////
		
		function getTableRows(ref){
			var ref = rootDBRef.child(ref);
			var list =  $firebaseArray(ref);
			return list.$loaded().then(function(x) {
				return x;
			}).catch(function(error){
				console.log("Error Fetching data",error);
			});
		}
		
		function addObjectToDBList(data,ref){
			var listRef = rootDBRef.child(ref);
			var list = $firebaseArray(listRef);
			return list.$add(data).then(function(ref){
				var id = ref.key;
				console.log("added record with id " + id);
				return id;
			});
			
		}
		
		function removeRowFromTable(ref,item){
			var ref = rootDBRef.child(ref);
			var list =  $firebaseArray(ref)
			
			return list.$loaded().then(function(x) {
				var delItem = findObjById(item,list);
				list.$remove(delItem).then(function(ref) {
					ref.key === item.$id; // true
					console.log("Deleted");
					return true;
				}).catch(function(error){
					console.log("Error:%O", error);
					return false;
				});			
			}) .catch(function(error) {
				console.log("Error:", error);
				return false;	
			});
		}
		
		function findObjById(item,list){
			var result = null;
			angular.forEach(list,function(val,key){
				var  key1 = val.$id;
				if(result==null){
					result = (key1 === item.$id) ? val : null;
				}
			
			});
			return result;
		}
		
		 function uploadFile(folder,filename,file){
			var q = $q.defer();
			var path = folder+"/"+filename;
			var fileRef = firebase.storage().ref(path);
			console.log(path);
					var storage = $firebaseStorage(fileRef);
					var uploadTask = storage.$put(file);
					uploadTask.$progress(function(snapshot) {
						var percentUploaded = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
						console.log(percentUploaded);
						if(percentUploaded==100){
							
						}
					}); 
					 uploadTask.$complete(function(snapshot) {
						console.log(snapshot.downloadURL);
						alert(snapshot.downloadURL);
						var fileObj = {};
						fileObj.Name = filename;
						fileObj.URL = snapshot.downloadURL;
						q.resolve(snapshot.downloadURL);
				
				}); 
			return q.promise;
		 }
		 
		 function deleteFile(){
		 
		 }
		
	}
})();

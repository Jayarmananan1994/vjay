angular.module('app',['excel-handler'])
	.controller('myCtrl',myCtrl);
	
function myCtrl($scope,ExcelServices){
	$scope.test = "asdasd"
	
	$scope.uploadFile = function(type){
		if(type=="json"){
			var file = document.getElementById("exfile").files[0];		
			ExcelServices.parseExceltoJson(file).then(function(data){
				console.log(data);
			});
		}else if(type=="csv"){
			var file = document.getElementById("exfile").files[0];		
			ExcelServices.parseExceltoCSVString(file).then(function(data){
				console.log(data);
			});
		}
		
	}
	
	$scope.giveURL = function(type){
		var url = $scope.url;
		if(type=="json"){	
			ExcelServices.parseExcelURLtoJson(url).then(function(data){
				console.log(data);
			});
		}else if(type=="csv"){
			ExcelServices.parseExcelURLtoCSV(url).then(function(data){
				console.log(data);
			});
		}
	}
}
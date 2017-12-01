(function(){
	'use strict';
	
	angular
		.module('excel-handler',[])	
		.service('ExcelServices',ExcelServices);
		
	function ExcelServices($q,$timeout,$http){
		
		this.generateExcel = function(arrayData){
			
		}
		
		this.parseExcelURLtoJson = function(url){
			var q = $q.defer();
			var xhr = new XMLHttpRequest();
			xhr.open('GET', url, true);
			xhr.responseType = 'blob';
			xhr.onload = function(e) {
				if (this.status == 200) {
					var myBlob = this.response;
					console.log(myBlob);
					return test(myBlob,"json").then(function(data){
						q.resolve(data);
					});
				}
			};
			xhr.send();
			return q.promise;
		}
		
		this.parseExcelURLtoCSV = function(url){
			var q = $q.defer();
			var xhr = new XMLHttpRequest();
			xhr.open('GET', url, true);
			xhr.responseType = 'blob';
			xhr.onload = function(e) {
				if (this.status == 200) {
					var myBlob = this.response;
					console.log(myBlob);
					return test(myBlob,"csv").then(function(data){
						q.resolve(data);
					});
				}
			};
			xhr.send();
			return q.promise;
		}
		
		this.parseExceltoJson = function(file){
			return test(file,"json").then(function(data){
						return data;
			});
		}
		
		this.parseExceltoCSVString = function(file){
			return test(file,"csv").then(function(data){
						return data;
			});
		}
		
		function test(file,type){
			var q = $q.defer();
			console.log("generating file with given data");
			if (file) {
				var reader = new FileReader();
				reader.readAsBinaryString(file);
				reader.onloadend = function (evt) {
					var data = evt.target.result;  						
					if(type=="json"){
						var json_object = processWorkBook(data);
						q.resolve(JSON.parse(json_object));
					}else if(type=="csv"){
						var csv_object = toCSV(data);
						q.resolve(csv_object);
					}
				}
				reader.onerror = function (evt) {
					console.log("error reading file");
				}
			}
			return q.promise;
		}
		
		function toCSV(excelData){
			var workbook = XLSX.read(excelData, {
						type: 'binary'
			});	
			var result = [];
			workbook.SheetNames.forEach(function(sheetName) {
				var csv = XLSX.utils.sheet_to_csv(workbook.Sheets[sheetName]);
				if(csv.length){
					result.push("SHEET: " + sheetName);
					result.push("");
					result.push(csv);
				}
			});
			return result.join("\n");
		}
		
		
		function processWorkBook(excelData){
			var workbook = XLSX.read(excelData, {
						type: 'binary'
			});			
			var json_object = "";		
			workbook.SheetNames.forEach(function(sheetName) {        // Here is your object
				var XL_row_object = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName]);
				json_object = JSON.stringify(XL_row_object);
			});	
			return json_object
		}
		
		
	}	
	
})();
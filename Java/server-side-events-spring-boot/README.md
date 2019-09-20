# server-sent-events-spring-boot

This is a simple web application build using Spring flux( Spring's way of  building reactive web stack) to demonstrate server sent event and an angular app to consume it. In this application, we let the product owner to add thier product to the Bid while number of consumers can bid for that product. While different consumers bid for the product, the product owner can see the bid at real time.

# Steps to Run the application:

1. Switch to 'bidding-service ' directory and run the command to start the service.
	> mvn spring-boot:run
   Now the service will be running in http://localhost:8080/

2. Then switch to 'bidding-angular-app' and run the below commands to start the angular app.
	> npm install
	> ng serve

   The application will be started in  http://localhost:4200


# Tech stack used:

1. Spring webflux + embedded mongo DB.

2. Angular 8

# How application works.

1. Navigate to  http://localhost:4200. The first screen has a text fields that let product owner to add his product name and price and add it for bid process.

2. In the same screen , there is a button to list all the item that has been submitted for the bidding.

3. In the item list page, we have different items submited for bidding and the option to track the bid for that item.

4. On clicking the track button, the bidding made on that items will be listed with real time data. 

5. To see how it works, we can click on 'Make dummy bid on item' to simulate a bidding or make post request to the url as below.

	**URL**: http://localhost:8080/bid/postbidresponse
 	**Body**: 
 	 ```javascript
 	    {
		"proposedBy": "ram",
		"amount": 5500.0,
		"bitRequestId": "5d8212c342c4ec6302070d67"
	     }
	  ```
  



// This file can be replaced during build by using the `fileReplacements` array.
// `ng build --prod` replaces `environment.ts` with `environment.prod.ts`.
// The list of file replacements can be found in `angular.json`.

export const environment = {
  production: false,
  firebaseConfig: {
    apiKey: "AIzaSyBPuawe3jsu-V4Y6432HnOEo988k9C3BkQ",
    authDomain: "chatroom-vjay.firebaseapp.com",
    databaseURL: "https://chatroom-vjay.firebaseio.com",
    projectId: "chatroom-vjay",
    storageBucket: "chatroom-vjay.appspot.com",
    messagingSenderId: "65611356536"
  },
  dialogFlow:{
    botKey: '2e10d70a2b254c78a83d6ce20160ce82'
  }
};

/*
 * For easier debugging in development mode, you can import the following file
 * to ignore zone related error stack frames such as `zone.run`, `zoneDelegate.invokeTask`.
 *
 * This import should be commented out in production mode because it will have a negative impact
 * on performance if an error is thrown.
 */
// import 'zone.js/dist/zone-error';  // Included with Angular CLI.

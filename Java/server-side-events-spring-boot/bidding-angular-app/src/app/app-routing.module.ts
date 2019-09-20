import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { RequestListComponent } from './request-list/request-list.component';
import { ModuleWithProviders } from '@angular/compiler/src/core';


const routes: Routes = [
  {path:"requestlist", component: RequestListComponent}
];

// @NgModule({
//   imports: [RouterModule.forRoot(routes)],
//   exports: [RouterModule]
// })
// export class AppRoutingModule { 
 
//}
export const routingModule: ModuleWithProviders = RouterModule.forRoot(routes);

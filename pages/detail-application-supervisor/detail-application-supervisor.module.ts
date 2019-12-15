import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { DetailApplicationSupervisorPage } from './detail-application-supervisor';

@NgModule({
  declarations: [
    DetailApplicationSupervisorPage,
  ],
  imports: [
    IonicPageModule.forChild(DetailApplicationSupervisorPage),
  ],
})
export class DetailApplicationSupervisorPageModule {}

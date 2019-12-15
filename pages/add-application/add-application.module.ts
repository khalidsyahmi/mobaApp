import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { AddApplicationPage } from './add-application';
import { TranslateModule } from '@ngx-translate/core';


@NgModule({
  declarations: [
    AddApplicationPage,
  ],
  imports: [
    IonicPageModule.forChild(AddApplicationPage),
    TranslateModule.forChild()           // translation module using Json library file in assets      

  ],
})
export class AddApplicationPageModule {}

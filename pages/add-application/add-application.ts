import { Component, ViewChild } from '@angular/core';
//module imports
import { IonicPage, NavController, ViewController, AlertController } from 'ionic-angular';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { TranslateService } from '@ngx-translate/core';

/**
 * Generated class for the AddApplicationPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage()
@Component({
  selector: 'page-add-application',
  templateUrl: 'add-application.html',
})

export class AddApplicationPage {
  @ViewChild('fileInput') fileInput;

  isReadyToSave: boolean;

  //add variable used in html file
  public baseURI : any;
  public data:  any;

  item: any;
  public ipKeyServerString  : any;

  leaveForm: FormGroup;

  public motive : any;
  public duration1 : any;
  public duration2 : any;
  public dateApplication : any;

// added controller
  constructor(public navCtrl: NavController, public viewCtrl: ViewController, 
    public formBuilder: FormBuilder, public translateService: TranslateService,
    public http: HttpClient, public alertCtrl: AlertController ) {

      //added declared var / also validators
      this.leaveForm = formBuilder.group({
        motive : ['', Validators.required],
        duration1 : ['', Validators.required],
        duration2 : ['', Validators.required],
        dateApplication : ['', Validators.required],
      });
      
      // Tranlate service...
      this.translateService.get('IP_SERVER_KEY') 
      .subscribe((value) => {
        this.ipKeyServerString = value;
      })
      this.baseURI="http://localhost/leave/controller.php";
  }

  // save value function
  saveEntry() : void {
        let motive : string = this.leaveForm.controls["motive"].value,
        duration1 : string = this.leaveForm.controls["duration1"].value,
        duration2 : string = this.leaveForm.controls["duration2"].value,
        dateApplication : string = this.leaveForm.controls["dateApplication"].value

        this.createEntry(motive, duration1, duration2, dateApplication);
  }

  //process data onClick
  createEntry(motive : string, duration1 : string, duration2 : string
    , dateApplication : string) : void {

      let headers : any     = new HttpHeaders({
        'Content-Type'  : 'application/json'}),
         options : any  = { "key" :
        "addLeave",  
        "motive" : motive,
        "duration1" :  duration1,
        "duration2" :  duration2,
        "dateApplication" :  dateApplication
        },  
        url : any   =this.baseURI;

      this.http.post(url, JSON.stringify(options),headers)
      .subscribe((data : any) =>
      {
        // if request success
        this.showSuccess();
        this.goList();
      },
      (error : any) =>{
        this.showFailed();
      });
  }

  //prompt functions
  showSuccess(){
    const alert = this.alertCtrl.create({
      title:  'Success!',
      subTitle: 'Allocation information was successfully to be inserted!',
      buttons:  ['OK']
    });
    alert.present();
  }

  showFailed(){
    const alert = this.alertCtrl.create({
      title:  'Error!',
      subTitle: 'Allocation information failed to be inserted!',
      buttons:  ['OK']
    });
    alert.present();
  }

  goList()  {
    this.navCtrl.push('TabsPage');
  }
  //cancelled user ?

  cancel(){
    this.viewCtrl.dismiss();
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad AddApplicationPage');
  }

}

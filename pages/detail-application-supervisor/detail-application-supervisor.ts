import { Component, ViewChild } from '@angular/core';
import { IonicPage, NavController, ViewController, AlertController } from 'ionic-angular';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { TranslateService } from '@ngx-translate/core';
/**
 * Generated class for the DetailApplicationSupervisorPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage()
@Component({
  selector: 'page-detail-application-supervisor',
  templateUrl: 'detail-application-supervisor.html',
})
export class DetailApplicationSupervisorPage {

  @ViewChild('fileInput') fileInput;

  isReadyToSave: boolean;

  //add variable used in html file
  public baseURI : any;
  public data:  any;

  item: any;
  public ipKeyServerString  : any;

  svForm: FormGroup;

  public approval : any;
  public comment : any;
  

  constructor(public navCtrl: NavController, public viewCtrl: ViewController, 
    public formBuilder: FormBuilder, public translateService: TranslateService,
    public http: HttpClient, public alertCtrl: AlertController) {

        //added declared var / also validators
        this.svForm = formBuilder.group({
          approval : ['', Validators.required],
          comment : ['', Validators.required],
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
    let approval : string = this.svForm.controls["approval"].value,
    comment : string = this.svForm.controls["comment"].value


    this.createEntry(approval, comment);
}

//process data onClick
createEntry(approval : string, comment : string ) : void {

  let headers : any     = new HttpHeaders({
    'Content-Type'  : 'application/json'}),
     options : any  = { "key" :
    "addLeave",  
    "approval" : approval,
    "comment" :  comment

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
    console.log('ionViewDidLoad DetailApplicationSupervisorPage');
  }

}

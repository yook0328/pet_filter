import { Component, OnInit, ElementRef, ViewChild } from '@angular/core';
import { ModalComponent } from 'ng2-bs3-modal/ng2-bs3-modal';
import {
  FormGroup,
  FormControl,
  Validators,
  FormBuilder,
  FormArray
} from "@angular/forms";
import { Http, Headers, RequestOptions } from '@angular/http';
import {Router} from '@angular/router'
import {DataServiceService} from '../../data-service.service'
import { DogFoodItem, FoodContents, GuaranteedAnalysis } from '../../Item/DogFoodItem'

@Component({
  selector: 'pet-add-treat',
  templateUrl: './add-treat.component.html',
  styleUrls: ['./add-treat.component.css']
})
export class AddTreatComponent implements OnInit {

  @ViewChild('myModal')
    modal: ModalComponent;
  
  registerFoodForm: FormGroup;
  flavor_primaryIngridient: boolean = false;
  imageFile: File;
  resultStatus = 0;
  public ingredients = [ ];
  public filteredList = [];
  modal_body = 'result';
  isFoodTypeChange = false;
  dog_treats_types = [
    'biscuits & bakery',
    'bones & rawhide',
    'chewy treats',
    'dental treats',
    'jerky',
    'training treats'
  ];
  cat_treats_types = [
    'crunchy treats',
    'catnip & grass',
    
    'dental treats',
    'jerky',
    'soft treats'
  ]
  pet_types = [
    'Dog',
    'Cat'
  ];

  constructor(private formBuilder: FormBuilder, private element: ElementRef, private http: Http, private router: Router, private dataService: DataServiceService) { 
    this.registerFoodForm = formBuilder.group({
      'petType' : ['Dog'],
      'foodname': ['', [Validators.required]],
      'brand' : ['', [Validators.required]],
      'foodType' : ['biscuits & bakery'],
      'ingredients' : ['',[Validators.required]],
      'guaranteedAnalysisName' : formBuilder.array([['', [Validators.required]]]),
      'guaranteedAnalysisContent' : formBuilder.array([['', [Validators.required]]]),
      'guaranteedAnalysisMinOrMax' : formBuilder.array([[false, [Validators.required]]]),
      'description' : ['', [Validators.required]]
    });

  }

  ngOnInit() {
    
  }

  onAddContent() {
    (<FormArray>this.registerFoodForm.controls['guaranteedAnalysisName']).push(new FormControl('', Validators.required));
    (<FormArray>this.registerFoodForm.controls['guaranteedAnalysisContent']).push(new FormControl('', Validators.required));
    (<FormArray>this.registerFoodForm.controls['guaranteedAnalysisMinOrMax']).push(new FormControl(false, Validators.required));
  }

  getFoodType() {

    if((this.registerFoodForm.controls['petType'].value as string) == 'Dog'){
      
      return this.dog_treats_types;
    }else{
      
      return this.cat_treats_types;
    }
  }
  onChangePetType(type : string){

    if(type == 'Dog'){
      
      this.registerFoodForm.controls['foodType'].setValue('biscuits & bakery');
    }else{
      this.registerFoodForm.controls['foodType'].setValue('crunchy treats');
    }
    
  }
  onAddFoodAgain(){
    this.modal.close();
    location.reload();

  }
  clickGA_delteIcon(index : number){
    console.log(index);
    (<FormArray>this.registerFoodForm.controls['guaranteedAnalysisName']).removeAt(index);
    (<FormArray>this.registerFoodForm.controls['guaranteedAnalysisContent']).removeAt(index);
    (<FormArray>this.registerFoodForm.controls['guaranteedAnalysisMinOrMax']).removeAt(index);
  }
  onCancel(){
    this.modal.close();
    
    if(this.resultStatus == 200){
      this.router.navigateByUrl('/home');
      
    }else if(this.resultStatus == 401){
      
    }
    
  }
  onAddImage($event) : void {
    this.readThis($event.target);
  }
  readThis(inputValue: any) : void {
    this.imageFile = inputValue.files[0]; 
    
    var myReader:FileReader = new FileReader();
    var image = this.element.nativeElement.querySelector('.image');
    myReader.readAsDataURL(this.imageFile);
    myReader.onloadend = function(e){
      // you can perform an action with readed data here
      //console.log(myReader.result);
    }
    myReader.onload = function(e){

      image.src = myReader.result;
      
    } 
  }

  onSubmit() {
    
    var formData : FormData = new FormData();
    formData.append('image_file', this.imageFile);
    formData.append('foodname', (this.registerFoodForm.controls['foodname'].value as string).trim());
    formData.append('brand', (this.registerFoodForm.controls['brand'].value as string).trim());
    formData.append('foodType', this.registerFoodForm.controls['foodType'].value);
    formData.append('description', this.registerFoodForm.controls['description'].value);
    
    var arrayControl = (this.registerFoodForm.controls['ingredients'].value as string).split(',');
    
    var ingredients_data = '';
    for(var k in arrayControl){
      if(ingredients_data.length != 0 ){

        if(arrayControl[k].trim().length != 0){
          ingredients_data += ','+arrayControl[k].trim();
        }
        
      }else{
        if(arrayControl[k].trim().length != 0){
          ingredients_data += arrayControl[k].trim();
        } 
      }     
    }
    formData.append('ingredients',ingredients_data);


    var guaranteedAnalysis = new Array<GuaranteedAnalysis>();
    
    var nameArrayControl = this.registerFoodForm.get('guaranteedAnalysisName') as FormArray;
    var minOrMaxArrayControl = this.registerFoodForm.get('guaranteedAnalysisMinOrMax') as FormArray;
    var contentArrayControl = this.registerFoodForm.get('guaranteedAnalysisContent') as FormArray;
    
    for(var j = 0; j < nameArrayControl.length; j++ ){
      var name = (nameArrayControl.at(j).value as string).trim();
      var minOrMax = minOrMaxArrayControl.at(j).value as boolean;
      var content = (contentArrayControl.at(j).value as string).trim();

      guaranteedAnalysis.push(new GuaranteedAnalysis(name,minOrMax,content,-1));
      
    }
    formData.append('guaranteedAnalysis', JSON.stringify(guaranteedAnalysis));

    var headers = new Headers({});

    let options = new RequestOptions({ headers });

    let url = this.dataService.getURL();
    if((this.registerFoodForm.controls['petType'].value as string) == 'Dog'){
      url +=  '/addDogTreats';
    }else{
      url += '/addCatTreats';
    }
    console.log(formData);
    this.http.post(url, formData, options).map(res => {
      if(res.status == 200){
        return res.status;
      }else{
        throw new Error('This request has failed ' + res.status); 
      }
    }).subscribe( (statusCode) => {
      this.resultStatus = statusCode;
      this.modal.open();
      this.modal_body = 'Success!'
    },(err)=>{
      this.modal.open();
      this.modal_body = 'Fail! Check all field again'
    });
  }
}

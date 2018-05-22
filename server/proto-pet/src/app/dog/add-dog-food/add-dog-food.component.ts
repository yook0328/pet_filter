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

@Component({
  selector: 'pet-add-dog-food',
  templateUrl: './add-dog-food.component.html',
  styleUrls: ['./add-dog-food.component.css'],

})
export class AddDogFoodComponent implements OnInit {

  @ViewChild('myModal')
    modal: ModalComponent;
  
  registerFoodForm: FormGroup;
  flavor_primaryIngridient: boolean = false;
  imageFile: File;
  resultStatus = 0;
  public ingredients = [ ];
  public filteredList = [];
  modal_body = 'result';
  food_types = [
    'canned food',
    'dry food',
    'raw food'
  ];
  pet_types = [
    'Dog',
    'Cat'
  ];
  health_consideration = {
    'active' : false,
    'aging' : false,
    'allergies' : false,
    'appetite stimulator' : false,
    'bone development' : false,
    'brain development' : false,
    'cardiac' : false,
    'dental care' : false,
    'diabetic' : false,
    'digestive care' : false,
    'gastrointestinal' : false,
    'general health' : false,
    'gestation support' : false,
    'hip & joint' : false,
    'hypoallergenic' : false,
    'immune system' : false,
    'indoor diet' : false,
    'itch relief' : false,
    'kidney' : false,
    'lactation support' : false,
    'liver' : false,
    'malnourished' : false,
    'mobility' : false,
    'muscle tone' : false,
    'odor control' : false,
    'satiety' : false,
    'sensitive skin' : false,
    'sensitive stomach' : false,
    'shiny coat' : false,
    'skin & coat' : false,
    'stress & anxiety relief' : false,
    'urinary tract' : false,
    'vision' : false,
    'weaning' : false,
    'weight control' : false,
  };
  health_consideration_keys: string[] = [];
  nutritional_options = {
    'gluten free':false,
    'grain free':false,
    'limited ingredient':false,
    'natural':false,
    'non-gmo':false,
    'organic':false,
    'raw':false
  }
  nutritional_options_keys: string[] = [];
  constructor(private formBuilder: FormBuilder, private element: ElementRef, private http: Http, private router: Router, private dataService: DataServiceService) {
    this.registerFoodForm = formBuilder.group({
      'petType' : ['Dog'],
      'foodname': ['', [Validators.required]],
      'brand' : ['', [Validators.required]],
      'foodType' : ['dry food'],
      'ingredients' : ['',[Validators.required]],
      'health_consideration' : [''],
      'nutritional_option' : [''],
      'guaranteedAnalysisName' : formBuilder.array([['', [Validators.required]]]),
      'guaranteedAnalysisContent' : formBuilder.array([['', [Validators.required]]]),
      'guaranteedAnalysisMinOrMax' : formBuilder.array([[false, [Validators.required]]]),
      'description' : ['', [Validators.required]]
    });
    
   }
 
  onAddImage($event) : void {
    this.readThis($event.target);
  }
  onChecked_flavor_primaryIngridient() : void{
    this.flavor_primaryIngridient = !this.flavor_primaryIngridient;

    if(this.flavor_primaryIngridient){
      this.registerFoodForm.controls['flavor'].setValue(this.registerFoodForm.controls['primaryIngredient'].value);
    }
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
  onAddContent() {
    (<FormArray>this.registerFoodForm.controls['guaranteedAnalysisName']).push(new FormControl('', Validators.required));
    (<FormArray>this.registerFoodForm.controls['guaranteedAnalysisContent']).push(new FormControl('', Validators.required));
    (<FormArray>this.registerFoodForm.controls['guaranteedAnalysisMinOrMax']).push(new FormControl(false, Validators.required));
  }
  onSubmit() {
    
    var health_consideration_value = '';
    var nutritional_option_value = '';
    for(var i in this.health_consideration){
      if(this.health_consideration[i]){
        if(health_consideration_value.length == 0){
          health_consideration_value = i;
        }else{
          health_consideration_value += ',' + i;
        }
      }
    }
    for(var i in this.nutritional_options){
      if(this.nutritional_options[i]){
        if(nutritional_option_value.length == 0){
          nutritional_option_value = i;
        }else{
          nutritional_option_value += ',' + i;
        }
      }
    }


    var formData : FormData = new FormData();
    formData.append('image_file', this.imageFile);
    formData.append('foodname', (this.registerFoodForm.controls['foodname'].value as string).trim());
    formData.append('brand', (this.registerFoodForm.controls['brand'].value as string).trim());
    formData.append('foodType', this.registerFoodForm.controls['foodType'].value);
    formData.append('description', this.registerFoodForm.controls['description'].value);
    formData.append('nutritionalOption',nutritional_option_value);
    formData.append('healthConsideration',health_consideration_value);
    
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

      guaranteedAnalysis.push(new GuaranteedAnalysis(name,minOrMax,content));
      
    }
    formData.append('guaranteedAnalysis', JSON.stringify(guaranteedAnalysis));

    var headers = new Headers({});

    let options = new RequestOptions({ headers });

    let url = this.dataService.getURL();
    if((this.registerFoodForm.controls['petType'].value as string) == 'Dog'){
      url +=  '/addDogFood';
    }else{
      url += '/addCatFood';
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
  onCancel(){
    this.modal.close();
    
    if(this.resultStatus == 200){
      this.router.navigateByUrl('/home');
      
    }else if(this.resultStatus == 401){
      
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
  ngOnInit() {
    for(var i = 0; i < Object.keys(this.health_consideration).length; i++){
      this.health_consideration_keys.push(Object.keys(this.health_consideration)[i]);
    }

    for(var i = 0; i < Object.keys(this.nutritional_options).length; i++){
      this.nutritional_options_keys.push(Object.keys(this.nutritional_options)[i]);
    }

     this.http.get(this.dataService.getURL() + '/DogFood/get_ingredients').map(res => {
      if(res.status == 200){

        return res.text();
      }else{
        throw new Error('This request has failed ' + res.status); 
      }
    }).subscribe((data) => {      
      this.ingredients = data.split(',');
    }, (err) => {
      console.log('error');
    });
    
  }
  filter() {
      let words = (this.registerFoodForm.controls['ingredients'].value as string).split(',');
      let word = words[words.length-1];
      if (word.trim().length >= 2){
          this.filteredList = this.ingredients.filter(function(el){
              return el.toLowerCase().indexOf(word.trim().toLowerCase()) > -1;
          }.bind(this));
      }else{
          this.filteredList = [];
      }
  }
  
  select(item){

      let words = (this.registerFoodForm.controls['ingredients'].value as string).split(',');
      let word = words[words.length-1];
      var str = (this.registerFoodForm.controls['ingredients'].value as string).replace(new RegExp(word + '$'), item);;
      this.registerFoodForm.controls['ingredients'].setValue(str);
      this.filteredList = [];
  }


}
class GuaranteedAnalysis{
  constructor(public name : string, public maxOrMin : boolean, public content : string){
    
  }
}

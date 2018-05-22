import { Component, OnInit, ElementRef, ViewChild  } from '@angular/core';
import { Router, Params } from '@angular/router';
import { DogFoodItem, FoodContents, GuaranteedAnalysis } from '../../Item/DogFoodItem'
import { ModalComponent } from 'ng2-bs3-modal/ng2-bs3-modal';
import {
  FormGroup,
  FormControl,
  Validators,
  FormBuilder,
  FormArray
} from "@angular/forms";
import { Http, Headers, RequestOptions } from '@angular/http';
import {DataServiceService} from '../../data-service.service'

@Component({
  selector: 'app-edit-dog-food',
  templateUrl: './edit-dog-food.component.html',
  styleUrls: ['./edit-dog-food.component.css']
})
export class EditDogFoodComponent implements OnInit {

  @ViewChild('myModal')
      modal: ModalComponent;
  item : DogFoodItem;
  editFoodForm: FormGroup;
  flavor_primaryIngridient: boolean = false;
  imageFile: File;
  resultStatus = 0;
  url = this.dataService.getURL();
  modal_body = 'result';
  public ingredients = [ ];
  public filteredList = [];
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
  
    
  constructor( private formBuilder: FormBuilder, public element: ElementRef, private http: Http, private router: Router
  , private dataService : DataServiceService) 
  { 
    
  }
  

  onAddImage($event) : void {
    this.readThis($event.target);
  }
  onChecked_flavor_primaryIngridient() : void{
    this.flavor_primaryIngridient = !this.flavor_primaryIngridient;

    if(this.flavor_primaryIngridient){
      this.editFoodForm.controls['flavor'].setValue(this.editFoodForm.controls['primaryIngredient'].value);
    }
  }
  readThis(inputValue: any) : void {
    this.imageFile = inputValue.files[0]; 
    
    var myReader:FileReader = new FileReader();
    var image = this.element.nativeElement.querySelector('.image');
    myReader.readAsDataURL(this.imageFile);
    myReader.onloadend = function(e){
      // you can perform an action with readed data here
    }
    myReader.onload = function(e){

      image.src = myReader.result;
      
    }
  }
  onAddContent() {
    (<FormArray>this.editFoodForm.controls['guaranteedAnalysisName']).push(new FormControl('', Validators.required));
    (<FormArray>this.editFoodForm.controls['guaranteedAnalysisContent']).push(new FormControl('', Validators.required));
    (<FormArray>this.editFoodForm.controls['guaranteedAnalysisMinOrMax']).push(new FormControl(false, Validators.required));
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
    if(this.imageFile){
      formData.append('image_file', this.imageFile);
    }
    formData.append('id', this.item.id);
    formData.append('foodname', (this.editFoodForm.controls['foodname'].value as string).trim());
    formData.append('brand', (this.editFoodForm.controls['brand'].value as string).trim());
    formData.append('foodType', this.editFoodForm.controls['foodType'].value);
    formData.append('description', this.editFoodForm.controls['description'].value);
    formData.append('nutritionalOption',nutritional_option_value);
    formData.append('healthConsideration',health_consideration_value);

    var arrayControl = (this.editFoodForm.controls['ingredients'].value as string).split(',');
    
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
    
    var nameArrayControl = this.editFoodForm.get('guaranteedAnalysisName') as FormArray;
    var minOrMaxArrayControl = this.editFoodForm.get('guaranteedAnalysisMinOrMax') as FormArray;
    var contentArrayControl = this.editFoodForm.get('guaranteedAnalysisContent') as FormArray;
    
    for(var j = 0; j < nameArrayControl.length; j++ ){
      var name = (nameArrayControl.at(j).value as string).trim();
      var minOrMax = minOrMaxArrayControl.at(j).value as boolean;
      var content = (contentArrayControl.at(j).value as string).trim();

      guaranteedAnalysis.push(new GuaranteedAnalysis(name,minOrMax,content,0));
      
    }
    formData.append('guaranteedAnalysis', JSON.stringify(guaranteedAnalysis));
    
    var headers = new Headers({});
    //headers.set('Content-Type', 'multipart/form-data');
    

    let url = this.dataService.getURL()
    if((this.dataService.getItemType() as string) == 'Dog'){
      url += '/updateDogFood'
    }else{
      url += '/updateCatFood'
    }
    if(this.imageFile){
      
      url +=  '/image';
    }
    let options = new RequestOptions({ headers });

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
  setImage(name : string){
    
    let url = this.dataService.getURL();
    if((this.dataService.getItemType() as string) == 'Dog'){
      url += '/DogFood'
    }else{
      url += '/CatFood'
    }
    return url + '/loadImage/'+name;
  }
  setInitGuaranteedAnalysis( arr : GuaranteedAnalysis[])
  {
    for(var i =0; i< arr.length; i++){
      (<FormArray>this.editFoodForm.controls['guaranteedAnalysisName']).push(new FormControl(arr[i].name, Validators.required));
      (<FormArray>this.editFoodForm.controls['guaranteedAnalysisContent']).push(new FormControl(arr[i].content, Validators.required));
      (<FormArray>this.editFoodForm.controls['guaranteedAnalysisMinOrMax']).push(new FormControl(arr[i].maxOrMin, Validators.required));

    }
  }
  setInitIngredients( arr : FoodContents[] )
  {
    var result = '';
    for(var i = 0; i<arr.length; i++){
      
      if(i != 0){
        result += ',' + arr[i].name;
      }else{
        result += arr[i].name;
      }
    }
    return result;
  }
  clickGA_delteIcon(index : number){
    console.log(index);
    (<FormArray>this.editFoodForm.controls['guaranteedAnalysisName']).removeAt(index);
    (<FormArray>this.editFoodForm.controls['guaranteedAnalysisContent']).removeAt(index);
    (<FormArray>this.editFoodForm.controls['guaranteedAnalysisMinOrMax']).removeAt(index);
  }
  ngOnInit() {


    this.item = this.dataService.getItem();

    for(var i = 0; i < Object.keys(this.health_consideration).length; i++){
      this.health_consideration_keys.push(Object.keys(this.health_consideration)[i]);
    }

    for(var i = 0; i < Object.keys(this.nutritional_options).length; i++){
      this.nutritional_options_keys.push(Object.keys(this.nutritional_options)[i]);
    }

    this.editFoodForm = this.formBuilder.group({
      'foodname': [this.item.food_name, [Validators.required]],
      'brand' : [ this.item.brand, [Validators.required]],
      'foodType' : [this.item.food_type],
      'ingredients' : [ this.setInitIngredients(this.item.ingredients as FoodContents[]),[Validators.required]],
      'health_consideration' : [''],
      'nutritional_option' : [''],
      'guaranteedAnalysisName' : this.formBuilder.array([]),
      'guaranteedAnalysisContent' : this.formBuilder.array([]),
      'guaranteedAnalysisMinOrMax' : this.formBuilder.array([]),
      'description' : [this.item.description, [Validators.required]],
    });
    this.setInitGuaranteedAnalysis(this.item.guaranteedAnalysis);

    for(var i = 0; i < this.item.health_considerations.length; i++){
      this.health_consideration[this.item.health_considerations[i].name] = true;
    }
    for(var i = 0; i < this.item.nutritional_options.length; i++){
      this.nutritional_options[this.item.nutritional_options[i].name] = true;
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
      let words = (this.editFoodForm.controls['ingredients'].value as string).split(',');
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

      let words = (this.editFoodForm.controls['ingredients'].value as string).split(',');
      let word = words[words.length-1];
      var str = (this.editFoodForm.controls['ingredients'].value as string).replace(new RegExp(word + '$'), item);;
      this.editFoodForm.controls['ingredients'].setValue(str);
      this.filteredList = [];
  }


  
  
  
}

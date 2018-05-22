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
  selector: 'pet-edit-treats',
  templateUrl: './edit-treats.component.html',
  styleUrls: ['./edit-treats.component.css']
})
export class EditTreatsComponent implements OnInit {
  @ViewChild('myModal')
    modal: ModalComponent;
  
  editFoodForm: FormGroup;
  item : DogFoodItem;
  imageFile: File;
  resultStatus = 0;
  public ingredients = [ ];
  public filteredList = [];
  modal_body = 'result';
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
  constructor(private formBuilder: FormBuilder, public element: ElementRef, private http: Http, private router: Router
  , private dataService : DataServiceService) { 
    
  }

  ngOnInit() {

    this.item = this.dataService.getItem();
    this.editFoodForm = this.formBuilder.group({
      'foodname': [this.item.food_name, [Validators.required]],
      'brand' : [ this.item.brand, [Validators.required]],
      'foodType' : [this.item.food_type],
      'ingredients' : [ this.setInitIngredients(this.item.ingredients as FoodContents[]),[Validators.required]],
      'guaranteedAnalysisName' : this.formBuilder.array([]),
      'guaranteedAnalysisContent' : this.formBuilder.array([]),
      'guaranteedAnalysisMinOrMax' : this.formBuilder.array([]),
      'description' : [this.item.description, [Validators.required]],
    });
    this.setInitGuaranteedAnalysis(this.item.guaranteedAnalysis);

  }
  getFoodType() {
    if((this.dataService.getItemType() as string) == 'Dog'){
      //this.editFoodForm.controls['foodType'].setValue('biscuits & bakery');
      return this.dog_treats_types;
    }else{
      //this.editFoodForm.controls['foodType'].setValue('crunchy treats');
      return this.cat_treats_types;
    }
  }
  onSubmit() {
    
    

    var formData : FormData = new FormData();
    if(this.imageFile){
      formData.append('image_file', this.imageFile);
    }
    formData.append('id', this.item.id);
    formData.append('foodname', (this.editFoodForm.controls['foodname'].value as string).trim());
    formData.append('brand', (this.editFoodForm.controls['brand'].value as string).trim());
    formData.append('foodType', this.editFoodForm.controls['foodType'].value);
    formData.append('description', this.editFoodForm.controls['description'].value);


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
      url += '/updateDogTreats'
    }else{
      url += '/updateCatTreats'
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

  setImage(name : string){
    
    let url = this.dataService.getURL();
    if((this.dataService.getItemType() as string) == 'Dog'){
      url += '/DogTreats'
    }else{
      url += '/CatTreats'
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
  onCancel(){
    this.modal.close();
    
    if(this.resultStatus == 200){
      this.router.navigateByUrl('/home');
      
    }else if(this.resultStatus == 401){
      
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

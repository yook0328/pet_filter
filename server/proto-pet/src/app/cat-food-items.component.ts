import { Component, OnInit } from '@angular/core';
import { Http, Headers, RequestOptions } from '@angular/http';
import {Router} from '@angular/router';
import { DogFoodItem,FoodContents,GuaranteedAnalysis } from './Item/DogFoodItem';
import {DataServiceService} from './data-service.service';
import { PagerClass } from './pagerClass';

@Component({
  selector: 'pet-cat-food-items',
  templateUrl: './cat-food-items.component.html',
  styleUrls: ['./cat-food-items.component.css'],
  providers: [ PagerClass ]
})
export class CatFoodItemsComponent implements OnInit {

  page_no = 0;
  Items : DogFoodItem[] = [];
  ItemsStorage : DogFoodItem[] = [];
  url = this.dataService.getURL() + '/CatFood';
  pager: any = {};
  totalItemCount : number;
  
  constructor(private http: Http, private router: Router, private dataService: DataServiceService
  , private pagerService: PagerClass) { }

  ngOnInit() {
    

    this.http.get(this.url + '/countFoodItems').map(res => {
      if(res.status == 200){
        return res.text();
      }else{
        throw new Error('This request has failed ' + res.status); 
      }
    }).subscribe((data) => {
      this.totalItemCount = +data;
      this.setPage(1);
    }, (err) => {
      console.log('error');
    })
  }

  setImage(name : string){
    
    
    return this.url + '/loadImage/'+name;
  }
  getContentsArray(arr : FoodContents[]){
    var result = ''
    for(var i = 0; i<arr.length; i++){
      if(i != 0)
      {
        result += ', ' + arr[i].name;
      }else{
        result += arr[i].name;
      }
    }

    return result;
  }
  getGuaranteedAnalysisArray(arr : GuaranteedAnalysis[]){
    var result = ''

    for(var i = 0; i<arr.length; i++){
      if(i != 0)
      {
        result += ', ' + arr[i].name + ' '
        result += (arr[i].maxOrMin ? '(Max)': '(Min)');
        result += ' '+ arr[i].content;
      }else{
        result += arr[i].name + ' '
        result += (arr[i].maxOrMin ? '(Max)': '(Min)');
        result += ' '+ arr[i].content;
      }
    }

    return result;
  }
  requestDeleteItem(id){
    var headers = new Headers({});
    headers.append('Content-Type', 'application/json');
    let options = new RequestOptions({ headers });
    let url = this.url + '/deleteFoodItem/' + id;

    
    this.http.get(url, options).map(res => {
      if(res.status == 200){
        return true;
      }else{
        throw new Error('This request has failed ' + res.status); 
      }
    }).subscribe( (re) => {
      alert('success');
      this.beforeReload();
    },(err)=>{
      console.log('error');
      alert('error');
      this.beforeReload();
    });

  }
  requestEditItem(item){

    this.dataService.setItem(item);
    this.dataService.setItemType('Cat');
    this.router.navigate(['dog/edit_dog_food']);

  }
  beforeReload(){
    this.http.get(this.url + '/countFoodItems').map(res => {
      if(res.status == 200){
        return res.text();
      }else{
        throw new Error('This request has failed ' + res.status); 
      }
    }).subscribe((data) => {
      console.log(data);
      this.totalItemCount = +data;
      this.setPage(this.page_no);
    }, (err) => {
      console.log('error');
    })
  }
  setPage(page : number){
    if (page < 1 || page > this.pager.totalPages) {
            return;
    }
    this.page_no = page;
    var data = {
      'page_no' : this.page_no - 1
    };
    var headers = new Headers({});
    headers.append('Content-Type', 'application/json');
    let options = new RequestOptions({ headers });
    let url = this.url + '/loadList';

    let item_food_item;
    
    this.http.post(url, data, options).map(res => {
      if(res.status == 200){
        return res.json();
      }else{
        throw new Error('This request has failed ' + res.status); 
      }
    }).subscribe( (data) => {
      this.Items = [];
      for(var i = 0; i<data.length; i++){
        var item = new DogFoodItem();
        item.setFoodItem(data[i]);
        item.createAt = data[i].createdAt;
        item.updateAt = data[i].updatedAt;
        this.Items.push(item);
        this.ItemsStorage.push(item);
      }


    },(err)=>{
      console.log('error');
    });

    // get pager object from service
    this.pager = this.pagerService.getPager(this.totalItemCount, page);
    
  }
}

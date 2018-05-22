import { Injectable } from '@angular/core';
import {DogFoodItem} from './Item/DogFoodItem';
@Injectable()
export class DataServiceService {

  //private url = 'http://localhost:3000'
  private url = 'http://ec2-35-167-105-150.us-west-2.compute.amazonaws.com:3000'
  private item: DogFoodItem;
  private item_type: string;

  public setItemType(item : string){
    this.item_type = item;
  }
  public getItemType(){
    return this.item_type;
  }
  public setItem(item : DogFoodItem){
    this.item = item;
  }
  public getItem(){
    return this.item;
  }

  public getURL(){
    return this.url;
  }
  constructor() { }

}

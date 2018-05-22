import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';

import { AppComponent } from './app.component';
import { HeaderComponent } from './header.component';
import { DogComponent } from './dog/dog.component';
import { HomeComponent } from './home/home.component';
import { routing } from "./app.routing";
import { AddDogFoodComponent } from './dog/add-dog-food/add-dog-food.component';
import { ResultDogFoodComponent } from './dog/result-dog-food/result-dog-food.component';
import { Ng2Bs3ModalModule } from 'ng2-bs3-modal/ng2-bs3-modal';
import { DogFoodItemsComponent } from './dog-food-items.component';
import { EditDogFoodComponent } from './dog/edit-dog-food/edit-dog-food.component';
import { CatFoodItemsComponent } from './cat-food-items.component';
import { AddTreatComponent } from './treats/add-treat/add-treat.component';
import { EditTreatsComponent } from './treats/edit-treats/edit-treats.component';
import { DogTreatsItemsComponent } from './treats/dog-treats-items/dog-treats-items.component';
import { CatTreatsItemsComponent } from './treats/cat-treats-items/cat-treats-items.component';

@NgModule({
  declarations: [
    AppComponent,
    HeaderComponent,
    DogComponent,
    HomeComponent,
    AddDogFoodComponent,
    ResultDogFoodComponent,
    DogFoodItemsComponent,
    EditDogFoodComponent,
    CatFoodItemsComponent,
    AddTreatComponent,
    EditTreatsComponent,
    DogTreatsItemsComponent,
    CatTreatsItemsComponent,
    DogTreatsItemsComponent
  ],
  imports: [
    BrowserModule,
    HttpModule,
    routing,
    ReactiveFormsModule,
    Ng2Bs3ModalModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }

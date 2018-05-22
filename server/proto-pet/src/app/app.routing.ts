import { RouterModule, Routes } from "@angular/router";

import { DogComponent } from "./dog/dog.component";
import { HomeComponent } from "./home/home.component";
import { DogFoodItemsComponent } from "./dog-food-items.component";
import { EditDogFoodComponent } from "./dog/edit-dog-food/edit-dog-food.component";
import {CatFoodItemsComponent } from "./cat-food-items.component";
import { AddTreatComponent } from "./treats/add-treat/add-treat.component"
import { DogTreatsItemsComponent } from "./treats/dog-treats-items/dog-treats-items.component"
import { CatTreatsItemsComponent } from "./treats/cat-treats-items/cat-treats-items.component"
import { EditTreatsComponent } from "./treats/edit-treats/edit-treats.component"

const APP_ROUTES: Routes = [
    {path: 'home', component: HomeComponent},
    {path: 'dog', component: DogComponent},
    {path: 'dogFoodItems', component: DogFoodItemsComponent},
    {path: 'dog/edit_dog_food', component: EditDogFoodComponent},
    {path: 'catFoodItems', component: CatFoodItemsComponent},
    {path: 'treats', component: AddTreatComponent },
    {path: 'dogTreatsItems', component: DogTreatsItemsComponent },
    {path: 'catTreatsItems', component: CatTreatsItemsComponent },
    {path: 'editTreatsItems', component: EditTreatsComponent }
];

export const routing = RouterModule.forRoot(APP_ROUTES);
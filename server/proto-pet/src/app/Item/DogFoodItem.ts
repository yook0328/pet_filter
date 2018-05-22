export class DogFoodItem {
    public id : number;
    public food_name : string;
    public brand : string;
    public food_type : string;
    public description : string;
    public food_picture_name : string;
    public health_considerations : FoodContents[] = [];
    public ingredients : FoodContents[] = [];
    public nutritional_options : FoodContents[] = [];
    public guaranteedAnalysis : GuaranteedAnalysis[] = [];
    public createAt : Date;
    public updateAt : Date;

    constructor()
    {

    }

    public setFoodItem(data){
        this.id = data.id;
        this.food_name = data.food_name;
        this.brand = data.brand;
        this.food_type = data.food_type;
        this.description = data.description;
        this.food_picture_name = data.food_picture_name;


        if("ingredients" in data){
            for(var i = 0; i < data.ingredients.length; i++){
                this.ingredients.push(new FoodContents(data.ingredients[i].content_name,data.ingredients[i].id));
            }
        }
        
        // for(var i = 0; i < data.health_considerations.length; i++){
        //     this.health_considerations.push(new FoodContents(data.health_considerations[i].content_name,data.health_considerations[i].id));
        // }
        // for(var i = 0; i < data.nutritionalOptions.length; i++){
        //     this.nutritional_options.push(new FoodContents(data.nutritionalOptions[i].content_name,data.nutritionalOptions[i].id));
        // }
        if("guaranteedAnalysis" in data){
            for(var i = 0; i < data.guaranteedAnalysis.length; i++){
                this.guaranteedAnalysis.push(new GuaranteedAnalysis(data.guaranteedAnalysis[i].guaranteed_analysis_name, 
                    data.guaranteedAnalysis[i].guaranteed_analysis_maxOrmin,
                    data.guaranteedAnalysis[i].guaranteed_analysis_content,
                    data.guaranteedAnalysis[i].id));
            }  
        }
              
    }       
}
export class FoodContents {
    constructor(public name : string, public id : number){

    }
}
export class GuaranteedAnalysis{
    constructor(public name : string, public maxOrMin : boolean, public content : string, public id : number){
        
    }
}
     

var fs = require('fs');

var utils = {};

utils.checkDirectorySync = function(directory) {  
  try {
    fs.statSync(directory);
  } catch(e) {
    fs.mkdirSync(directory);
  }
}

utils.filteredIncludeFish = function(){
  filtered = []
  fishList = ["fish","salmon","pilchard","herring","flounder","cod","whiting","hake","pollock","mackerel","trout"]
  
  for(var i = 0; i < fishList.length; i++){
    filtered.push({
                    ingredients :{
                        $like: '%' + fishList[i] +'%'
                    }
                });
  }


  return {
    $or : filtered
  }
}

utils.filteredExcludeFish = function(){
  filtered = []
  fishList = ["fish","salmon","pilchard","herring","flounder","cod","whiting","hake","pollock","mackerel","trout"]
  
  for(var i = 0; i < fishList.length; i++){
    filtered.push({
                    ingredients :{
                        $notLike: '%' + fishList[i] +'%'
                    }
                });
  }


  return {
    $or : filtered
  }
}
utils.filteredData = function(data,search, brands, types ){
    var result = data;

    if(search.length > 0 )
    {

        result = data.filter(function(value){
            return value.food_name.toLowerCase().includes(search.toLowerCase()) || value.description.toLowerCase().includes(search.toLowerCase())

        })
    }
    
    if(brands.length > 0 ){

        var tmp = [];
        for(var i = 0; i < brands.length; i++){

            var tmp2 = result.filter(function(value){
                return value.brand == brands[i]
            });
            for(var j = 0; j < tmp2.length; j++){
                tmp.push(tmp2[j])
            }
        }
        result = tmp;
    }
    if(types.length > 0){

        var tmp = [];
        for(var i = 0; i < types.length; i++){

            var tmp2 = result.filter(function(value){

                return value.food_type == types[i]
            });
            for(var j = 0; j < tmp2.length; j++){
                tmp.push(tmp2[j])
            }
        }
        result = tmp;
    }

    return result;
}
utils.getFishList = function(){
  return ["fish","salmon","pilchard","herring","flounder","cod","whiting","hake","pollock","mackerel","trout"]
}

module.exports = utils;
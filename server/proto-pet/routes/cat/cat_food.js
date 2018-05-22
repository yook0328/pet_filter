var express = require('express');
var router = express.Router();
var db = require('../../db.js');
var _ = require('underscore');
var fs = require('fs');
var utils = require('../../MyUtil.js');
var datetime = require('node-datetime');
var multiparty = require('multiparty');
var path = require('path');
var mkdirp = require('mkdirp');

router.get('/countFoodItems', function(req,res){
    db.cat_food.count().then(function(count){
        result = {
            count : count
        }

        res.status(200).send(count.toString());
    }).catch(function(e){
        console.log(e);
        res.status(401).send('Error');
    })

    
});

router.get('/loadImage/:filename', function(req,res){
    var filename = req.params.filename;

    res.download('./upload/catfood/' + filename, function(err){
        if (err) {
            console.log(err);
            res.status(400).send('Error');
        } else {
            
            //res.status(200).send('Success');
            // decrement a download credit, etc.
        }
    });
});

router.post('/findFoodItems', function(req,res){
    var body = _.pick(req.body, 'page_no', 'include', 'exclude' );
    
    var exclude = body.exclude.split(',');
    var include = body.include.split(',');
    var queryIngredients = [];
    
    var send_item_number = 10;

    var isFishInclude = false;
    var isFishExclude = false;

    var checkFish = include.filter(function(value){
                    return value.toLowerCase() == 'fish'
                })
    if(checkFish.length > 0){
        isFishInclude = true;
    }

    checkFish = exclude.filter(function(value){
                    return value.toLowerCase() == 'fish'
                })
    if(checkFish.length > 0){
        isFishExclude = true;
    }
    
    if(isFishInclude){
        include = include.filter(function(value){
                    return value.toLowerCase() != 'fish'
                })
    }
    if(isFishExclude){
        exclude = exclude.filter(function(value){
                    return value.toLowerCase() != 'fish'
                })
    }

    if(exclude.length == 1 && exclude[0] == ''){

    }else{
        for(var i = 0; i< exclude.length; i++){
            if(exclude[i].includes('/')){
                var sample = exclude[i].split('/');
                for(var j = 0; j < sample.length; j++){
                    sample[j] = sample[j].trim();
                    
                    queryIngredients.push(
                        {
                            $notLike: '%'+sample[j]+'%'
                        }
                    );
                }
            }else{
                queryIngredients.push(
                    {
                        $notLike: '%'+exclude[i]+'%'
                    }
                );
            }
        }
        if(isFishExclude){
           var fishList = utils.getFishList();

           for(var i = 0; i < fishList.length; i++){
               queryIngredients.push(
                    {
                        $notLike: '%'+fishList[i]+'%'
                    }
                );
           }
        }
    }

    if(include.length == 1 && include[0] == ''){

    }else{
        for(var i = 0; i< include.length; i++){
            if(include[i].includes('/')){
                var sample = include[i].split('/');
                for(var j = 0; j < sample.length; j++){
                    sample[j] = sample[j].trim();
                    queryIngredients.push(
                        {
                            $like: '%'+sample[j]+'%'
                        }
                    );
                }
            }else{
                queryIngredients.push(
                    {
                        $like: '%'+include[i]+'%'
                    }
                );
            }
        }
    }

    if(isFishInclude){
         var fishList = utils.getFishList();
         var tmp = []
         for(var i = 0; i < fishList.length; i++){
             tmp.push({
                 $like : '%' + fishList[i] + '%'
             })
         }
         queryIngredients.push({
             $or : tmp
         });
    }

    db.cat_food.findAndCountAll({
        limit: send_item_number,
        offset: body.page_no * send_item_number,
        order: [['updatedAt', 'DESC']],
        where : {
            ingredients : {
                $and : queryIngredients
            }
        }
    })
    .then(function(result){
        var sendData = [];
        
        for(var i = 0; i < result.rows.length; i++){
            sendData.push(_.pick(result.rows[i],'food_name'
            ,'brand','id','food_type'
            ,'description'
            ,'food_picture_name','ingredients', 'updatedAt', 'createdAt' ))
        }

        var query_GA = []
        var count = result.count;

        for(var i = 0; i < sendData.length; i++)
        {
            query_GA.push({
                catFoodId : {
                    $eq: sendData[i].id
                }
            })
        }

        db.cat_guaranteed_analysis.findAll({
            where : {
                $or : query_GA
            }
        }).then(function(result){

            GA_result = []
            for(var i = 0; i < result.length; i++){

                GA_result.push(_.pick(result[i], "guaranteed_analysis_name","guaranteed_analysis_content",
                "guaranteed_analysis_maxOrmin","catFoodId"));
            }     
                 
            for(var i = 0; i < sendData.length; i++){
                sendData[i]["GA"] = GA_result.filter(function(value){
                    return value.catFoodId == sendData[i].id
                })
            }

            var _send = {
                count : count,
                data : sendData
            }
            res.status(200).json(_send);

        }).catch(function(e){
            res.status(400).send('Error');
        })
    }).catch(function(e){
        console.log(e);
        res.status(400).send('Error');
    })





})
router.post('/findFilteredFoodItems', function(req,res){

    var body = _.pick(req.body, 'page_no','include', 'exclude', 'brands','search','types' );
    
    var exclude = body.exclude.length > 0 ? body.exclude.split(',') : [];
    var include = body.include.length > 0 ? body.include.split(',') : [];
    
    var search = body.search
    var brands = body.brands.length > 0 ? body.brands.split(',') : [];
    var types = body.types.length > 0 ? body.types.split(',') : [];
    
    var queryIngredients = [];
    
    var send_item_number = 10;

    var isFishInclude = false;
    var isFishExclude = false;

    
    var checkFish = include.filter(function(value){
                    return value.toLowerCase() == 'fish'
                })
    if(checkFish.length > 0){
        isFishInclude = true;
    }

    checkFish = exclude.filter(function(value){
                    return value.toLowerCase() == 'fish'
                })
    if(checkFish.length > 0){
        isFishExclude = true;
    }
    
    if(isFishInclude){
        include = include.filter(function(value){
                    return value.toLowerCase() != 'fish'
                })
    }
    if(isFishExclude){
        exclude = exclude.filter(function(value){
                    return value.toLowerCase() != 'fish'
                })
    }


    for(var i = 0; i< exclude.length; i++){
        if(exclude[i].includes('/')){
            var sample = exclude[i].split('/');
            for(var j = 0; j < sample.length; j++){
                sample[j] = sample[j].trim();
                
                queryIngredients.push(
                    {
                        $notLike: '%'+sample[j]+'%'
                    }
                );
            }
        }else{
            queryIngredients.push(
                {
                    $notLike: '%'+exclude[i]+'%'
                }
            );
        }
    }
    if(isFishExclude){
        var fishList = utils.getFishList();

        for(var i = 0; i < fishList.length; i++){
            queryIngredients.push(
                {
                    $notLike: '%'+fishList[i]+'%'
                }
            );
        }
    }
    for(var i = 0; i< include.length; i++){
        if(include[i].includes('/')){
            var sample = include[i].split('/');
            for(var j = 0; j < sample.length; j++){
                sample[j] = sample[j].trim();
                queryIngredients.push(
                    {
                        $like: '%'+sample[j]+'%'
                    }
                );
            }
        }else{
            queryIngredients.push(
                {
                    $like: '%'+include[i]+'%'
                }
            );
        }
    }
    if(isFishInclude){
         var fishList = utils.getFishList();
         var tmp = []
         for(var i = 0; i < fishList.length; i++){
             tmp.push({
                 $like : '%' + fishList[i] + '%'
             })
         }
         queryIngredients.push({
             $or : tmp
         });
    }

    queryIngredients = {
        ingredients : {
            $and : queryIngredients
        }
    }

    var querySearch = {}
    if(search.length > 0){
        querySearch = {
            $or : [{
                food_name : {
                    $like : '%' + search + '%'
                }
            },{
                description : {
                    $like : '%' + search + '%'
                }
            }]
        }
    }
    var queryBrands = {}
    if(brands.length > 0 ){
        var tmp = []

        for(var i = 0; i < brands.length; i++){
            tmp.push({
                $eq : brands[i]
            });
        }
        queryBrands = {
            brand : {
                $or : tmp
            }
        }
    }
    var queryTypes = {}
    if(types.length > 0 ){
        var tmp = []

        for(var i = 0; i < types.length; i++){
            tmp.push({
                $eq : types[i]
            });
        }
        queryTypes = {
            food_type : {
                $or : tmp
            }
        }
    }
    
    db.cat_food.findAndCountAll({
        limit: send_item_number,
        offset: body.page_no * send_item_number,
        order: [['updatedAt', 'DESC']],
        where : {
            $and : [
                queryIngredients,queryBrands,querySearch,queryTypes
            ]
        }
    })
    .then(function(result){
        var sendData = [];
        
        for(var i = 0; i < result.rows.length; i++){
            sendData.push(_.pick(result.rows[i],'food_name'
            ,'brand','id','food_type'
            ,'description'
            ,'food_picture_name','ingredients', 'updatedAt', 'createdAt' ))
        }

        var query_GA = []
        var count = result.count;

        for(var i = 0; i < sendData.length; i++)
        {
            query_GA.push({
                catFoodId : {
                    $eq: sendData[i].id
                }
            })
        }

        db.cat_guaranteed_analysis.findAll({
            where : {
                $or : query_GA
            }
        }).then(function(result){

            GA_result = []
            for(var i = 0; i < result.length; i++){

                GA_result.push(_.pick(result[i], "guaranteed_analysis_name","guaranteed_analysis_content",
                "guaranteed_analysis_maxOrmin","catFoodId"));
            }     
                 
            for(var i = 0; i < sendData.length; i++){
                sendData[i]["GA"] = GA_result.filter(function(value){
                    return value.catFoodId == sendData[i].id
                })
            }
            var _send = {
                count : count,
                data : sendData
            }
            
            res.status(200).json(_send);

        }).catch(function(e){
            res.status(400).send('Error');
        })
    }).catch(function(e){
        console.log(e);
        res.status(400).send('Error');
    })
    
});
router.get('/deleteFoodItem/:foodId', function(req,res){
    var foodId = req.params.foodId;

    var fullpath = path.join(__dirname,'../../upload/catfood/');


    db.cat_food.findById(foodId).then(function(data){
            fs.unlinkSync(fullpath+data.food_picture_name);
            var d02 = function(){
                return Promise.resolve(db.cat_ingredients.destroy({
                    where : {catFoodId: foodId}
                }));
            }
            var d03 = function(){
                return Promise.resolve(db.cat_nutritional_option.destroy({
                    where : {catFoodId: foodId}
                }))
            }
            var d04 = function(){
                return Promise.resolve(db.cat_health_consideration.destroy({
                        where : {catFoodId: foodId}
                }));
            }
            var d05 = function(){
                return Promise.resolve(db.cat_guaranteed_analysis.destroy({
                    where : {catFoodId: foodId}
                }));
            }
            Promise.all([, d02(), d03(), d04(), d05()]).then(function(result){
                return Promise.resolve(db.cat_food.destroy({
                    where : {id : foodId }
                }))
                
            }).then(function(result){
                res.status(200).send('Success');
            })
            .catch(function(e){
                console.log(e);
                res.status(401).send('Error');
            })
               
    }).catch(function(e){
        console.log(e);
        res.status(401).send('Error');
    })
});
router.post('/loadList', function(req, res){

    var body = _.pick(req.body, 'page_no');
    var send_data_set = Array();
    
    db.cat_food.findAll({
        limit: 5,
        offset: body.page_no * 5,
        order: [['updatedAt', 'DESC']]
    }).then(function(data_set){
        var promisGroup = [];
        for(var i = 0; i < data_set.length; i++){
            send_data_set.push(_.pick(data_set[i],'food_name'
                ,'brand','id','food_type'
                ,'description'
                ,'food_picture_name', 'updatedAt', 'createdAt' ));
            promisGroup.push(db.cat_ingredients.findAll({where:{
                catFoodId : data_set[i].id
            }}));
            promisGroup.push(db.cat_health_consideration.findAll({where:{
                catFoodId : data_set[i].id
            }}));
            promisGroup.push(db.cat_nutritional_option.findAll({where:{
                catFoodId : data_set[i].id
            }}));
            promisGroup.push(db.cat_guaranteed_analysis.findAll({where:{
                catFoodId : data_set[i].id
            }}));
        }
        
        Promise.all(promisGroup).then(function(result){

            for(var i = 0; i<result.length; i++){
                switch(i%4){
                    
                    case 0:
                        send_data_set[parseInt(i/4)].ingredients = getIngredients(result[i]);
                        break;
                    case 1:
                        send_data_set[parseInt(i/4)].health_considerations = getHealthConsideration(result[i]);
                        break;
                    case 2:
                        send_data_set[parseInt(i/4)].nutritionalOptions = getNutritionalOption(result[i]);
                        break;
                    case 3:
                        send_data_set[parseInt(i/4)].guaranteedAnalysis = getGuaranteedAnalysis(result[i]);
                        break;
                }
            }
            res.status(200).json(send_data_set);
        }).catch(function(e){
            console.log(e);
            res.status(400).send('Error');
        })
    }).catch(function(e){
        console.log(e);
        res.status(400).send('Error');
    })
});
function getIngredients(data){
    var result = Array();
    for(var i = 0; i < data.length; i++){
        result.push(_.pick(data[i], 'id', 'content_name'));
    }
    return result;
}
function getHealthConsideration(data){
    var result = Array();
    for(var i = 0; i < data.length; i++){
        result.push(_.pick(data[i], 'id', 'content_name'));
    }
    return result;
}
function getGuaranteedAnalysis(data){
    var result = Array();
    for(var i = 0; i < data.length; i++){
        result.push(_.pick(data[i], 'id', 'guaranteed_analysis_name', 'guaranteed_analysis_content','guaranteed_analysis_maxOrmin'));
    }
    return result;
}
function getNutritionalOption(data){
    var result = Array();
    for(var i = 0; i < data.length; i++){
        result.push(_.pick(data[i], 'id', 'content_name'));
    }
    return result;
}


router.get('/get_ingredients', function(req,res){

    db.cat_ingredients.aggregate('content_name', 'DISTINCT', { plain : false })
    .then(function(data){
        var result = '';
        for(var i = 0; i < data.length; i++){
            if(i != 0){
                result += ',' + data[i].DISTINCT;
            }else{
                result += data[i].DISTINCT;
            }
        }
        res.status(200).send(result);
    }).catch(function(e){
        console.log(e);
        res.status(401).send('Error');
    })
});

router.get('/get_brands', function(req,res){

    db.cat_food.aggregate('brand', 'DISTINCT', { plain : false })
    .then(function(data){
        var result = '';
        for(var i = 0; i < data.length; i++){
            if(i != 0){
                result += ',' + data[i].DISTINCT;
            }else{
                result += data[i].DISTINCT;
            }
        }
        res.status(200).send(result);
    }).catch(function(e){
        console.log(e);
        res.status(401).send('Error');
    })
});

module.exports = router;
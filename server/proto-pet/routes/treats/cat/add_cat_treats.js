var express = require('express');
var router = express.Router();
var db = require('../../../db.js');
var _ = require('underscore');
var fs = require('fs');
var utils = require('../../../MyUtil.js');
var datetime = require('node-datetime');
var multiparty = require('multiparty');
var path = require('path');
var mkdirp = require('mkdirp');


router.post('/', function(req,res){
    var form = new multiparty.Form();
    var savedata = {};

    var dt = datetime.create();
    var filename;
    savedata.path = '../../../upload/cattreats/';
    var fullpath = path.join(__dirname,savedata.path)
    
      

      // get field name & value
      form.on('field',function(name,value){
           //console.log('normal field / name = '+name+' , value = '+value);
           savedata[name] = value;
      });
      form.on('error', function(err) {
		  console.log('Error parsing form: ' + err.stack);
          //error 처리 할 것. 
		});

	

     
      // file upload handling
      form.on('part',function(part){
           
           var size;
           if (part.filename) {
                 //filename = part.filename;
                 
                 filename = dt.format('ymdHMS')+'.jpeg';
                 
                 size = part.byteCount;
           }else{
                 part.resume();
          
           }    
 
           //console.log("Write Streaming file :"+filename);
           
           //utils.checkDirectorySync(savedata.path);
           
           var writeStream = fs.createWriteStream(fullpath+filename);
           writeStream.filename = filename;
           part.pipe(writeStream);
 
           part.on('data',function(chunk){
                // console.log(filename+' read '+chunk.length + 'bytes');
           });
          
           part.on('end',function(){
                 //console.log(filename+' Part read complete');
                 savedata.filename = filename;
                 writeStream.end();

           });
           part.on('error', function(err){
               //error처리할것
           });
      });
 	
      // all uploads are completed
      form.on('close',function(){
      		
          	//console.log(savedata);
          	var row = {
          		food_name:savedata.foodname,
                brand:savedata.brand,
          		food_type: savedata.foodType,
                description: savedata.description,
                food_picture_name: filename,
                ingredients: savedata.ingredients
          	};
            var catId;

            db.cat_treats.create(row).then(function(food_data){
                catId=food_data.id;

                savedata.ingredients.split(',').reduce(function(p, ing) {
                        return p.then(function() {
                              return db.cat_treats_ingredients.create({ content_name: ing, catTreatId: catId });
                        });
                  }, Promise.resolve())
                  .then(function(){
                    var guaranteedAnalysis = JSON.parse(savedata.guaranteedAnalysis);
                    guaranteedAnalysis.reduce(function(p,data){
                            return p.then(function() {
                                var d = {
                                        guaranteed_analysis_name : data.name,
                                        guaranteed_analysis_content : data.content,
                                        guaranteed_analysis_maxOrmin : data.maxOrMin,
                                        catTreatId: catId
                                }
                                return db.cat_treats_guaranteed_analysis.create(d);
                            })
                    },Promise.resolve())
                    .then(function(){
                            /////
                            // 여기서 완료!!
                            res.status(200).send('OK');
                    })
                    .catch(function(e){
                            console.log(e);
                            deleteData(catId,fullpath+filename);
                            
                            res.status(401).send('Error');
                    });
                  })
                  .catch(function(e){
                      console.log(e);
                        deleteData(catId,fullpath+filename);
                        res.status(401).send('Error');
                  })
            })
            .catch(function(e){
                console.log(e);
                res.status(401).send('Error')
                fs.unlinkSync(fullpath+filename);
            })            
            
            
            

      });
     
      // track progress
      form.on('progress',function(byteRead,byteExpected){
           //console.log(' Reading total  '+byteRead+'/'+byteExpected);
      });
     
      form.parse(req);

});

function  deleteData(id, deletefile){
      db.cat_health_consideration.destroy({
            where: {
                  catTreatId : id
            }
      });
      db.cat_ingredients.destroy({
            where: {
                  catTreatId : id
            }
      });
      db.cat_nutritional_option.destroy({
            where: {
                  catTreatId : id
            }
      });
      db.cat_guaranteed_analysis.destroy({
            where: {
                  catTreatId : id
            }
      });
      db.cat_food.destroy({
            where: {
                  id : id
            }
      });
      fs.unlinkSync(deletefile);
} 

module.exports = router;
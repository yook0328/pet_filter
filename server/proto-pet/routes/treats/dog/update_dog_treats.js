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

router.post('/image', function(req,res){
    var form = new multiparty.Form();
    var savedata = {};
    

    var dt = datetime.create();
    var filename;
    savedata.path = '../../../upload/dogtreats/';
    var fullpath = path.join(__dirname,savedata.path)

    

    form.on('field',function(name,value){
           //console.log('normal field / name = '+name+' , value = '+value);
           savedata[name] = value;
    });

    form.on('error', function(err) {
		  console.log('Error parsing form: ' + err.stack);
          //error 처리 할 것. 
          res.status(401).send('Error');
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


    form.on('close',function(){
        //console.log(savedata);
       

        
        
        var f01 = function(){
            return Promise.resolve(
                db.dog_treats.findById(savedata.id).then(function(data){
                    fs.unlinkSync(fullpath+data.food_picture_name);
                    return true;    
            }))
        }
        Promise.all([f01()]).then(function(result){
            var row = {
          		food_name:savedata.foodname,
                brand:savedata.brand,
          		food_type: savedata.foodType,
                description: savedata.description,
                food_picture_name: filename,
                ingredients: savedata.ingredients
          	};
            var p01 = function(){
                return Promise.resolve(db.dog_treats.update(row,
                    {
                        where : {id: savedata.id}
                    }));
            }
            
            var delete01 = function(){
                return Promise.resolve(db.dog_treats_ingredients.destroy({
                    where : {dogTreatId: savedata.id}
                }));
            }
            var delete04 = function() {
                return Promise.resolve(db.dog_treats_guaranteed_analysis.destroy({
                    where : {dogTreatId: savedata.id}
                }));
            }

            Promise.all([p01(), delete01(),  delete04() ]).then(function(result){
                
                var func01 = function() {
                    var guaranteedAnalysis = JSON.parse(savedata.guaranteedAnalysis);
                    return guaranteedAnalysis.reduce(function(p,data){
                            return p.then(function() {
                                var d = {
                                        guaranteed_analysis_name : data.name,
                                        guaranteed_analysis_content : data.content,
                                        guaranteed_analysis_maxOrmin : data.maxOrMin,
                                        dogTreatId: savedata.id
                                }
                                return db.dog_treats_guaranteed_analysis.create(d);
                            })
                    },Promise.resolve())
                }

                var func04 = function(){
                        return savedata.ingredients.split(',').reduce(function(p, ing) {
                            return p.then(function() {
                                    return db.dog_treats_ingredients.create({ content_name: ing, dogTreatId: savedata.id });
                            });
                        }, Promise.resolve())
                };

                Promise.all([func01(), func04()]).then(function(result){
                    res.status(200).send('Success');
                }).catch(function(e){
                    console.log(e);
                    res.status(401).send('Error');
                });

            }).catch(function(e){
                console.log(e);
                res.status(401).send('Error');
            })    
        }).catch(function(e){
            
        })
          
    });

    form.on('progress',function(byteRead,byteExpected){
           //console.log(' Reading total  '+byteRead+'/'+byteExpected);
      });
     
    form.parse(req);
});
router.post('/', function(req,res){

    var form = new multiparty.Form();
    var savedata = {};
    
    form.on('field',function(name,value){
           //console.log('normal field / name = '+name+' , value = '+value);
           savedata[name] = value;
    });

    form.on('error', function(err) {
		  console.log('Error parsing form: ' + err.stack);
          //error 처리 할 것. 
          res.status(401).send('Error');
	});

    form.on('close',function(){
        //console.log(savedata);
       var row = {
          		food_name:savedata.foodname,
                brand:savedata.brand,
          		food_type: savedata.foodType,
                description: savedata.description,
                ingredients: savedata.ingredients
          	};
        
        var p01 = function(){
            return Promise.resolve(db.dog_treats.update(row,
                {
                    where : {id: savedata.id}
                }));
        }
        
        var delete01 = function(){
            return Promise.resolve(db.dog_treats_ingredients.destroy({
                where : {dogTreatId: savedata.id}
            }));
        }
        var delete04 = function() {
            return Promise.resolve(db.dog_treats_guaranteed_analysis.destroy({
                        where : {dogTreatId: savedata.id}
                    }))
        }

        

        Promise.all([p01(), delete01(), delete04()]).then(function(result){
            
            var func01 = function() {
                var guaranteedAnalysis = JSON.parse(savedata.guaranteedAnalysis);
                return guaranteedAnalysis.reduce(function(p,data){
                        return p.then(function() {
                            var d = {
                                    guaranteed_analysis_name : data.name,
                                    guaranteed_analysis_content : data.content,
                                    guaranteed_analysis_maxOrmin : data.maxOrMin,
                                    dogTreatId: savedata.id
                            }
                            return db.dog_treats_guaranteed_analysis.create(d);
                        })
                },Promise.resolve())
            }
            var func04 = function(){
                    return savedata.ingredients.split(',').reduce(function(p, ing) {
                        return p.then(function() {
                                return db.dog_treats_ingredients.create({ content_name: ing, dogTreatId: savedata.id });
                        });
                    }, Promise.resolve())
            };

            Promise.all([func01(), func04()]).then(function(result){
                res.status(200).send('Success');
            }).catch(function(e){
                console.log(e);
                res.status(401).send('Error');
            });

        }).catch(function(e){
            console.log(e);
            res.status(401).send('Error');
        })    
    });

    form.on('progress',function(byteRead,byteExpected){
           //console.log(' Reading total  '+byteRead+'/'+byteExpected);
      });
     
    form.parse(req);

});
module.exports = router;
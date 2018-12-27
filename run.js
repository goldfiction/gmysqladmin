var o={};
var gqcoffee=require("gqcoffee");
gqcoffee.load(o,function(e,o){
    o.functions=o.result;
    o.functions.gqcoffee=gqcoffee;
    main=gqcoffee.requireFromString(o.functions["coffee/main"]);
    main.main(o,function(e,o){
        console.log("All done.");
    })
});
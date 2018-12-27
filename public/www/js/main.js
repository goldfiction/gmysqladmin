function get(){
    saveState();
    var data=JSON.parse($("#query").val());
    data.connection=JSON.parse($("#connection").val());
    $.post( "/query", data)
        .done(function( data ) {
            $('#result').val(JSON.stringify(JSON.parse(data),null,2))
        });
}

function del(){
    saveState();
    var data=JSON.parse($("#query").val());
    data.connection=JSON.parse($("#connection").val());
    $.ajax({
        url: '/query',
        type: 'DELETE',
        data: data,
        success: function(data) {
            $('#result').val(JSON.stringify(JSON.parse(data),null,2))
        }
    });
}

function upsert(){
    saveState();
    var data=JSON.parse($("#query").val());
    data.connection=JSON.parse($("#connection").val());

    $.ajax({
        url: '/query',
        type: 'PUT',
        data: data,
        success: function(data) {
            $('#result').val(JSON.stringify(JSON.parse(data),null,2))
        }
    });
}

function saveState(){
    Cookies.set('query', $("#query").val());
    Cookies.set('connection', $("#connection").val());
}

function restoreState(){
    try{
        if(Cookies.get('query').trim())
            $("#query").val(Cookies.get('query'));
    }catch(e){}
    try{
        if(Cookies.get('connection').trim())
            $("#connection").val(Cookies.get('connection'));
    }catch(e){}
}


$(document).ready(function(){
    restoreState();
});
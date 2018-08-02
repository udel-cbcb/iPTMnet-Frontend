'use strict';

// Require index.html so it gets copied to dist
require('./index.html');
const Mark = require('mark.js');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

// .embed() can take an optional second argument. This would be an object describing the data we need to start a program, i.e. a userID or some token
var app = Elm.Main.embed(mountNode);

app.ports.scrollToDiv.subscribe(function (element_name) {
    document.getElementById(element_name).scrollIntoView();
});

app.ports.highlight.subscribe(function (word) {
    setTimeout(()=>{
        var context = document.getElementById("search_table");
        var instance = new Mark(context);
        instance.mark(word);
    },1000);
});

/**
 * 0 - NotAsked
 * 1 - Loading
 * 2 - Success
 * 3 - Error
 */
app.ports.performSearch.subscribe(function (url) {
    try{
        const request = new XMLHttpRequest();
        request.open("GET", url);
        request.onreadystatechange=(e)=>{
            if(request.readyState == XMLHttpRequest.LOADING){
                var searchData = {
                    status: 1,
                    error: "",
                    count: 10,
                    data: []
                }
                app.ports.onSearchDone.send(searchData);
            }
            else if(request.readyState == XMLHttpRequest.DONE ){
                if (request.status == 200) {
                    var searchData = {
                        status : 2,
                        error : "",
                        count: 10,
                        data: JSON.parse(request.responseText)
                    }
                    app.ports.onSearchDone.send(searchData);
                }else{
                    var searchData = {
                        status : 3,
                        error : request.responseText,
                        count: 10,
                        data: []
                    }
                    app.ports.onSearchDone.send(searchData);
                }
                
            }
        }
        request.send();
    }catch(err){
        var searchData = {
            status: 3,
            error: err.message,
            count: 10,
            data: []
        }
        app.ports.onSearchDone.send(searchData);
    }
});



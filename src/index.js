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
        console.log(word);
        var context = document.getElementById("search_table");
        var instance = new Mark(context);
        instance.mark(word);
    },1000);
});

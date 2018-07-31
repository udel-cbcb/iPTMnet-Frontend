const merge = require('webpack-merge');
const UglifyJSPlugin = require('uglifyjs-webpack-plugin');
const common = require('./webpack.common.js');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = merge(common, {
   mode : "production",
   plugins: [
     new UglifyJSPlugin(),
     new CopyWebpackPlugin([
        {from:'images',to:'images'} 
     ]),
     new CopyWebpackPlugin([
      {from:'fonts',to:'fonts'} 
     ]),
   ]
});

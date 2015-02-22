//= require cocoon
//= require webshims/polyfiller
webshims.setOptions('basePath', '/webshims/shims/');
webshims.setOptions('forms-ext', {types: 'date'});
webshims.polyfill('forms forms-ext');
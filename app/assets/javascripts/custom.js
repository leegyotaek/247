//= require cocoon
//= require webshims/polyfiller
webshims.setOptions('basePath', '/webshims/shims/');
webshims.setOptions('waitready', false);
webshims.setOptions('forms-ext', {types: 'date'});
webshims.polyfill('forms forms-ext');
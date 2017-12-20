var mapnik = require('mapnik');
var fs = require('fs');

mapnik.Logger.setSeverity(mapnik.Logger.DEBUG);

// register fonts and datasource plugins
mapnik.register_default_fonts();
mapnik.register_default_input_plugins();

var map = new mapnik.Map(1000, 1000);
var file = Date.now() + '.png'

map.load('./pg.xml', function(err,map) {
    if (err) throw err;
    map.zoomAll();
    var im = new mapnik.Image(1000, 1000);
    map.render(im, function(err,im) {
	if (err) throw err;
	im.encode('png', function(err,buffer) {
            if (err) throw err;
            fs.writeFile('/tmp/' + file, buffer, function(err) {
		if (err) throw err;
		console.log(file);
            });
	});
    });
});

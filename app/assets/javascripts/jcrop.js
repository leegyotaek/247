var jcrop = function(){
	$('#cropbox').Jcrop({
		setSelect : [0,0,100,100],
		aspectRatio:1,
		onSelect: update,
		onChange: update
	});
}

function update(coords){
	$('#user_crop_x').val(coords.x);
	$('#user_crop_y').val(coords.y);
	$('#user_crop_w').val(coords.w);
	$('#user_crop_h').val(coords.h);
}
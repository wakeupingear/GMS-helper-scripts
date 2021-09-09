//array
function array_combine(arr1,arr2,pos){
	var _len1=array_length(arr1);
	var _len2=array_length(arr2);
	if is_undefined(pos) pos=_len1;
	var newArr=array_create(_len1+_len2,);
	var pos1=0;
	for (var i=0;i<_len1+_len2;i++)
	{
		if i==pos 
		{
			while i-pos<_len2
			{
				newArr[i]=arr2[i-pos];
				i++;
			}
			i--;
		}
		else {
			newArr[i]=arr1[pos1];
			pos1++;
		}
	}
	return newArr;
}

function array_pos(array,val){
	for (var i=0;i<array_length(array);i++) if array[i]==val return i;
	return -1;
}

//structs
function addToStruct(originalStruct,addStruct){
	var _n=variable_struct_get_names(addStruct);
	for (var i=0;i<array_length(_n);i++)
	{
		originalStruct[$ _n[i]]=addStruct[$ _n[i]];
	}
	return originalStruct;
}

//objects
function destroyArray(arr,flag){
	if is_undefined(flag) flag=true;
	for (var i=0;i<array_length(arr);i++)
	{
		if instance_exists(arr[i]) instance_destroy(arr[i],flag);
	}
}
function destroyRadius(xPos,yPos,obj,radius,flag){
	with obj if within(xPos,yPos,radius) instance_destroy(id,flag);
}
function isObj(_id,obj){
	return _id.object_index==obj||object_is_ancestor(_id.object_index,obj);
}
function isInRange(_x,_y){
	_x-=sprite_get_xoffset(sprite_index);
	_y-=sprite_get_yoffset(sprite_index);
	return !((_x+sprite_width<camX()||_x>camX()+384)||(_y+sprite_height<camY()||_y>camY()+216));
}
function within(xPos,yPos,radius){
	return point_distance(x,y,xPos,yPos)<=radius
}

//string
function explodeString(del,str)
{
    var arr;
   str+=del;
    var len = string_length(del);
    var ind = 0;
    repeat (string_count(del, str)) {
        var pos = string_pos(del, str) - 1;
        arr[ind] = string_copy(str, 1, pos);
        str = string_delete(str, 1, pos + len);
        ind++;
    }
    return arr;
}
function listString(list)
{
	var _str="{";
	for (var i=0;i<ds_list_size(list);i++)
	{
		if i>0 _str+=", ";
		var _val=list[|i];
		if is_string(_val) _str+=_val;
		else if is_real(_val) _str+=string(_val);
	}
	return _str+"}";
}
function string_set(str,newstr,pos){
	str=string_delete(str,pos,1);
	return string_insert(newstr,str,pos);
}
function string_contains(str,substr){
	return string_pos(substr,str)>0;
}

//debug
function printCoords(_x,_y){
	show_debug_message("X: "+string(_x)+"; Y: "+string(_y));
}
function printList(list){
	str="[";
	if is_array(list) var _l=array_length(list);
	else var _l=ds_list_size(list);
	for (var i=0;i<_l;i++)
	{
		if is_array(list) var _val=list[i];
		else var _val=list[|i];
		if is_real(_val) str+=string(_val);
		else if is_array(_val) str=printList(_val);
		else str+=_val;
		if (i<_l-1) str+=", ";
	}
	str+="]";
	return str;
}

//controller
function gp_anykey(slot){
	for (var i=gp_face1; i<gp_axisrv;i++) if gamepad_button_check(slot,i) return true;
	return false;
}

//bitwise
function roundToZero(num){
	num|=0;
	return num;
}

//text
function draw_text_outline(x,y,text,outlineThickness,outlineQuality){
	if is_undefined(outlineThickness) outlineThickness=8;
	if is_undefined(outlineQuality) outlineQuality=10;
	draw_text_outline_transformed_color(x,y,text,c_nearWhite,c_nearWhite,1,c_nearBlack,c_nearBlack,1,outlineThickness,outlineQuality,1,1,0);
}

function draw_text_outline_transformed_color(x, y, text, textColor1, textColor2, textAlpha, outlineColor1, outlineColor2, outlineAlpha, outlineThickness, outlineQuality, xscale, yscale, angle){
	for (var i = 0; i < 360; i += 360 / outlineQuality){
    draw_text_transformed_color(x + lengthdir_x(outlineThickness, i), y + lengthdir_y(outlineThickness, i), string(text), xscale, yscale, angle, outlineColor1, outlineColor1, outlineColor2, outlineColor2, textAlpha);
}
draw_text_transformed_color(x, y, string(text), xscale, yscale, angle, textColor1, textColor1, textColor2, textColor2, textAlpha);
}

//collision
function createCollisionMask(){
	var _hit=instance_create_depth(x,y,depth,hitobj);
	_hit.sprite_index=sprite_index;
	_hit.image_index=image_index;
	_hit.image_angle=image_angle;
	_hit.image_xscale=image_xscale;
	_hit.image_yscale=image_yscale;
	return _hit;
}

//alarms
function pauseAlarms(upToIncluding){
	for (var i=0;i<=upToIncluding;i++) if alarm[i]>0 alarm[i]++;
}

function alarmsActive(start,endInc){
	for (var i=start;i<=endInc;i++) if alarm[i]>-1 return true;
	return false;
}

//shaders
function setTextureBlendmode(){ //just for reference
	gpu_set_blendmode_ext(bm_dest_alpha, bm_inv_src_alpha);
}























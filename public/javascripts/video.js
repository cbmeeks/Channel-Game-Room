var index = video_id;
var current_video;

$(function(){

	$("#prevVideo #nextVideo").click(function(e) {
		e.preventDefault();
	});
	
	$.getJSON( "/games/" + game_id + "/videos.json", function(videos) {

		if( index < 0 || index >= videos.length )
			index = 0;

		current_video = videos[index];		
		showVideoInfo(videos);
		
		$("#prevVideo").live("click", function() {
			changeChannelDown(videos);
			showVideoInfo(videos);
			return false;
		});
		
		$("#nextVideo").live("click", function() {
			changeChannelUp(videos);
			showVideoInfo(videos);
			return false;
		});
		
		console.log(videos);
		
	});



	$("#likeVideo").click(function() {
		$.ajax({
			contentType: "application/json",
			data: '{"game_id":' + game_id + ',"videolink_id":' + current_video["videolink"]["id"] + ',"like_type":"videolink"}',
			dataType: "json",
			processData: false,
			type: "POST",
			url: "/likes/" + game_id,
			success: function(data) {

			}
		});		

		return false;
	});

	$("#likeGame").click(function() {
		$.ajax({
			contentType: "application/json",
			data: '{"game_id":' + game_id + ',"videolink_id":' + current_video["videolink"]["id"] + ',"like_type":"game"}',
			dataType: "json",
			processData: false,
			type: "POST",
			url: "/likes/" + game_id,
			success: function(data) {

			}
		});		

		return false;
	});



});

function changeChannelDown(videos) {
	var max = videos.length - 1;

	if( index > 0 ){
		index--;
		showVideo(videos[index]);
	} else {
		index = max;
		showVideo(videos[index]);
	}
}


function changeChannelUp(videos) {
	var max = videos.length - 1;

	if( index < max ){
		index++;
		showVideo(videos[index]);
	} else {
		index = 0;
		showVideo(videos[index]);
	}
}


function showVideo(video) {
	$("#video").html( video["videolink"]["url_html"] );
	current_video = video;
}

function showVideoInfo(videos) {
	if( videos.length > 0 )
		$("#video_info").html("Video " + (index + 1) + " of " + videos.length);
	else
		$("#video_info").html("No videos added");
}



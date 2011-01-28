var index = 0;

$(function(){

	$("#prevVideo #nextVideo").click(function(e) {
		e.preventDefault();
	});
	

	$.getJSON( "/games/" + game_id + "/videos.json", function(videos) {
		
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
	$("#video").html( video["videolink"]["url_html"]);
}

function showVideoInfo(videos) {
	if( videos.length > 0 )
		$("#video_info").html("Video " + (index + 1) + " of " + videos.length);
	else
		$("#video_info").html("No videos added");
}



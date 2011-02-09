var index = video_id;
var current_video;

$(function(){

	$("#prevVideo #nextVideo").click(function(e) {
		e.preventDefault();
	});
	
	$.getJSON( "/games/" + game_id + "/videos.json", function(videos) {

		if( videos["Status"] == "OK" && videos["number_of_videolinks"] > 0 ) {

			if( index < 0 || index >= videos.length )
				index = 0;

			current_video = videos["videolinks"][index];		
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

		}		
		
	});



	$("#likeVideo,#likeGame").click(function() {
		var self = this;
		var id, like_type;
		
		if( self.id == "likeVideo" ) {
			like_type = "Videolink";
			id = current_video["id"];
		}
		else if ( self.id == "likeGame" ) {
			like_type = "Game";
			id = game_id;
		}
		
		$.ajax({
			contentType: "application/json",
			data: '{"id":' + id + ',"like_type":"' + like_type + '"}',
			dataType: "json",
			processData: false,
			type: "POST",
			url: "/likes/it",
			success: function(data) {
				console.log(data);
			}
		});		

		return false;
	});




});

function changeChannelDown(videos) {
	var max = videos["number_of_videolinks"] - 1;

	if( index > 0 ){
		index--;
		showVideo(videos["videolinks"][index]);
	} else {
		index = max;
		showVideo(videos["videolinks"][index]);
	}
}


function changeChannelUp(videos) {
	var max = videos["number_of_videolinks"] - 1;
	
	if( index < max ){
		index++;
		showVideo(videos["videolinks"][index]);
	} else {
		index = 0;
		showVideo(videos["videolinks"][index]);
	}
}


function showVideo(video) {
	$("#video").html( video["url_html"] );
	current_video = video;
}

function showVideoInfo(videos) {
	if( videos["number_of_videolinks"] > 0 )
		$("#video_info").html("Video " + (index + 1) + " of " + videos["number_of_videolinks"]);
	else
		$("#video_info").html("No videos added");
}



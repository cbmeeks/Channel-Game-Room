var index = video_id;
var current_video;
var video_links;

$(function(){

	$("#prevVideo #nextVideo").click(function(e) {
		e.preventDefault();
	});
	
	$.getJSON( "/games/" + game_id + "/videos.json", function(videos) {
		if( videos["Status"] == "OK" ) {

			if( videos["liked"] == 1 )
				$("#likeGame").addClass("gameLiked");
			if( videos["liked"] == -1 )
				$("#hateGame").addClass("gameHated");

			if( videos["number_of_videolinks"] > 0 ) {
				if( index < 0 || index >= videos.length )	index = 0;

				current_video = videos["videolinks"][index];
				video_links = videos["videolinks"];
				showVideoInfo(videos["number_of_videolinks"]);
		
				$("#prevVideo").live("click", function() {
					changeChannelDown(videos);
					showVideoInfo(videos["number_of_videolinks"]);
					return false;
				});
		
				$("#nextVideo").live("click", function() {
					changeChannelUp(videos);
					showVideoInfo(videos["number_of_videolinks"]);
					return false;
				});
				
				if( video_links[0]["liked"] == 1 ){
					$("#likeVideo").addClass("videoLiked");
					$("#hateVideo").removeClass("videoHated");
				} else if ( video_links[0]["liked"] == -1 ) {
					$("#likeVideo").removeClass("videoLiked");
					$("#hateVideo").addClass("videoHated");
				}

				$("#video .youtube-player").attr({"width":"100%", "height":"700px"});
			}
		}
	});

	$("#likeVideo,#likeGame").click(function() {
		var self = this;
		var like;
	
		if( self.id == "likeVideo" )
			like = { id: current_video["id"], like_type: "Videolink", link: self, likesit: true };
		else if ( self.id == "likeGame" )
			like = { id: game_id, like_type: "Game", link: self, likesit: true };

		$.ajax({
			contentType: "application/json",
			data: '{"id":' + like.id + ',"like_type":"' + like.like_type + '","likesit":' + like.likesit + '}',
			dataType: "json",
			processData: false,
			type: "POST",
			url: "/likes/vote",
			success: function(data) {
				toggleLink(data);
			}	
		});		

		return false;
	});

	$("#hateVideo,#hateGame").click(function() {
		var self = this;
		var like;

		if( self.id == "hateVideo" )
			like = { id: current_video["id"], like_type: "Videolink", link: self, likesit: false };
		else if ( self.id == "hateGame" )
			like = { id: game_id, like_type: "Game", link: self, likesit: false };

		$.ajax({
			contentType: "application/json",
			data: '{"id":' + like.id + ',"like_type":"' + like.like_type + '","likesit":' + like.likesit + '}',
			dataType: "json",
			processData: false,
			type: "POST",
			url: "/likes/vote",
			success: function(data) {
				toggleLink(data);
			}
		});		

		return false;
	});
	
});


function toggleLink(data) {
	if( data["like_type"] == "Game" ) {
		if( data["liked"] == 1 ) {
			$("#likeGame").addClass("gameLiked");
			$("#hateGame").removeClass("gameHated");
		} else if ( data["liked"] == -1 ) {
			$("#likeGame").removeClass("gameLiked");
			$("#hateGame").addClass("gameHated");
		} else {
			$("#likeGame").removeClass("gameLiked");
			$("#hateGame").removeClass("gameHated");
		}
	} else if( data["like_type"] == "Videolink" ) {		
		video_links[index]["liked"] = data["liked"];
				
		if( data["liked"] == 1 ) {
			$("#likeVideo").addClass("videoLiked");
			$("#hateVideo").removeClass("videoHated");
		} else if ( data["liked"] == -1 ) {
			$("#likeVideo").removeClass("videoLiked");
			$("#hateVideo").addClass("videoHated");
		} else {
			$("#likeVideo").removeClass("videoLiked");
			$("#hateVideo").removeClass("videoHated");
		}
	}	
}

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
	$("#video .youtube-player").attr({"width":"100%", "height":"700px"});
	current_video = video;

	if(video["liked"] == 1) {
		$("#likeVideo").addClass("videoLiked");
		$("#hateVideo").removeClass("videoHated");
	} else if( video["liked"] == -1 ) {
			$("#likeVideo").removeClass("videoLiked");
			$("#hateVideo").addClass("videoHated");
	} else {
		$("#likeVideo").removeClass("videoLiked");
		$("#hateVideo").removeClass("videoHated");
	}

	console.log("Liked", video["liked"]);
}

function showVideoInfo(number) {
	if( number > 0 )
		$("#video_info").html("Video " + (index + 1) + " of " + number);
	else
		$("#video_info").html("No videos added");
}



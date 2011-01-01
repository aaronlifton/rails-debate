function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).parent().hide();
  //$(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).before(content.replace(regexp, new_id));
}

(function($) {
	
	$.fn.defaultvalue = function() {
		
		// Scope
		var elements = this;
		var args = arguments;
		var c = 0;
		
		return(
			elements.each(function() {				
				
				// Default values within scope
				var el = $(this);
				var def = args[c++];

				el.val(def).focus(function() {
					if(el.val() == def) {
						el.val("");
					}
					el.blur(function() {
						if(el.val() == "") {
							el.val(def);
						}
					});
				});
				
			})
		);
	}
})(jQuery)

function select_side(e) {
	el = $("#" +e);
    $('.new_argument .side').removeClass('selected');
    el.addClass('selected');
    $("#"+e+" > input[type=radio]").attr('checked',true);
}

var toggleLoading = function(e) {
	//e = typeof(e) != 'undefined' ? e : "#"+e+"_loading";
	$("#" + e + "_loading").toggle();
};

var cancelReply = function(i) {
	$("#reply_"+i).children().remove();
};

var vote = function(i) {
	$.post("/arguments/"+i+"/vote", function(data) {
		data = JSON.parse(data);
		if (data.success == true) {
  			$("#score_"+i).html(data.score);
  		} else {
  			alert(data.error);
  		}
	});
};
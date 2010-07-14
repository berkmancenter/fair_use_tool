// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
// application.js
jQuery.noConflict();
//validation
jQuery.metadata.setType("attr", "validate");

jQuery(document).ready(function() {
        jQuery("#surveyForm").validate({
            errorElement: "div",
            wrapper: "div",  // a wrapper around the error message
            errorPlacement:  function(error, element) {
            element.before(error);
            offset = element.offset();
            error.css('left', offset.left);
            error.css('top', offset.top - element.outerHeight());
            }
        });
});

//ajax survey form links
function remove_fields(link) {
  $(link).previous("input[type=hidden]").value = "1";
  $(link).up(".fields").hide();
	jQuery('#accordion').accordion('destroy').accordion({ header: "h3", collapsible: true, autoHeight: false });
}

// function add_fields(link, association, content) {
//   var new_id = new Date().getTime();
//   var regexp = new RegExp("new_" + association, "g")
// }

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
	if (association == "questions"){
		jQuery('#accordion').append(content.replace(regexp, new_id)).accordion('destroy').accordion({ header: "h3", collapsible: true, autoHeight: false });
	}else{
	  $(link).up().insert({
	    before: content.replace(regexp, new_id)
	  });			
	}
}

//wizard

jQuery().ready(function(){
	var wizard = jQuery(".wizard").accordion({
				header: 'h3',
				event: false
			}).accordion('destroy').accordion({ header: "h3", collapsible: true, autoHeight: false });;

			var wizardButtons = jQuery([]);
			jQuery("h3", wizard).each(function(index) {
				wizardButtons = wizardButtons.add(jQuery(this)
				.next()
				.children(":button")
				.filter(".next, .previous")
				.click(function() {
					wizard.accordion("activate", index + (jQuery(this).is(".next") ? 1 : -1))
				}));
			});
});


//question_information
function open_explanation(survey_id, question_id){
	window.open("/survey_explanations/"+survey_id+"#question_"+question_id,"redRef",
	"height=540,width=380,channelmode=0,dependent=0," +
  "directories=0,fullscreen=0,location=0,menubar=0," +
  "resizable=0,scrollbars=1,status=1,toolbar=0" 
  );
};


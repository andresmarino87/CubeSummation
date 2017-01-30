// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

var ready;
ready = function() {
	hideLoading();
	$( '#input_test_data' ).submit(
		function( event ) {
			$( "#output" ).empty();
			showLoading();
			if ($( "#data_input").val() != ""){
				var data_input = {};
				data_input["data"] = $( "#data_input").val();
				data_input = JSON.stringify(data_input);
				$.ajax({
			    	type: 'POST',
			    	url: 'https://ruby-cube-summation.herokuapp.com/cube_summation',
			    	data: data_input,
			    	success: function(data) { 
			    		console.log(data.result);
						var outout = data.result.split('\n');
						$.each( outout, function( index, value ){
							$( "#output" ).append( value + "<br/>" );
						});
						hideLoading();
			    	},
			    	error: function() { 
       					hideLoading(); 
       					$( "#output" ).append( "Invalid format<br/>" );				
    				},
			    	contentType: "application/json",
			    	dataType: 'json'
				});
			}else{
				 hideLoading();
				$( "#output" ).append( "Please add input data<br/>" );				
			}
		event.preventDefault();
		}
	);

	function hideLoading(){
		$( "#loading" ).hide();
	}

	function showLoading(){
		$( "#loading" ).show();
	}
};

$(document).ready(ready);

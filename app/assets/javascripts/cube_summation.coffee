# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
	hideLoading()
	$('#input_test_data').submit -> 
		$( "#output" ).empty()
		showLoading()
		if ($( "#data_input").val() != "")
			data_input = {}
			data_input["data"] = $( "#data_input").val()
			data_input = JSON.stringify(data_input)
			$.ajax
				type: 'POST'
				url: 'https://ruby-cube-summation.herokuapp.com/cube_summation'
				dataType: 'json'
				data: data_input
				contentType: "application/json"
				error: (jqXHR, textStatus, errorThrown) -> 
					hideLoading()
					$( "#output" ).append "Invalid format<br/>"
				success: (data, textStatus, jqXHR) -> 
					outout = data.result.split('\n')
					$.each( outout, ( index, value ) ->
						$( "#output" ).append( value + "<br/>" )
					)
					hideLoading()
		else
			hideLoading()
			$( "#output" ).append "Please add input data<br/>" 
		false

hideLoading = () ->
	$( "#loading" ).hide()

showLoading = () ->
	$( "#loading" ).show()

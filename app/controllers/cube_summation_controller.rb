class CubeSummationController < ApplicationController
	include CubeSummationHelper
	def index
	end

	def create
		summation = ""
		@data = params[:data]
		t = @data.lines.first.to_i
		remove_first_line
		for i in 0..t-1
			values = @data.lines.first.split
			matrix_size = values[0].to_i;
			n_operations = values[1].to_i;
			remove_first_line
			summation += process_data(matrix_size, n_operations, @data);
			@data = remove_first_n_line(@data, n_operations)
		end
		render json: {result: summation}
	end

	private 
	def remove_first_line
		@data = remove_first_n_line @data, 1
	end
end

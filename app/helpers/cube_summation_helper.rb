module CubeSummationHelper
	#optimal solution Binary index Tree
	def stack
		@cube = Array.new
	end

	def remove_first_n_line(input, n)
		return input.lines[n..-1].join
	end

	def lowbit(i)
		return (i & -i)
	end

	def update(n, x, y, z, val)
		while(z <= n)
			x1 = x;
			while(x1 <= n) 
				y1 = y;
				while(y1 <= n) 
					@cube[x1][y1][z] += val;
					y1 += lowbit(y1);
				end
				x1 += lowbit(x1);
			end
			z += lowbit(z);
		end
	end

	def calculate_sum(x, y, z)
		sum = 0;
		while (z>0)
			x1=x;
			while(x1>0)
				y1=y;
				while(y1>0) 
					sum += @cube[x1][y1][z];
					y1 -= lowbit(y1);   
				end
				x1 -= lowbit(x1);
			end
			z -= lowbit(z);
		end
		return sum;
	end

	#Process data
	def process_data (n, m, data)
		result = ""
		@cube = Array.new(n+1){Array.new(n+1){Array.new(n+1,0)}};
		for i in 0..m-1
			command = data.lines.first;
			if(command.start_with?("QUERY")) then
				params = command.split;
				x0 = params[1].to_i;
				y0 = params[2].to_i;
				z0 = params[3].to_i;
				x = params[4].to_i;
				y = params[5].to_i;
				z = params[6].to_i;
				value1 = calculate_sum(x,y,z) - calculate_sum(x0-1,y,z) - calculate_sum(x,y0-1,z) + calculate_sum(x0-1,y0-1,z);
				value2 = calculate_sum(x,y,z0-1) - calculate_sum(x0-1,y,z0-1) - calculate_sum(x,y0-1,z0-1)  + calculate_sum(x0-1,y0-1,z0-1);
  				result += (value1 - value2).to_s + "\n"
			end

			if(command.start_with?("UPDATE")) then
				params = command.split;
				x = params[1].to_i;
				y = params[2].to_i;
				z = params[3].to_i;
				val = (params[4]).to_i;
				x0 = x;
				y0 = y;
				z0 = z ;
				if(x >= 1 && x <= n && 
	 				y >= 1     && y <= n && 
					z >= 1     && z <= n &&
					val >= -10e9 && val <= 10e9 ) then
					value1 = calculate_sum(x,y,z) - calculate_sum(x0-1,y,z) - calculate_sum(x,y0-1,z) + calculate_sum(x0-1,y0-1,z);
					value2 = calculate_sum(x,y,z0-1) - calculate_sum(x0-1,y,z0-1) - calculate_sum(x,y0-1,z0-1)  + calculate_sum(x0-1,y0-1,z0-1);
					update(n,x,y,z,(val -(value1 - value2 )));
				end
			end
			data = remove_first_n_line(data, 1)
		end
		return result
	end
end

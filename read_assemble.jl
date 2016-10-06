module trans
	type label
		label_name :: AbstractString
		index :: Int
	end

	type instruction
		op_code
		operand1
		operand2
	end

	function load_code(length_of_line::Int,code_arr)
	  label_arr = Array{label}(0)
	  instruction_arr = Array{instruction}(0)
	  for i = 1 : length_of_line

	  	j=1
	  	ith_line=code_arr[i]

	  	last = findfirst(ith_line, '\r')-1
		if last == -1
			last = length(ith_line)
		end
			
	  	k = findfirst(ith_line, ':')
	  	if k != 0

	  		push!(label_arr,label(ith_line[j:k-1],i))
	  		j=k+2

	  		k=findfirst(ith_line[j:last] , ' ')
	  		if k != 0
	  			temp1 = ith_line[j:j+k-2]
	  			j=j+k

	  			k=findfirst(ith_line[j:last], ',')
	  			if k != 0
	  				temp2 = strip(ith_line[j:j+k-2])
	  				j=j+k

	  				temp3=strip(ith_line[j:last])
	  				check=temp3[end-1:end]
	  				if check=="'d"
							temp3=hex(parse(temp3[1:end-2]))

	    			elseif (check=="'b")
								temp3=hex(parse("0b"*temp3[1:end-2]))
    				end

	  				push!(instruction_arr,instruction(temp1, temp2, temp3))
	  			else
						temp2 = strip(ith_line[j:last])
	  				push!(instruction_arr,instruction(temp1, temp2, ""))
	  			end
	  		else
	  			push!(instruction_arr,instruction(ith_line[j:last], "", ""))
	  		end

	  	else

	  		k=findfirst(ith_line[j:last] , ' ')
	  		if k != 0
	  			temp1 = ith_line[j:k-1]
	  			j=k+1

	  			k=findfirst(ith_line[j:last], ',')
	  			if k != 0
	  				temp2 = strip(ith_line[j:j+k-2])
	  				j=j+k

	  				temp3=strip(ith_line[j:last])
	  				check=temp3[end-1:end]

	  				if check=="'d"
							temp3=hex(parse(temp3[1:end-2]))

	    			elseif check=="'b"
							temp3=hex(parse("0b"*temp3[1:end-2]))
	    			end

	  				push!(instruction_arr,instruction(temp1, temp2,temp3))
	  			else
						temp2 = strip(ith_line[j:last])
	  				push!(instruction_arr,instruction(temp1, temp2, ""))
	  			end
	  		else
	  			push!(instruction_arr,instruction(ith_line[j:last], "", ""))
	  		end
	  	end
	  end
	  return label_arr,instruction_arr
	end

end

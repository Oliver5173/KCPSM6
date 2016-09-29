module trans
type label
	label_name :: String
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
  	eachline=code_arr[i]

  	last = findfirst(eachline, '\\')
  	k = findfirst(eachline, ':')
  	if k != 0

  		push!(label_arr,label(eachline[j:k-1],i))
  		j=k+2

  		k=findfirst(eachline[j:last] , ' ')
  		if k != 0
  			temp1 = eachline[j:k-1]
  			j=k+1

  			k=findfirst(eachline[j:last], ',')
  			if k != 0
  				temp2 = eachline[j:k-1]
  				j=k+1

  				temp3=eachline[j:last]
  				h=temp3[end-1:end]
  				if(h=="'d")
      				p=c[1:end-2]
      				p=parse(p)
      				output_string=hex(p)

    					elseif (h=="'b")
      				p=c[1:end-2]
      				p=string("0b",p)
      				output_string=parse(p)
      				output_string=string(output_string)
      				output_string=parse(output_string)
      				output_string=hex(output_string)
    				end
  				push!(instruction_arr,instruction(temp1, temp2,output_string))
  			else
  				push!(instruction_arr,instruction(temp1, temp2, ""))
  			end
  		else
  			push!(instruction_arr,instruction(eachline[j:last-1], "", ""))
  		end

  	else

  		k=findfirst(eachline[j:last] , ' ')
  		if k != 0
  			temp1 = eachline[j:k-1]
  			j=k+1

  			k=findfirst(eachline[j:last], ',')
  			if k != 0
  				temp2 = eachline[j:k-1]
  				j=k+1

  				temp3=eachline[j:last]
  				h=temp3[end-1:end]
  				if(h=="'d")
      				p=c[1:end-2]
      				p=parse(p)
      				output_string=hex(p)

    					elseif (h=="'b")
      				p=c[1:end-2]
      				p=string("0b",p)
      				output_string=parse(p)
      				output_string=string(output_string)
      				output_string=parse(output_string)
      				output_string=hex(output_string)
    				end
  				push!(instruction_arr,instruction(temp1, temp2,output_string))
  			else
  				push!(instruction_arr,instruction(temp1, temp2, ""))
  			end
  		else
  			push!(instruction_arr,instruction(eachline[j:last-1], "", ""))
  		end
  	end
  end
  return label_arr,instruction_arr
end

end

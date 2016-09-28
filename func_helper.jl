regs = ["s0","s1","s2","s3","s4","s5","s6","s7","s8","s9","sA","sB","sC","sD","sE","sF"]

function func_return(operation::String, operand1::String, operand2::String)
 if operation == 'LOAD'
   return
 end
end



function load(operand1, operand2,regs)
  if operand2 in regs
    return bank[operand2]
  else
  end
end

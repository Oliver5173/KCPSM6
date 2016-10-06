module pc
  global base_address = UInt8(0)
  global offset_address = UInt8(0)
  #pc = offset + base;
  global PC_Stack = Array{UInt8}(0)
  global PC_Stack_Level = 0;
  ##push function for call operator
  function push()
    if PC_Stack_Level < 60
      if offset_address < 255
        push!(PC_Stack,base_address)
        push!(PC_Stack,offset_address + 1)
      else
        push!(PC_Stack,base_address + 1)
        push!(PC_Stack,UInt8(0))
      end
      global PC_Stack_Level += 2
    else
      println("Memory OverFlow")
    end
  end
  function pop()
    if PC_Stack_Level > 0
      global PC_Stack_Level -= 2
      global offset_address =  pop!(PC_Stack)
      global base_address =  pop!(PC_Stack)
    else
      println("Memory Underflow")
    end
  end
  #isempty --> isempty(Array);
  #for jump@
  function address_calculator(sX::UInt8,sY::UInt8)
    global offset_address = sY
    if sX  < 16
      global base_address = sX
    else
      global base_address = UInt8(base_calc(sX))
    end
  end
  function base_calc(sX::UInt8)
    temp = sX
    num = [128,64,32,16]
    for i = 1 : 4
      if temp >= num[i]
        temp -= num[i]
      end
    end
    return UInt8(temp)
  end
  function pc_increase()
    if offset_address < 255
      global offset_address += 1
    else
      global offset_address = 0
      global base_address += 1
    end
  end
end

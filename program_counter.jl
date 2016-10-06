module pc
  global base_address = UInt8(0)
  global offset_address = UInt8(0)
  #pc = offset + base;
  global PC_Stack = Array{UInt8}(0)
  global PC_Stack_Level = 0;
  ##push function for call operator
  function push(x::UInt8,Level)
    if PC_Stack_Level < 60
      push!(PC_Stack,x)
      global PC_Stack_Level = Level + 1
    else
      println("Memory OverFlow")
    end
  end
  function pop(Level)
    if Level > 0
      global PC_Stack_Level = Level - 1
      return pop!(PC_Stack)
    else
      println("Memory Underflow")
    end
  end
  #isempty --> isempty(Array);
  function address_calculator(sX::UInt8,sY::UInt8)
    global base_address = sY
    if sX  < 16
      global offset_address = sX
    else
      global offset_address = UInt8(offset_calc(sX))
    end
  end
  function offset_calc(sX::UInt8)
    temp = sX
    num = [128,64,32,16]
    for i = 1 : 4
      if temp >= num[i]
        temp -= num[i]
      end
    end
    return UInt8(temp)
  end
end

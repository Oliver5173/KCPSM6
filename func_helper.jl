
function load(operand1,operand2,bankA,bankB)

  if(operand2[1] != "s")
    op2_type = UInt8
  else
    op2_type = String
  end
  #test operand overload

  if (op2_type == String)
    source_regester_index = parse(operand2[2]) + 1
    terminal_regester_index= parse(operand1[1]) + 1
    bankA[terminal_regester_index] = bankB[source_regester_index]
  else
    source_data = parse(String("0x",operand2))
    terminal_regester_index= parse(operand1[1]) + 1
    bankA[terminal_regester_index] = source_data
  end
end

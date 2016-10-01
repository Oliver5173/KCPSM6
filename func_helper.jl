
# Register Loading Functions

# LOAD -------------------------------------------------
function load(operand1,operand2,bank_a,bank_b,reg_bank)
  #register banks
  if (reg_bank =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != "s")
    op2_type = UInt8
  else
    op2_type = String
  end

  #make change in register
  if (op2_type == String)
    source_regester_index = parse(operand2[2]) + 1
    terminal_regester_index= parse(operand1[2]) + 1
    main_bank[terminal_regester_index] = main_bank[source_regester_index]
  else
    source_data = parse(string("0x",operand2))
    terminal_regester_index= parse(operand1[2]) + 1
    main_bank[terminal_regester_index] = source_data
  end
end


#STAR -----------------------------------------------------
function star(operand1, operand2, BankA, BankB, reg_bank)
  #register banks
  if (reg_bank =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != "s")
    op2_type = UInt8
  else
    op2_type = String
  end

  #make change in register
  if (op2_type == String)
    source_regester_index = parse(operand2[2]) + 1
    terminal_regester_index= parse(operand1[2]) + 1
    sub_bank[terminal_regester_index] = main_bank[source_regester_index]
  else
    source_data = parse(string("0x",operand2))
    terminal_regester_index= parse(operand1[2]) + 1
    sub_bank[terminal_regester_index] = source_data
  end
end

#Logical Functions

#AND
function and(operand1, operand2, BankA, BankB, reg_bank)
  #register banks
  if (reg_bank =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != "s")
    op2_type = UInt8
  else
    op2_type = String
  end

  # perform AND operation
  target_index = parse(operand1[2]) + 1
  if op2_type == UInt8
    main_bank[target_index] = (main_bank[target_index] & operand2)
  else
    op2_index = parse(operand2[2]) + 1
    main_bank[target_index] = (main_bank[target_index] & main_bank[op2_index])
  end
end

#OR
function or(operand1, operand2, BankA, BankB, reg_bank)
  #register banks
  if (reg_bank =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != "s")
    op2_type = UInt8
  else
    op2_type = String
  end

  # perform OR operation
  target_index = parse(operand1[2]) + 1
  if op2_type == UInt8
    main_bank[target_index] = (main_bank[target_index] | operand2)
  else
    op2_index = parse(operand2[2]) + 1
    main_bank[target_index] = (main_bank[target_index] | main_bank[op2_index])
  end
end

#XOR
function xor(operand1, operand2, BankA, BankB, reg_bank)
  #register banks
  if (reg_bank =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != "s")
    op2_type = UInt8
  else
    op2_type = String
  end

  # perform XOR operation
  target_index = parse(operand1[2]) + 1
  if op2_type == UInt8
    main_bank[target_index] = (main_bank[target_index] $ operand2)
  else
    op2_index = parse(operand2[2]) + 1
    main_bank[target_index] = (main_bank[target_index] $ main_bank[op2_index])
  end
end

#Arithmetic Functions
# add


#Scratch Pad Memory
# store
function store(operand1, operand2, BankA, BankB, flag, scratch)
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  value_index = parse(operand1[2]) + 1
  value = main_bank[value_index]
  if length(operand2) == 2
    index = "0x" * operand2
    target_index = dec(parse(index)) + 1
  else
    target_index = parse(opernad2[3]) + 1
  end

  if target_index > 64
    for i = 1:64
      if scratch[i] == 0
        target_index == i
      end
    end
  end
  scratch[target_index] = value
end

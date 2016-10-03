# operand: should be two strings and two banks-array and a flag type(whole flag)

# Register Loading Functions
# -------------------------------------------------
# LOAD (bug fixed)
function load(operand1,operand2,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = String
  end

  #make change in register
  if (op2_type == String)
    source_regester_index = parse("0x" * operand2[2:2]) + 1
    terminal_regester_index= parse("0x" * operand1[2:2]) + 1
    main_bank[terminal_regester_index] = main_bank[source_regester_index]
  else
    source_data = parse("0x"*operand2)
    terminal_regester_index= parse("0x"*operand1[2:2]) + 1
    main_bank[terminal_regester_index] = source_data
  end
end

#STAR (bug fixed)
function star(operand1, operand2, bank_a, bank_b, flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = String
  end

  #make change in register
  if (op2_type == String)
    source_regester_index = parse("0x" * operand2[2:2]) + 1
    terminal_regester_index= parse("0x" * operand1[2:2]) + 1
    sub_bank[terminal_regester_index] = main_bank[source_regester_index]
  else
    source_data = parse("0x"*operand2)
    terminal_regester_index= parse("0x"*operand1[2:2]) + 1
    sub_bank[terminal_regester_index] = source_data
  end
end

#Logical Functions
#------------------------------------------------------
#AND (bug fixed)
function and(operand1, operand2, bank_a, bank_b, flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = String
  end

  # perform AND operation
  target_index = parse("0x" * operand1[2:2]) + 1
  if (op2_type == UInt8)
    sourse_data = parse("0x" * operand2)
    main_bank[target_index] = main_bank[target_index] & source_data
  else
    op2_index = parse("0x" * operand2[2:2]) + 1
    main_bank[target_index] = (main_bank[target_index] & main_bank[op2_index])
  end

  #set zero flag
  if (main_bank[target_index] == 0)
    flag.Z = 1
  else
    flag.Z =0
  end
  flag.C =0
end

#OR (bug fixed)
function or(operand1, operand2, bank_a, bank_b, flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = String
  end

  # perform OR operation
  target_index = parse("0x"*operand1[2:2]) + 1
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)
    main_bank[target_index] = (main_bank[target_index] | source_data)
  else
    op2_index = parse("0x"*operand2[2:2]) + 1
    main_bank[target_index] = (main_bank[target_index] | main_bank[op2_index])
  end

  #set zero flag
  if (main_bank[target_index] == 0)
    flag.Z = 1
  else
    flag.Z = 0
  end
  flag.C =0
end

#XOR  (bug fixed)
function xor(operand1, operand2, bank_a, bank_b, flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = String
  end

  # perform XOR operation
  target_index = parse("0x"*operand1[2:2]) + 1
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)
    main_bank[target_index] = (main_bank[target_index] $ source_data)
  else
    op2_index = parse("0x"*operand2[2:2]) + 1
    main_bank[target_index] = (main_bank[target_index] $ main_bank[op2_index])
  end

  #set zero flag
  if (main_bank[target_index] == 0)
    flag.Z = 1
  else
    flag.Z = 0
  end
  flag.C =0
end

#Arithmetic Functions
#----------------------------------------------------------------
# add (bug fixed)
function add(operand1,operand2,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = String
  end

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]

  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = main_bank[source_index]
  end
  #do the operation
  temp = target_data + source_data

  #set zero flag
  if (temp == 0)
    flag.Z = 1
  else
    flag.Z =0
  end
  #set carry flag
  if (temp < source_data && temp < target_data)
    flag.C = 1
  else
    flag.C = 0
  end

  #store data
  main_bank[target_index] = temp
end

#addcy (bug fixed)
function addcy(operand1,operand2,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = String
  end

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]

  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = main_bank[source_index]
  end
  #do the operation
  temp = target_data + source_data + flag.C

  #set zero flag
  if (temp == 0)
    flag.Z = 1
  else
    flag.Z =0
  end
  #set carry flag
  if (temp < source_data && temp < target_data)
    flag.C = 1
  else
    flag.C = 0
  end

  #store data
  main_bank[target_index] = temp
end

#sub (bug fixed)
function sub(operand1,operand2,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = String
  end

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]

  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = main_bank[source_index]
  end
  #do the operation
  temp = target_data - source_data

  #set zero flag
  if (temp == 0)
    flag.Z = 1
  else
    flag.Z =0
  end
  #set carry flag
  if (target_data< source_data)
    flag.C = 1
  else
    flag.C = 0
  end

  #store data
  main_bank[target_index] = temp
end

#subcy (bug fixed)
function subcy(operand1,operand2,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = String
  end

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]

  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = main_bank[source_index]
  end
  #do the operation
  temp = target_data - source_data - flag.C

  #set zero flag
  if (temp == 0)
    flag.Z = 1
  else
    flag.Z =0
  end
  #set carry flag
  if (target_data < (source_data + falg.C))
    flag.C = 1
  else
    flag.C = 0
  end

  #store data
  main_bank[target_index] = temp
end

#Test and compare
#----------------------------------------------------------------
#test
#testcy
#compare
#comparecy

#Shift and Rotate
#----------------------------------------------------------------
#sl0
#sl1
#slx
#sla
#rl

#sr0
#sr1
#srx
#sra
#rr



#Scratch Pad Memory
#----------------------------------------------------------------
# store

function store(operand1, operand2, BankA, BankB, flag, scratch)
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a


  value_index = parse("0x"*operand1[2]) + 1
  value = main_bank[value_index]
  if length(operand2) == 2
    index = "0x" * operand2
    target_index = dec(parse(index)) + 1
  else
    target_index = parse("0x"*opernad2[3]) + 1
  end
    scratch[target_index] = value
end

#fetch
function fetch(operand1, operand2, BankA, BankB, flag, scratch)
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  target_index = parse(operand1[2]) + 1
  if length(operand2) == 2
    indec = "0x" * operand2
    value_index = dec(parse(index)) + 1
  else
    value_index = parsse("0x"*operand2[3]) + 1
  end
  main_bank[target_index] = scratch[value_index]
end

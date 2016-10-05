function output_reg(bank,flags)
  println("Z = ",flags.Z,"  C = ",flags.C,"  IE = ", flags.IE,"  REGBANK = ", flags.REGBANK)
  for i = [1,2]
    for j = 1:8
      print("s",uppercase(hex(i*j-1))," = ",bank[i*j],"  ")
    end
    println()
  end
end

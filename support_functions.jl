function output_reg(bank,flags)
  println("Z = ",flags.Z,"  C = ",flags.C,"  IE = ", flags.IE,"  REGBANK = ", flags.REGBANK)
  for j = 1:8
    print("s",uppercase(hex(j-1))," = 0x",hex(bank[j]),"  ")
  end
  println()
  for j = 1:8
    print("s",uppercase(hex(j+7))," = 0x",hex(bank[j+8]),"  ")
  end
  println()
end

function print_brand()
  println("  _  __ _____  _____    _____  __  __    __  | ")
  println(" | |/ // ____||  __ \\  / ____||  \\/  |  / /  | Welcome to")
  println(" | ' /| |     | |__) || (___  | \\  / | / /_  |    KCPSM6")
  println(" |  < | |     |  ___/  \\___ \\ | |\\/| || '_ \\ | Commands: ")
  println(" | . \\| |____ | |      ____) || |  | || (_) || r : shows registers value")
  println(" |_|\\_\\\\_____||_|     |_____/ |_|  |_| \\___/ | d : shows code ie.d,d[i],d[i:j]")
  println("                                             |")
end

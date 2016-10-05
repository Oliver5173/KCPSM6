function output_reg(bank,flags)
  println("Z = ",flags.Z,"  C = ",flags.C,"  IE = ", flags.IE,"  REGBANK = ", flags.REGBANK)
  for i = [1,2]
    for j = 1:8
      print("s",uppercase(hex(i*j-1))," = ",bank[i*j],"  ")
    end
    println()
  end
end

function print_brand()
  println("  _  __ _____  _____    _____  __  __    __  | ")
  println(" | |/ // ____||  __ \\  / ____||  \\/  |  / /  | Welcome to")
  println(" | ' /| |     | |__) || (___  | \\  / | / /_  |    KCPSM6")
  println(" |  < | |     |  ___/  \\___ \\ | |\\/| || '_ \\ |")
  println(" | . \\| |____ | |      ____) || |  | || (_) ||")
  println(" |_|\\_\\\\_____||_|     |_____/ |_|  |_| \\___/ |")
  println("                                             |")
end

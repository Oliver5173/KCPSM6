module reg
  Bank = Array{UInt8}(16)
  type flags
    Z :: Int
    C :: Int
    IE :: Int
    REGBANK :: Char
  end
end

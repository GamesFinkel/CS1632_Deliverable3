class Wallet
  attr_reader :owner
  attr_accessor :balance

  def initialize owner
    @owner = owner
    @balance = 0
  end

end


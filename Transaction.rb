class Transaction
    attr_reader :from
    attr_reader :dest
    def initialize from, dest, amount
        @from = from
        @dest = dest
        @amount = amount
    end

    def apply
        if @from != :SYSTEM
            @from.balance -= @amount
        end
        @dest.balance += @amount
    end
end

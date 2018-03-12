class Transaction
    attr_reader :from
    attr_reader :dest
    def initialize from, dest, amount
        @from = from
        @dest = dest
        @amount = amount
    end

#    def valid?
#        if @from == :SYSTEM
#            true
#        else
#            @from.balance >= @amount
#        end
#    end

    def apply
        if @from != :SYSTEM
            @from.balance -= @amount
        end
        @dest.balance += @amount
    end
end

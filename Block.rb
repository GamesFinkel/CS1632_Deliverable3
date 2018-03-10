class Block
    attr_reader :id
    attr_reader :transactions
    attr_reader :seconds
    attr_reader :nanoseconds
    attr_reader :expectedPreviousHash
    attr_reader :transactionString
    attr_reader :expectedBlockHash

    def initialize id, expectedPreviousHash, transaction_string,seconds,nanoseconds, expectedBlockHash
        @transactions = []
        @id = id
        @seconds = seconds
        @nanoseconds = nanoseconds
        @expectedPreviousHash = expectedPreviousHash
        @expectedBlockHash = expectedBlockHash
        @transactionString = transaction_string
    end

    def addTransaction transaction
        @transactions.push(transaction)
    end

    def moreRecentThan? otherBlock
        if otherBlock.seconds < @seconds
            true
        elsif otherBlock.seconds == @seconds and otherBlock.nanoseconds < @nanoseconds
            true
        else
            false
        end
    end

    def hash
        # TODO: Return a hash for this block
        string_to_hash = "#{id}|#{expectedPreviousHash}|#{transactionString}|#{seconds}.#{nanoseconds}"
        value = 0
        string_to_hash.unpack('U*').each do |x|
          value+=(x**2000)*((x+2)**21)-((x+5)**3)
        end
        (value%65536).to_s(16)
    end
end

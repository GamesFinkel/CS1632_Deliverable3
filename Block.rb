class Block
    attr_reader :id
    attr_reader :transactions
    attr_reader :seconds
    attr_reader :nanoseconds
    attr_reader :expectedPreviousHash

    def initialize id, expectedPreviousHash, seconds, nanoseconds, expectedBlockHash
        @transactions = []
        @id = id
        @seconds = seconds
        @nanoseconds = nanoseconds
        @expectedPreviousHash = expectedPreviousHash
        @expectedBlockHash = expectedBlockHash
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
        ""
    end
end

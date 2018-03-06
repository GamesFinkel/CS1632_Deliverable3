class Block
    attr_reader :id
    attr_reader :transactions
    attr_reader :timestamp
    attr_reader :expectedPreviousHash
    def initialize id, expectedPreviousHash, timestamp, expectedBlockHash
        @transactions = []
        @id = id
        @timestamp = timestamp
        @expectedPreviousHash = expectedPreviousHash
        @expectedBlockHash = expectedBlockHash
    end

    def addTransaction transaction
        @transactions.push(transaction)
    end

    def hash
        # TODO: Return a hash for this block
        ""
    end
end

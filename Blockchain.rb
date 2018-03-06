require_relative "Wallet"

class Blockchain
    attr_reader :wallets

    def initialize
        @wallets = {}
        @lastBlock = nil
    end

    def getWallet user
        if @wallets[user] == nil
            @wallets[user] = Wallet.new user
        end
        @wallets[user]
    end

    # Apply every transaction in the given block
    # Throws an exception when a failure is encountered
    def applyBlock block
        if @lastBlock == nil
            if block.expectedPreviousHash == 0
                raise "Invalid block: first block did not expect to be the first"
            end
        else
            if block.timestamp <= @lastBlock.timestamp
                raise "Invalid block: timestamp did not increase"
            end

#            if  block.expectedPreviousHash != @lastBlock.hash
#                raise "Invalid block: expected hash did not match previous"
#            end
        end

        block.transactions.each do |t|
            if !t.valid? 
                raise "Invalid transaction in block: #{t.from}'s balance is not high enough"
            end
            t.apply
        end

        @lastBlock = block
    end
end


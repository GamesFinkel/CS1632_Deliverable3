require_relative "Wallet"

class Blockchain
    attr_reader :wallets

    def initialize
        @wallets = {}
        @lastBlock = nil
    end

    def getWallet user
        if user == "SYSTEM"
            :SYSTEM
        else
            if @wallets[user] == nil
                @wallets[user] = Wallet.new user
            end
            @wallets[user]
        end
    end

    # Apply every transaction in the given block
    # Throws an exception when a failure is encountered
    def applyBlock block
        if @lastBlock == nil
            if block.id != 0 or block.expectedPreviousHash != 0
                raise "Invalid block: first block did not expect to be the first at block ID #{block.id}"
            end
        else
            if block.id <= @lastBlock.id
                raise "Invalid block: block ID did not increase #{block.id} <= #{@lastBlock.id}"
            end
            if not block.moreRecentThan? @lastBlock
                raise "Invalid block: timestamp did not increase on block ID #{block.id}"
            end

#            if  block.expectedPreviousHash != @lastBlock.hash
#                raise "Invalid block: expected hash did not match previous"
#            end
        end

        block.transactions.each do |t|
            if !t.valid?
                raise "Invalid transaction in block: #{t.from.owner}'s balance is not high enough at block ID #{block.id}"
            end
            t.apply
        end

        @lastBlock = block
    end
end


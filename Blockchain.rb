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
    def applyBlock block, lineNum
      if block.id != lineNum
        raise "Line #{lineNum}: Invalid block number #{block.id}, should be #{lineNum}"
      end
        if @lastBlock == nil
            if block.expectedPreviousHash != "0"
              raise 'Line 0: Invalid previous hash #{block.expectedPreviousHash}, should be 0'
            end
            if block.expectedBlockHash != block.hash
              raise "Line #{lineNum}: String \'#{block.toString}\' hash set to #{block.expectedBlockHash}, should be #{block.hash}"
            end
        else
            if not block.moreRecentThan? @lastBlock
              raise Error,"Line #{lineNum}: Previous timestamp #{@lastBlock.time} >= new timestamp #{block.time}"
            end
            if  block.expectedPreviousHash != @lastBlock.hash
              raise "Line #{lineNum}: Previous hash was #{block.expectedPreviousHash}, should be #{@lastBlock.hash}"
            end
            if block.expectedBlockHash != block.hash
              raise "Line #{lineNum}: String \'#{block.toString}\' hash set to #{block.expectedBlockHash}, should be #{block.hash}"
            end
        end

        block.transactions.each do |t|
            t.apply
        end
        @wallets.each do |w|
          if w[1].balance < 0
            raise "Line #{lineNum}: Invalid block, address #{w[1].owner} has #{w[1].balance.to_i} billcoins"
          end
        end
        @lastBlock = block
    end
end

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
        puts "Line #{lineNum}: Invalid block number #{block.id}, should be #{lineNum}"
        puts"BLOCKCHAIN INVALID"
        exit()
      end
        if @lastBlock == nil
            if block.expectedPreviousHash != "0"
              puts "Line 0: Invalid previous hash #{block.expectedPreviousHash}, should be 0"
              puts"BLOCKCHAIN INVALID"
              exit()
            end
            if block.expectedBlockHash != block.hash
              puts "Line #{lineNum}: String \'#{block.toString}\' hash set to #{block.expectedBlockHash}, should be #{block.hash}"
              puts"BLOCKCHAIN INVALID"
              exit()
            end
        else
            if not block.moreRecentThan? @lastBlock
              puts "Line #{lineNum}: Previous timestamp #{@lastBlock.time} >= new timestamp #{block.time}"
              puts"BLOCKCHAIN INVALID"
              exit()
            end
            if  block.expectedPreviousHash != @lastBlock.hash
              puts "Line #{lineNum}: Previous hash was #{block.expectedPreviousHash}, should be #{@lastBlock.hash}"
              puts"BLOCKCHAIN INVALID"
              exit()
            end
            if block.expectedBlockHash != block.hash
              puts "Line #{lineNum}: String \'#{block.toString}\' hash set to #{block.expectedBlockHash}, should be #{block.hash}"
              puts"BLOCKCHAIN INVALID"
              exit()
            end
        end

        block.transactions.each do |t|
            t.apply
        end
        @wallets.each do |w|
          if w[1].balance < 0
            puts "Line #{lineNum}: Invalid block, address #{w[1].owner} has #{w[1].balance.to_i} billcoins"
            puts"BLOCKCHAIN INVALID"
            exit()
          end
        end
        @lastBlock = block
    end
end

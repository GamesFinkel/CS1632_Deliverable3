#TODO Check argv length
#TODO check length after splits

require_relative "Blockchain"
require_relative "Block"
require_relative "Transaction"

blockchain = Blockchain.new

File.open(ARGV[0], "r").each_line do |line|
    blockText = line.split("|")
    if blockText.length == 5
        block = Block.new blockText[0].to_i, blockText[1], blockText[3].to_f, blockText[4]
        transactionRegex = /(.*)>(.*)\(([0-9]*)\)/
        blockText[2].split(":").each do | transactionText |
            transactionInfo = /(.*)>(.*)\(([0-9]*)\)/.match(transactionText)
            fromWallet = blockchain.getWallet transactionText[1]
            toWallet = blockchain.getWallet transactionText[2]

            transaction = Transaction.new fromWallet, toWallet, transactionText[3].to_f
            block.addTransaction transaction
        end

        blockchain.applyBlock block
    end
end

blockchain.wallets.each do |key, wallet|
    puts "#{wallet.owner} holds #{wallet.balance}" 
end


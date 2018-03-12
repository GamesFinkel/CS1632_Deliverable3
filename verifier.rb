#TODO Check argv length
#TODO check length after splits

require_relative "Blockchain"
require_relative "Block"
require_relative "Transaction"
if ARGV.size !=1
  puts "Incorrect number of arguments\nBLOCKCHAIN INVALID"
  exit()
end
blockchain = Blockchain.new

File.open(ARGV[0], "r").each_line do |line|
    blockText = line.chomp!.split("|")
    if blockText.length == 5
        timeText = blockText[3].split(".")
        sec = timeText[0].to_i
        nanoseconds = timeText[1].to_i

        block = Block.new blockText[0].to_i, blockText[1],blockText[2], sec, nanoseconds, blockText[4]
        blockText[2].split(":").each do | transactionText |
            transactionInfo = /(.*)>(.*)\(([0-9]*)\)/.match(transactionText)
            fromWallet = blockchain.getWallet transactionInfo[1]
            toWallet = blockchain.getWallet transactionInfo[2]

            transaction = Transaction.new fromWallet, toWallet, transactionInfo[3].to_f
            block.addTransaction transaction
        end

        blockchain.applyBlock block
    end
end

blockchain.wallets.each do |key, wallet|
    puts "#{wallet.owner} holds #{wallet.balance}"
end

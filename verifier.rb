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
  lineNum = 0
begin
    File.open(ARGV[0], "r").each_line do |line|
        begin
            blockText = line.chomp!.split("|")
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

            begin
                blockchain.applyBlock block,lineNum
            rescue StandardError => e
                puts e.message
                puts "BLOCKCHAIN INVALID"
                exit(1)
            end

            lineNum+=1
        rescue StandardError => e
            puts "Line #{lineNum}: Block format invalid on line"
            puts "BLOCKCHAIN INVALID"
            exit(1)
        end
    end
rescue StandardError => e
    puts "Failed to open file"
    exit(1)
end

blockchain.wallets.each do |key, wallet|
    puts "#{wallet.owner}: #{wallet.balance.to_i} billcoins"
end


require 'minitest/autorun'
require 'minitest/mock'

require_relative 'Transaction'
require_relative 'Wallet'

class TransactionTest < Minitest::Test
    def test_apply
        source = Wallet::new "Andrew"
        source.balance = 5
        destination = Wallet::new "James"

        transaction = Transaction::new source, destination, 1

        transaction.apply
        
        assert_equal 4, source.balance
        assert_equal 1, destination.balance
    end
end


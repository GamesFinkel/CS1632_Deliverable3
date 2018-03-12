require 'minitest/autorun'
require 'minitest/mock'

require_relative 'Blockchain'
require_relative 'Block'


class BlockchainTest < Minitest::Test

    def test_good_block
        blockA = Block.new 0, 0, 1, 1, '1c12'
        blockB = Block.new 1, '1c12', 1, 2, 'abb2'

        blockchain = Blockchain.new
        blockchain.applyBlock blockA
        blockchain.applyBlock blockB
    end

    def test_bad_start_block
        blockInit = Block.new 42, 0,"", 1, 0, ''

        blockchain = Blockchain.new
        assert_raises RuntimeError do
            blockchain.applyBlock blockInit
        end
    end

    def test_out_of_order_id
        blockInit = Block.new 0, 0,"", 1, 0, ''
        blockA = Block.new 2, blockInit.hash,"", 2, 0, ''
        blockB = Block.new 1, blockA.hash,"", 3, 0, ''

        blockchain = Blockchain.new
        blockchain.applyBlock blockInit
        blockchain.applyBlock blockA
        assert_raises RuntimeError do
            blockchain.applyBlock blockB
        end
    end

    def test_bad_timestamp
        blockA = Block.new 0, 0,"", 2, 0, ''
        blockB = Block.new 1, blockA.hash,"", 1, 0, ''

        blockchain = Blockchain.new
        blockchain.applyBlock blockA
        assert_raises RuntimeError do
            blockchain.applyBlock blockB
        end
    end
end

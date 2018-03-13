require 'stackprof'
require 'flamegraph'
Flamegraph.generate('flamegrapher.html') do
    require_relative 'verifier'
end


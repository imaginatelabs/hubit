require 'thor'

require 'hubit/version'
require 'commands/init'

# Hubit entry point of program
module Hubit
  class Hubit < Thor
    desc 'version', 'version number of hubit'
    def version
      puts VERSION.to_s
    end

    desc 'init SUBCOMMAND ARGS', 'blah'
    subcommand 'init', Init
  end
end

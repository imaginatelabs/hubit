require 'thor'

module Hubit
  class Init < Thor
    desc 'labels', 'initialize labels'
    def labels
      puts 'initializing labels'
    end
  end
end

require 'octokit'

module Hubit
  class GitHub
    def initialize(git_hub_client)
      @git_hub_client = git_hub_client
    end

    def add_labels(labels = [])
      labels.each do |label|
        @git_hub_client.add_label label
      end
    end
  end
end

module Hubit
  class LabelMaker
    def initialize(git_hub, hubit_config)
      @git_hub = git_hub
      @hubit_config = hubit_config
    end

    def create_new_labels
      @git_hub.add_labels hubit_config.labels
    end
  end
end

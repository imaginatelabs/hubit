require 'yaml'
require 'hubit/label_helper'

module Hubit
  class HubitConfig
    def initialize(plain_text_config)
      @yaml_config = YAML.load(plain_text_config)
    end

    def labels
      LabelHelper.new.transform_yaml_to_github_labels @yaml_config['labels']
    end
  end
end

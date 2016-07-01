module Hubit
  class LabelHelper
    def transform_yaml_to_github_labels(yaml_labels)
      labels = []
      initials = []
      yaml_labels.keys.each do |key|
        type = key
        yaml_label = yaml_labels[key]
        initial = generate_initial(type, yaml_label, initials)
        initials << initial
        default_color = yaml_label['color'] || 'ffffff'
        generate_label_hash(default_color, initial, labels, yaml_label)
      end
      labels
    end

    def generate_label_hash(default_color, initial, labels, yaml_label)
      yaml_label['names'].each do |name_hash|
        name_is_a_hash = name_hash.is_a?(Hash)
        labels << { name: "[ #{initial} ] #{name_is_a_hash ? name_hash.keys.first : name_hash}",
                      color: (name_is_a_hash ? name_hash.values.first : default_color).to_s }
      end
    end

    def generate_initial(type, yaml_label, initials)
      return yaml_label['initial'] if yaml_label['initial']
      initial = ''
      type.capitalize.each_char do |c|
        initial << c
        return initial unless initials.include? initial
      end
    end
  end
end

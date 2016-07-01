require 'spec_helper'
require 'yaml'

describe Hubit::LabelHelper do
  describe 'transform_yaml_to_github_labels' do
    subject { Hubit::LabelHelper.new.transform_yaml_to_github_labels yaml['labels'] }
    let(:yaml) do
      YAML.load(%(
labels:
  type:
    initial: 'T'
    color: ffffff
    names:
      - Story: 0e8a16
      - Tech Task: 1d76db
      - Other
))
    end

    context 'given a default color' do
      context 'when a specific color is set' do
        it 'sets the specific color' do
          expect(subject[0][:color]).to eq '0e8a16'
          expect(subject[1][:color]).to eq '1d76db'
        end
      end

      context 'when a specific color is not set' do
        it 'sets the default color' do
          expect(subject[2][:color]).to eq 'ffffff'
        end
      end
    end

    context 'given no default color and no specific color' do
      let(:yaml) do
        YAML.load(%(
labels:
  type:
    initial: 'T'
    names:
      - Other
))
      end

      it 'sets the default color' do
        expect(subject[0][:color]).to eq 'ffffff'
      end
    end

    context 'give names and initial are specified' do
      it 'sets the names with the initial' do
        expect(subject[0][:name]).to eq '[ T ] Story'
        expect(subject[1][:name]).to eq '[ T ] Tech Task'
        expect(subject[2][:name]).to eq '[ T ] Other'
      end
    end

    context 'give no initial is specified' do
      context 'give there are no conflicts of initial' do
        let(:yaml) do
          YAML.load(%(
labels:
  type:
    names:
      - Story
      - Tech Task
      - Other
  foo:
    names:
      - Bar
      - Baz
      - Mee
))
        end

        it 'sets the names with an initial taken from label types' do
          expect(subject[0][:name]).to eq '[ T ] Story'
          expect(subject[1][:name]).to eq '[ T ] Tech Task'
          expect(subject[2][:name]).to eq '[ T ] Other'
          expect(subject[3][:name]).to eq '[ F ] Bar'
          expect(subject[4][:name]).to eq '[ F ] Baz'
          expect(subject[5][:name]).to eq '[ F ] Mee'
        end
      end
    end

    context 'give there are conflicts of initial' do
      let(:yaml) do
        YAML.load(%(
labels:
  type:
    names:
      - Story
      - Tech Task
      - Other
  typos:
    names:
      - Bar
      - Baz
      - Mee
))
      end

      it 'sets the first initial as single then moves to double characters' do
        expect(subject[0][:name]).to eq '[ T ] Story'
        expect(subject[1][:name]).to eq '[ T ] Tech Task'
        expect(subject[2][:name]).to eq '[ T ] Other'
        expect(subject[3][:name]).to eq '[ Ty ] Bar'
        expect(subject[4][:name]).to eq '[ Ty ] Baz'
        expect(subject[5][:name]).to eq '[ Ty ] Mee'
      end
    end
  end
end

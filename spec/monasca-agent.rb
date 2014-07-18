# encoding: UTF-8

require_relative 'spec_helper'

describe 'monasca-agent' do
  describe 'ubuntu' do
    let(:runner) { ChefSpec::Runner.new(UBUNTU_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) { runner.converge(described_recipe) }

    it 'installs the monasca-agent package' do
      expect(chef_run).to upgrade_package 'monasca-agent'
    end

    it 'starts and enables the monasca-agent service' do
      expect(chef_run).to enable_service('monasca-agent')
      expect(chef_run).to start_service('monasca-agent')
    end
  end
end
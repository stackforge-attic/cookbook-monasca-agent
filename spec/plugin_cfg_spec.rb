# Encoding: utf-8
require_relative 'spec_helper'

describe 'monasca_agent::plugin_cfg' do
  describe 'ubuntu' do
    include_context 'monasca_stubs'
    let(:runner) { ChefSpec::Runner.new(UBUNTU_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) do
      node.set['monasca_agent']['plugin'] = 'monasca_agent'
      runner.converge(described_recipe)
    end
  end
end

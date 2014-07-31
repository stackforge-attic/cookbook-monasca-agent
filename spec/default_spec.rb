# Encoding: utf-8
require_relative 'spec_helper'

def nothing_execute(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:execute, :nothing, resource_name)
end

describe 'monasca_agent::default' do
  describe 'ubuntu' do
    include_context 'monasca_stubs'
    let(:runner) { ChefSpec::Runner.new(UBUNTU_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) do
      node.set['monasca']['data_bag'] = 'monasca_agent'
      runner.converge(described_recipe)
    end

    it 'includes the other recipes' do
      expect(chef_run).to include_recipe('python')
      expect(chef_run).to include_recipe('monasca_agent::plugin_cfg')
    end

    %w(python-pymongo python-yaml supervisor sysstat).each do |pkg|
      it "installs package #{pkg}" do
        expect(chef_run).to install_package pkg
      end
    end

    it 'python_pip installs monasca-agent' do
      expect(chef_run).to upgrade_python_pip 'monasca-agent'
    end

    it 'executes the monasca-setup program' do
      execute = chef_run.execute('monasca-setup')
      expect(execute).to do_nothing
    end

  end
end

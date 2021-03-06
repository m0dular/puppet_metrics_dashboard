require 'spec_helper'

describe 'puppet_metrics_dashboard::telegraf' do
  on_supported_os.each do |os, facts|
    context "with facter #{RSpec.configuration.default_facter_version} on #{os}" do
      let(:node) do
        'testhost.example.com'
      end

      let(:facts) do
        facts.merge(pe_server_version: '2017.2')
      end

      context 'with defaults' do
        let(:pre_condition) do
          <<-PRE_COND
            include puppet_metrics_dashboard
          PRE_COND
        end

        it { is_expected.to contain_class('puppet_metrics_dashboard::telegraf::config') }
        it { is_expected.to contain_class('puppet_metrics_dashboard::telegraf::service') }
      end

      context 'with enable_telegraf and configure_telegraf disabled' do
        let(:pre_condition) do
          <<-PRE_COND
            class {'puppet_metrics_dashboard':
              enable_telegraf    => false,
              configure_telegraf => false,
            }
          PRE_COND
        end

        it { is_expected.not_to contain_class('puppet_metrics_dashboard::telegraf::config') }
        it { is_expected.not_to contain_class('puppet_metrics_dashboard::telegraf::service') }
      end
    end
  end
end

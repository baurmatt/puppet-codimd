require 'spec_helper'
require 'deep_merge'

describe 'codimd::service' do
  context 'supported operating systems' do
    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) do
          os_facts
        end

        context 'with defaults' do
          it { is_expected.to compile.with_all_deps }

          it do
            is_expected.to contain_systemd__unit_file('codimd.service')
              .with_source('puppet:///modules/codimd/systemd.conf')
              .that_notifies('Service[codimd]') 
          end

          it do
            is_expected.to contain_service('codimd')
              .with_ensure('running')
              .with_enable(true)
          end
        end
      end
    end
  end
end

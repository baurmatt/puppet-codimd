require 'spec_helper'
require 'deep_merge'

describe 'codimd::user' do
  context 'supported operating systems' do
    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) do
          os_facts
        end

        context 'with defaults' do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_group('codimd').with_system(true) }

          it do
            is_expected.to contain_user('codimd')
              .with_home('/opt/codimd')
              .with_shell('/usr/sbin/nologin')
              .with_system(true)
          end
        end
      end
    end
  end
end

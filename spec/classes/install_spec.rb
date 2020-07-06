require 'spec_helper'
require 'deep_merge'

describe 'codimd::install' do
  context 'supported operating systems' do
    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) do
          os_facts
        end

        context 'with defaults' do
          let(:params) do
            {
              version: 'master',
              source: 'https://github.com/codimd/server.git',
            }
          end

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('nodejs') }

          it { is_expected.to contain_package('yarn').with_provider('npm') }

          it do
            is_expected.to contain_file('/opt/codimd')
              .with_ensure('directory')
              .with_owner('codimd')
              .with_group('codimd')
              .that_comes_before('Vcsrepo[/opt/codimd]')
          end

          it do
            is_expected.to contain_vcsrepo('/opt/codimd')
              .with_provider('git')
              .with_user('codimd')
              .with_group('codimd')
              .with_source('https://github.com/codimd/server.git')
              .with_revision('master')
              .that_comes_before('Exec[/opt/codimd/bin/setup]')
          end

          it do
            is_expected.to contain_exec('/opt/codimd/bin/setup')
              .with_cwd('/opt/codimd')
              .with_user('codimd')
              .with_group('codimd')
              .with_refreshonly(true)
          end
        end

        context 'with source => "https://gitlab.com/codimd/server.git"' do
          let(:params) do
            {
              version: 'master',
              source: 'https://gitlab.com/codimd/server.git',
            }
          end

          it { is_expected.to compile.with_all_deps }

          it do
            is_expected.to contain_vcsrepo('/opt/codimd')
              .with_source('https://gitlab.com/codimd/server.git')
          end
        end
      end
    end
  end
end

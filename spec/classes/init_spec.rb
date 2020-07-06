require 'spec_helper'

describe 'codimd' do
  context 'supported operating systems' do
    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) do
          os_facts
        end

        let(:pre_condition) do
          'include nodejs'
        end

        let(:default_config) do
          {
            'domain' => 'test.localhost',
            'db'     => {
              'username' => 'codimd',
              'password' => 'codimd',
              'database' => 'codimd',
              'host'     => 'localhost',
              'port'     => 3306,
              'dialect'  => 'mysql',
            },
          }
        end

        context 'with defaults' do
          let(:params) do
            {
              config: default_config,
            }
          end

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('codimd::user') }

          it do
            is_expected.to contain_class('codimd::install')
              .with_version('master')
              .that_comes_before('Class[codimd::config]')
              .that_notifies('Class[codimd::service]')
          end

          it do
            is_expected.to contain_class('codimd::config')
              .with_config(default_config)
              .that_notifies('Class[codimd::service]')
          end

          ['/opt/codimd/node_modules/.bin/sequelize db:migrate', 'npm run build'].each do |command|
            it do
              is_expected.to contain_exec(command)
                .with_cwd('/opt/codimd')
                .with_path(['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'])
                .with_user('codimd')
                .with_group('codimd')
                .with_refreshonly(true)
                .that_subscribes_to('Class[codimd::install]')
                .that_subscribes_to('Class[codimd::config]')
                .that_comes_before('Class[codimd::service]')
            end
          end

          it { is_expected.to contain_exec('npm run build') }

          it { is_expected.to contain_class('codimd::service') }
        end
      end
    end
  end
end

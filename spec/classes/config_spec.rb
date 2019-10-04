require 'spec_helper'
require 'deep_merge'

describe 'codimd::config' do
  context 'supported operating systems' do
    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) do
          os_facts
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
          let(:config) { {'sessionSecret' => 'testSecret'}.deep_merge(default_config) }
          let(:params) do
            {
              config: config,
            }
          end

          it { is_expected.to compile.with_all_deps }

          it do
            is_expected.to contain_file('/opt/codimd/config.json')
              .with_ensure('file')
              .with_owner('codimd')
              .with_group('codimd')
              .with_content(JSON.pretty_generate({production: config }) << "\n")
          end

          it do
            is_expected.to contain_file('/opt/codimd/.sequelizerc')
              .with_ensure('file')
              .with_owner('codimd')
              .with_group('codimd')
              .with_content(%r{^\s+'url':\s+'mysql://codimd:codimd@localhost:3306/codimd'$})
          end
        end

        context 'generates 64 char sessionSecret if not given' do
            let(:params) do
              {
                config: default_config,
              }
            end

            it { is_expected.to compile.with_all_deps }

            it do
              is_expected.to contain_file('/opt/codimd/config.json')
                .with_content(%r{\s+"sessionSecret": "[a-zA-Z0-9]{64}",$})
            end
        end
      end
    end
  end
end

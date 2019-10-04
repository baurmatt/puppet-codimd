require 'spec_helper'

describe 'Codimd::Dialect' do
  it { is_expected.to allow_value('mysql') }
  it { is_expected.to allow_value('mariadb') }
  it { is_expected.to allow_value('sqlite') }
  it { is_expected.to allow_value('postgres') }
  it { is_expected.to allow_value('mssql') }

  it { is_expected.not_to allow_value(:undef) }
  it { is_expected.not_to allow_value(nil) }
  it { is_expected.not_to allow_value('oracle') }
  it { is_expected.not_to allow_value('db2') }
end

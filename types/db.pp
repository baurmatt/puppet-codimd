type Codimd::Db = Struct[{
  username => String[1],
  password => String[1],
  database => String[1],
  host     => String[1],
  port     => Stdlib::Port,
  dialect  => Codimd::Dialect,
}]

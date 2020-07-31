MoneyRails.configure do |config|
  Money.use_i18n = false
  config.default_currency = :brl
  config.register_currency = {
      :id                  => :brl, 
      :priority            => 1,
      :iso_code            => "BRL",
      :name                => "Real",
      :symbol              => "R$",
      :symbol_first        => true,
      :subunit             => "Cent",
      :subunit_to_unit     => 2,
      :thousands_separator => ".",
      :decimal_mark        => ","
  }
end
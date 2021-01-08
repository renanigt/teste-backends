class Proponent
  attr_accessor :age, :monthly_income, :main

  def initialize(id:, name:, age:, monthly_income:, main:)
    @id = id
    @name = name
    @age = age
    @monthly_income = monthly_income
    @main = main
  end
end

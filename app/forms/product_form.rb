class ProductForm
  include ActiveModel::Model

  attr_accessor :name, :description, :price, :stock

  validates :name, :price, :stock, presence: { message: '%{attribute} must always be specified for %{model}' }
  validates :price, numericality: true
  validates :stock, numericality: { only_integer: true }

  def attributes
    {
      name: name,
      description: description,
      price: price,
      stock: stock
    }
  end
end

class MerchantrevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    (object/100.00).to_s
  end
end

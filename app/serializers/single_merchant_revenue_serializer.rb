class SingleMerchantRevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    '%.2f' % (object/100.00)
  end
end

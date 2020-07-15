class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :revenue

  attribute :revenue do |object, params|
    params[:revenue].round(2)
  end
end

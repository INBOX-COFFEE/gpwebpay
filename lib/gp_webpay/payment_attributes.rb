module GpWebpay
  class PaymentAttributes
    KEYS = %i(merchant_number operation order_number amount_in_cents currency deposit_flag redirect_url description merchant_description user_param)

    WS_KEYS = %i(message_id bank_id merchant_number order_number)

    REGULAR_PAYMENT_KEYS = %i(
      message_id bank_id merchant_number order_number master_order_number merchant_order_number amount_in_cents capture_flag
      card_holder.name card_holder.email card_holder.phone_country card_holder.phone card_holder.mobile_phone_country card_holder.mobile_phone
      address_match
      billing.name billing.address1 billing.city billing.postal_code billing.country
      shipping.name shipping.address1 shipping.city shipping.postal_code shipping.country
    )

    OPTIONAL_KEYS = %i(merchant_order_number description merchant_description)

    MASTER_KEYS = %i(user_param)

    def initialize(payment, ws_flag = false, type = "")
      @payment = payment
      @ws_flag = ws_flag
      @type = type
    end

    def keys
      case @payment.payment_type
      when "master"
        return (@ws_flag ? WS_KEYS : KEYS)
      when "recurring"
        case @type
        when "processRegularSubscriptionPayment"
          return REGULAR_PAYMENT_KEYS
        else
          return WS_KEYS
        end
      else
        return KEYS.reject { |k| MASTER_KEYS.include?(k) }
      end
    end

    def to_h
      keys.each_with_object({}) do |method, hash|
        method_chain = method.to_s.split(".").map(&:to_sym)
        if @payment.respond_to?(*method_chain)
          if method == :message_id
            hash[method] = @payment.public_send(method, @type)
          else
            hash[method] = method_chain.inject(@payment, :public_send)
          end
        elsif !OPTIONAL_KEYS.include?(method)
          method_missing(method)
        end

        hash
      end
    end
  end
end

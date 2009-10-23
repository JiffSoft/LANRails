class PaypalController < ApplicationController
  def ipn
    @ipn = Paypal::Notification.new(request.raw_post)

    if @ipn.acknowledge then
      # we paid, double check the amount
      reg = Registration.find(@ipn.item_id)
      reg.paypal_transid = @ipn.transaction_id
      party = Party.find(reg.party_id)
      if @ipn.amount >= party.price then
        reg.paid = true
      else
        # there's a mismatch here, TODO: log it somehow
      end
      reg.save
    end

    render :nothing => true
  end

end

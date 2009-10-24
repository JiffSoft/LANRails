class PaypalController < ApplicationController
  def ipn
    @ipn = Paypal::Notification.new(request.raw_post)

    if @ipn.acknowledge then
      # we paid, double check the amount
      reg = Registration.find(@ipn.item_id)
      reg.paypal_transid = @ipn.transaction_id
      party = Party.find(reg.party_id)
      user = User.find(reg.user_id)
      if @ipn.amount >= party.price then
        reg.paid = true
        # TODO send the user a thank you e-mail
      else
        # there's a mismatch here
        logger.warning("PayPalIPN") { "Received mismatched, yet valid, IPN for user #{reg.user_id}, reg #{reg.id}, transID #{@ipn.transaction_id}" }
        # TODO send the user an e-mail thanking them
        # but warning them that their payment
        # needs to be manually validated...
      end
      reg.save
    end

    render :nothing => true
  end

end

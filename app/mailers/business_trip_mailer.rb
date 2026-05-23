class BusinessTripMailer < ApplicationMailer
  def notification(business_trip, recipient_emails)
    @business_trip = business_trip
    @site = business_trip.site
    @user = business_trip.user

    mail(
      to: Array(recipient_emails),
      subject: "【出張報告】#{@site.name} の出張報告が作成されました"
    )
  end
end

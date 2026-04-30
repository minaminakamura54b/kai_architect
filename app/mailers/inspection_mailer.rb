class InspectionMailer < ApplicationMailer
  def notification(inspection, recipient_email)
    @inspection = inspection
    @site = inspection.site
    @user = inspection.user

    mail(
      to: recipient_email,
      subject: "【点検記録】#{@site.name} の点検が記録されました"
    )
  end
end

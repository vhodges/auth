class AlertsController < ApplicationController

  before_filter :dump_params
  before_filter :authenticate_member!

  #
  # Cashbook will (if configured to) send updates for categories that have a spending
  # target to this action to do with as the FI sees fit (typically to send out an emmail/sms)
  def budgetalert

    category = params[:category]      # Printable String
    total = params[:total]            # Printable String dollar amount
    percentage = params[:percentage]  # Printable String percentage
    remaining = params[:remaining]    # Printable String dollar amount
    overbudget = params[:overbudget]  # String "true" || "false"
    phones  = params[:phones]         # Comma separated string of phone id's
    emails  = params[:emails]         # Comma separated string of email id's
    sequence_id = params[:sequence_id]# Int with value for logging

    Rails.logger.info("budgetalert called")
    Rails.logger.info("#{phones}, #{emails}, #{category}, #{total}, #{percentage}, #{remaining}, #{(overbudget == "true")}")

    unless @current_member.nil?
      FinancialInstitutionConfig.send_alert(@current_member,
                                            sequence_id,
                                            phones,
                                            emails,
                                            category,
                                            total,
                                            percentage,
                                            remaining,
                                            (overbudget == "true"))
    else
      Rails.logger.warn("current_member is nil!")
    end

    render :text => "OK"
  end

  def dump_params
    Rails.logger.info("params = #{params.inspect}")
  end
end

class Payment < ActiveRecord::Base
    belongs_to :user
    def paypal_url(return_path)
        values = {
            business: "maheshwari.kajol-facilitator@gmail.com",
            cmd: "_xclick",
            upload: 1,
            return: "#{Rails.application.secrets.app_host}#{return_path}",
            invoice: id,
            amount: '100',
            item_name: "Kajol",
            item_number: "53",
            quantity: '1'
        }
        "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
end
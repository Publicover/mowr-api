module LoginHelpers
  def login_as_admin
    @admin = users(:admin)
    @valid_creds = { email: @admin.email, password: 'password' }.to_json
    post auth_login_path, headers: unauthorized_headers, params: @valid_creds
    @admin_headers = unauthorized_headers.merge('Authorization' => "#{json['auth_token']}")
  end

  def login_as_driver
    @driver = users(:driver)
    @valid_creds = { email: @driver.email, password: 'password' }.to_json
    post auth_login_path, headers: unauthorized_headers, params: @valid_creds
    @driver_headers = unauthorized_headers.merge('Authorization' => "#{json['auth_token']}")
  end

  def login_as_customer
    @customer = users(:customer)
    @valid_creds = { email: @customer.email, password: 'password' }.to_json
    post auth_login_path, headers: unauthorized_headers, params: @valid_creds
    @customer_headers = unauthorized_headers.merge('Authorization' => "#{json['auth_token']}")
  end
end

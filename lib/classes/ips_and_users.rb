require './models/user_ip'

class IpsAndUsers
  def initialize
    @result = ips_and_users
  end

  def errors

  end

  def result
    @result
  end

  private

  def ips_and_users
    Userip.pluck(:user_ip, :user_login).group_by(&:shift).transform_values(&:flatten)
  end
end
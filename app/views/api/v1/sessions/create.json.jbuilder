json.data do
  json.user do
    json.call(
      @user,
      :id,
      :email,
      :jti
    )
  end
end
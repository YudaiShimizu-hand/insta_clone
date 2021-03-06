puts "Users　のシードを投稿します ..."

10.times do
    # 苗字と名前の間の空白を削除したサッカー選手名（例:LionelMessi）を代入
    playername = Faker::Sports::Football.unique.player
    user = User.create(
        email: "#{playername.gsub(/[[:space:]]/, '')}@example.com",
        name: playername,
        password: 'password',
        password_confirmation: 'password'
    )
    puts "\"#{user.name}\" を作成した!"
end
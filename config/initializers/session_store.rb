Rails.application.config.session_store :redis_store, expire_after: 1.day, servers: {
    host: "localhost",
    port: 6379,
    #password: 'password', 今回は使わない
    db: 1,
    namespace: "session",
    signed: true, # 署名、暗号化されたcookieを使用する
    secure: true # HTTPS 接続でサーバーからクライアントにcookieが転送されるようにする
  }
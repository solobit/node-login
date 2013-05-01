ES = require("./email-settings")
EM = {}
module.exports = EM
EM.server = require("emailjs/email").server.connect(
  host: ES.host
  user: ES.user
  password: ES.password
  ssl: true
)
EM.dispatchResetPasswordLink = (account, callback) ->
  EM.server.send
    from: ES.sender
    to: account.email
    subject: "Password Reset"
    text: "something went wrong... :("
    attachment: EM.composeEmail(account)
  , callback

EM.composeEmail = (o) ->
  link = "http://node-login.braitsch.io/reset-password?e=" + o.email + "&p=" + o.pass
  html = "<html><body>"
  html += "Hi " + o.name + ",<br><br>"
  html += "Your username is :: <b>" + o.user + "</b><br><br>"
  html += "<a href='" + link + "'>Please click here to reset your password</a><br><br>"
  html += "Cheers,<br>"
  html += "<a href='http://twitter.com/braitsch'>braitsch</a><br><br>"
  html += "</body></html>"
  [
    data: html
    alternative: true
  ]

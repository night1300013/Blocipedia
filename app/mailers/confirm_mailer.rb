class ConfirmMailer < ApplicationMailer
  default from: "night1300013@hotmail.com"

  def confirm_mail(user)

     headers["Message-ID"] = "<#{user.email}@pure-shelf-78255.herokuapp.com>"
     headers["In-Reply-To"] = "<#{user.email}@pure-shelf-78255.herokuapp.com>"
     headers["References"] = "<#{user.email}@pure-shelf-78255.herokuapp.com>"

     @user = user

     mail(to: user.email, subject: "Thanks for signing up")
   end
end
